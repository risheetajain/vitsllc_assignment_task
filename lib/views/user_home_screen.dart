import 'package:flutter/material.dart';
import 'package:vitsllc_assignment_task/services/firestore_services.dart';
import 'package:vitsllc_assignment_task/services/hive_services.dart';
import 'package:vitsllc_assignment_task/views/login_signup.dart';

import '../constants/collection_string.dart';
import '../models/token_models.dart';
import 'common_widgets/widgets.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  Map<String, dynamic> myUserData = {};
  @override
  void initState() {
    myUserData = HiveFunctions.getAllUsers().first;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("MY USERDATA $myUserData");
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhoneOTPVerification(),
                    ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(18),
          child: StreamBuilder(
            stream: FirestoreServices.firestore
                .collection(CollectionString.tokenCollection)
                .where("user_mobile", isEqualTo: myUserData["phone"])
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator.adaptive();
                case ConnectionState.none:
                  return const Text("Please try after sometime");
                case ConnectionState.active:
                case ConnectionState.done:
                  return Table(
                    border: TableBorder.all(),
                    children:
                        List.generate(snapshot.data.docs.length + 1, (index) {
                      if (index == 0) {
                        return TableRow(children: [
                          tableHeading(
                            "Token No.",
                          ),
                          // Text(
                          //   "Job No.",
                          //   style: TextStyle(
                          //       fontSize: 18, fontWeight: FontWeight.w500),
                          // ),
                          // Text(
                          //   "Vehicle Type",
                          //   style: TextStyle(
                          //       fontSize: 18, fontWeight: FontWeight.w500),
                          // ),
                          tableHeading(
                            "Vehicle No.",
                          ),
                          // Text(
                          //   "Status",
                          //   style: TextStyle(
                          //       fontSize: 18, fontWeight: FontWeight.w500),
                          // ),
                          tableHeading(
                            "Services",
                          ),
                          tableHeading("Time")
                        ]);
                      } else {
                        final myIndexData = TokenModel.fromJson(
                            snapshot.data.docs[index - 1].data()
                                as Map<String, dynamic>);
                        return TableRow(children: [
                          normalRow(myIndexData.tokenNo),
                          normalRow(myIndexData.vehicleNumber),
                          normalRow(myIndexData.status),
                          normalRow(
                              "${(myIndexData.endTime ?? DateTime.now()).difference(myIndexData.startTime ?? DateTime.now()).inMinutes} Minutes"),
                        ]);
                      }
                    }),
                  );

                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
