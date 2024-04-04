import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vitsllc_assignment_task/constants/collection_string.dart';
import 'package:vitsllc_assignment_task/constants/constant_list.dart';
import 'package:vitsllc_assignment_task/services/firestore_services.dart';
import 'package:vitsllc_assignment_task/services/hive_services.dart';
import 'package:vitsllc_assignment_task/utils/main_utils.dart';
import 'package:vitsllc_assignment_task/views/admin_home_screen.dart';
import 'package:vitsllc_assignment_task/views/employee_home_screen.dart';
import 'package:vitsllc_assignment_task/views/user_home_screen.dart';

class PhoneOTPVerification extends StatefulWidget {
  const PhoneOTPVerification({super.key});

  @override
  State<PhoneOTPVerification> createState() => _PhoneOTPVerificationState();
}

class _PhoneOTPVerificationState extends State<PhoneOTPVerification> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool visible = false;
  dynamic temp;
  String otpCreation = "";
  Map<String, dynamic> myUserData = {};

  @override
  void dispose() {
    phoneNumber.dispose();
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login/Signup"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          inputTextField("Contact Number", phoneNumber, context),
          visible
              ? inputTextField("OTP", otp, context)
              : const SizedBox.shrink(),
          !visible ? sendOTPButton("Send OTP") : submitOTPButton("Submit"),
        ],
      ),
    );
  }

  Widget sendOTPButton(String text) => ElevatedButton(
        onPressed: () async {
          await FirestoreServices.checkDocumentExistence(
                  CollectionString.usersCollection, phoneNumber.text)
              .then((value) async {
            if (value) {
              myUserData = (await FirestoreServices.getDoc(
                          CollectionString.usersCollection, phoneNumber.text))
                      .data() ??
                  {};
              if (myUserData["status"] == UsersStatus.active.name) {
                otpCreation = Random().nextInt(9999).toString();
                MainUtils.showBanner(context, "Your OTP is $otpCreation");
                setState(() {
                  visible = !visible;
                });
              } else {
                Fluttertoast.showToast(
                    msg:
                        "Your account is restrict by admin.Please contact them to enable it");
              }
            } else {
              Fluttertoast.showToast(msg: "THis Number is not yet registered");
            }
          });

          // temp = await FirebaseAuthentication().sendOTP(phoneNumber.text);
        },
        child: Text(text),
      );

  Widget submitOTPButton(String text) => ElevatedButton(
        onPressed: () {
          if (otp.text == otpCreation) {
            Fluttertoast.showToast(msg: "Login Successfuly");
            print(getUserHomeScreen(myUserData["role"]));
            MainUtils.closeBanner(context);
            HiveFunctions.createUser(myUserData);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return getUserHomeScreen(myUserData["role"]);
              },
            ));
            print(myUserData);
          } else {
            Fluttertoast.showToast(msg: "Invalid OTP");
          }
        },
        child: Text(text),
      );

  Widget getUserHomeScreen(String role) {
    if (role == UsersRole.user.name) {
      return const UserHomeScreen();
    } else if (role == UsersRole.admin.name) {
      return const HomeScreen();
    } else if (role == UsersRole.employee.name) {
      return const EmployeeHomeScreen();
    } else {
      return const UserHomeScreen();
    }
  }

  Widget inputTextField(String labelText,
          TextEditingController textEditingController, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(10.00),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextFormField(
            obscureText: labelText == "OTP" ? true : false,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: labelText,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
            ),
          ),
        ),
      );
}

class FirebaseAuthentication {
  String phoneNumber = "";

  sendOTP(String phoneNumber) async {
    this.phoneNumber = phoneNumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult result = await auth.signInWithPhoneNumber(
      '+91$phoneNumber',
    );
    printMessage("OTP Sent to +91 $phoneNumber");
    return result;
  }

  authenticate(ConfirmationResult confirmationResult, String otp) async {
    UserCredential userCredential = await confirmationResult.confirm(otp);
    userCredential.additionalUserInfo!.isNewUser
        ? printMessage("Authentication Successful")
        : printMessage("User already exists");
  }

  printMessage(String msg) {
    debugPrint(msg);
  }
}
