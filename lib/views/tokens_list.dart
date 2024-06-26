import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitsllc_assignment_task/constants/collection_string.dart';
import 'package:vitsllc_assignment_task/models/token_models.dart';
import 'package:vitsllc_assignment_task/services/firestore_services.dart';

import 'common_widgets/widgets.dart';
import 'services_details_screen.dart';

class TokenList extends StatelessWidget {
  const TokenList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services We Provide"),
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(18),
          child: StreamBuilder(
            stream: FirestoreServices.collectionStream(
                CollectionString.tokenCollection),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator.adaptive();
                case ConnectionState.none:
                  return const Text("Please try after sometime");
                case ConnectionState.active:
                case ConnectionState.done:
                  return Table(
                    border: TableBorder.all(),
                    children: List.generate(
                        (snapshot.data?.docs.length ?? 0) + 1, (index) {
                      if (index == 0) {
                        return TableRow(children: [
                          tableHeading(
                            "Token No.",
                          ),
                          tableHeading(
                            "Job No.",
                          ),
                          tableHeading(
                            "Vehicle Type",
                          ),
                          tableHeading(
                            "Vehicle No.",
                          ),
                          tableHeading(
                            "Status",
                          ),
                          tableHeading(
                            "Services",
                          ),
                        ]);
                      } else {
                        final myIndexData = TokenModel.fromJson(
                            snapshot.data?.docs[index - 1].data() ?? {});
                        return TableRow(children: [
                          TableRowInkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (cotext) => TokenDetailScreen(
                                              docId: snapshot.data
                                                      ?.docs[index - 1].id ??
                                                  "",
                                              tokenModel: myIndexData,
                                            )));
                              },
                              child: normalRow(myIndexData.tokenNo)),
                          normalRow(myIndexData.jobNo),
                          normalRow(myIndexData.vehicleType),
                          normalRow(myIndexData.vehicleNumber),
                          normalRow(myIndexData.status),
                          normalRow(myIndexData.service),
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
