import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vitsllc_assignment_task/constants/collection_string.dart';
import 'package:vitsllc_assignment_task/constants/constant_list.dart';
import 'package:vitsllc_assignment_task/models/token_models.dart';
import 'package:vitsllc_assignment_task/services/firestore_services.dart';
import 'package:vitsllc_assignment_task/views/common_widgets/custom_button.dart';
import 'package:vitsllc_assignment_task/views/common_widgets/custom_textfield_with_title.dart';

class CreateTokenScreen extends StatefulWidget {
  const CreateTokenScreen({super.key});

  @override
  State<CreateTokenScreen> createState() => _CreateTokenScreenState();
}

class _CreateTokenScreenState extends State<CreateTokenScreen> {
  TextEditingController tokenNo = TextEditingController();
  TextEditingController jobNo = TextEditingController();
  TextEditingController vehicleNo = TextEditingController();
  TextEditingController vehicleType = TextEditingController();
  TextEditingController userMobileNumber = TextEditingController();
  String? serviceSelected;

  getSequentialNumber() async {
    final futures = await Future.wait<QuerySnapshot<Map<String, dynamic>>>([
      FirestoreServices.getCollection(CollectionString.tokenCollection),
      FirestoreServices.getCollection(CollectionString.jobsCollection),
    ]);
    tokenNo.text = (futures[0].docs.length + 1).toString().padLeft(4, "0");
    jobNo.text = (futures[1].docs.length + 1).toString().padLeft(4, '0');
    setState(() {});
  }

  List<Map<String, dynamic>> myServicesList = [];
  @override
  void initState() {
    getSequentialNumber();
    FirestoreServices.getCollection(CollectionString.tokenCollection)
        .then((value) {
      List.generate(value.docs.length, (index) {
        final myIndexData = value.docs[index].data();
        myServicesList.add(myIndexData);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Token"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            CustomTextFieldWithTitle(
              hintText: "Token Number",
              readOnly: true,
              controller: tokenNo,
            ),
            CustomTextFieldWithTitle(
              hintText: "Job Number",
              controller: jobNo,
              readOnly: true,
            ),
            CustomTextFieldWithTitle(
              hintText: "Enter a vehicle Type",
              controller: vehicleType,
            ),
            CustomTextFieldWithTitle(
              hintText: "Vehicle No.",
              controller: vehicleNo,
            ),
            CustomTextFieldWithTitle(
              hintText: "User Mobile No.",
              controller: userMobileNumber,
            ),
            DropdownButtonFormField<String>(
                items: myServicesList
                    .map((e) => DropdownMenuItem<String>(
                          value: e["title"],
                          child: Text(e["title"] ?? ""),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    serviceSelected = val;
                  });
                }),
            CustomButton(
                title: "Create Token",
                onPressed: () {
                  if (serviceSelected == null) {
                    Fluttertoast.showToast(msg: "Please select service");
                    return;
                  }
                  FirestoreServices.addData(
                          collection: CollectionString.tokenCollection,
                          myData: TokenModel(
                                  service: serviceSelected!,
                                  status: StatusService.Waiting.name,
                                  tokenNo: tokenNo.text,
                                  jobNo: jobNo.text,
                                  vehicleType: vehicleType.text,
                                  vehicleNumber: vehicleNo.text,
                                  userMobile: userMobileNumber.text,
                                  createdAt: DateTime.now())
                              .toJson())
                      .then((_) {
                    Fluttertoast.showToast(
                        msg: "Token Generatwed SUccessfully");
                    getSequentialNumber();
                  });
                })
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    vehicleNo.dispose();
    vehicleType.dispose();
    jobNo.dispose();
    tokenNo.dispose();
    userMobileNumber.dispose();
    super.dispose();
  }
}
