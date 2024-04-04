import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vitsllc_assignment_task/constants/collection_string.dart';
import 'package:vitsllc_assignment_task/constants/constant_list.dart';

import '../constants/decoration.dart';
import '../services/firestore_services.dart';
import 'common_widgets/custom_button.dart';
import 'common_widgets/custom_textfield_with_title.dart';

class AddNewUsers extends StatefulWidget {
  const AddNewUsers({
    super.key,
  });

  @override
  State<AddNewUsers> createState() => _AddNewUsersState();
}

class _AddNewUsersState extends State<AddNewUsers> {
  TextEditingController controller = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  UsersRole? service;
  UsersStatus? status;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextFieldWithTitle(
                hintText: "User Name",
                controller: controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (p0) {
                  if (p0 == null && p0!.isEmpty) {
                    return "Please Enter User Name";
                  }
                  return null;
                },
              ),
              CustomTextFieldWithTitle(
                hintText: "User Mobile Number",
                controller: phoneCont,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (p0) {
                  if (p0 == null && p0!.isEmpty) {
                    return "Please Enter Users Description";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<UsersRole>(
                    onChanged: (value) {
                      service = value;
                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (p0) {
                      if (p0 == null) {
                        return "Please Enter Users Role ";
                      }
                      return null;
                    },
                    decoration: inputdecoration(context).copyWith(
                        hintText: 'Select Role', labelText: "Select Role"),
                    items: UsersRole.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<UsersStatus>(
                    onChanged: (value) {
                      status = value;
                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (p0) {
                      if (p0 == null) {
                        return "Please Enter Users status ";
                      }
                      return null;
                    },
                    decoration: inputdecoration(context).copyWith(
                        hintText: 'Select Status', labelText: "Select Status"),
                    items: UsersStatus.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList()),
              ),
              CustomButton(
                  title: "Create New Users",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirestoreServices.addData(
                          collection: CollectionString.usersCollection,
                          docId: phoneCont.text,
                          myData: {
                            "name": controller.text,
                            "role": service!.name,
                            "phone": phoneCont.text,
                            "status": status!.name
                          }).then((_) {
                        Fluttertoast.showToast(
                            msg: "Users Created Successfully");
                        Navigator.of(context).pop();
                      });
                    } else {
                      Fluttertoast.showToast(msg: "Please complete the form");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
