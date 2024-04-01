import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vitsllc_assignment_task/constants/collection_string.dart';
import 'package:vitsllc_assignment_task/constants/constant_list.dart';
import 'package:vitsllc_assignment_task/services/firestore_services.dart';
import 'package:vitsllc_assignment_task/views/common_widgets/custom_button.dart';
import 'package:vitsllc_assignment_task/views/common_widgets/custom_textfield_with_title.dart';

import '../constants/decoration.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services We Provide"),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.collectionStream(
            CollectionString.servicesCollection),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator.adaptive();
            case ConnectionState.none:
              return const Text("Please try after sometime");
            case ConnectionState.active:
            case ConnectionState.done:
              return snapshot.data.docs.isEmpty
                  ? const Center(
                      child: Text(
                        "No Services",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final myIndexData = snapshot.data.docs[index].data()
                            as Map<String, dynamic>;

                        return Card(
                          child: ListTile(
                            title: Text(myIndexData["title"] ?? ""),
                            subtitle: Text(myIndexData["description"] ?? ""),
                            trailing: Text(myIndexData["status"] ??
                                StatusService.Waiting.name),
                          ),
                        );
                      },
                    );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const AddNewServices();
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Create New Services"),
      ),
    );
  }
}

class AddNewServices extends StatefulWidget {
  const AddNewServices({
    super.key,
  });

  @override
  State<AddNewServices> createState() => _AddNewServicesState();
}

class _AddNewServicesState extends State<AddNewServices> {
  TextEditingController controller = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  StatusService? service;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextFieldWithTitle(
              hintText: "Service Name",
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (p0) {
                if (p0 == null && p0!.isEmpty) {
                  return "Please Enter Services Name";
                }
                return null;
              },
            ),
            CustomTextFieldWithTitle(
              hintText: "Service Description",
              controller: descriptionCont,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (p0) {
                if (p0 == null && p0!.isEmpty) {
                  return "Please Enter Services Description";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DropdownButtonFormField<StatusService>(
                  onChanged: (value) {
                    service = value;
                    setState(() {});
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (p0) {
                    if (p0 == null) {
                      return "Please Enter Services status ";
                    }
                    return null;
                  },
                  decoration: inputdecoration(context).copyWith(
                      hintText: 'Select Status', labelText: "Select Status"),
                  items: StatusService.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList()),
            ),
            CustomButton(
                title: "Create New Services",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirestoreServices.addData(
                        collection: CollectionString.servicesCollection,
                        myData: {
                          "title": controller.text,
                          "status": service!.name,
                          "description": descriptionCont.text
                        }).then((_) {
                      Fluttertoast.showToast(
                          msg: "Services Created Successfully");
                      Navigator.of(context).pop();
                    });
                  } else {
                    Fluttertoast.showToast(msg: "Please complete the form");
                  }
                })
          ],
        ),
      ),
    );
  }
}
