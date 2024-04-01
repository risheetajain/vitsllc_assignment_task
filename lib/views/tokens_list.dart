import 'package:flutter/material.dart';
import 'package:vitsllc_assignment_task/constants/collection_string.dart';
import 'package:vitsllc_assignment_task/models/token_models.dart';
import 'package:vitsllc_assignment_task/services/firestore_services.dart';

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
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(18),
        child: StreamBuilder(
          stream: FirestoreServices.collectionStream(
              CollectionString.tokenCollection),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator.adaptive();
              case ConnectionState.none:
                return const Text("Please try after sometime");
              case ConnectionState.active:
              case ConnectionState.done:
                return SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child: Table(
                    children:
                        List.generate(snapshot.data.docs.length + 1, (index) {
                      if (index == 0) {
                        return const TableRow(children: [
                          Text(
                            "Token No.",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Job No.",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Vehicle Type",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Vehicle No.",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Status",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ]);
                      } else {
                        final myIndexData = TokenModel.fromJson(
                            snapshot.data.docs[index - 1].data()
                                as Map<String, dynamic>);
                        return TableRow(children: [
                          TableRowInkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (cotext) => TokenDetailScreen(
                                              tokenModel: myIndexData,
                                            )));
                              },
                              child: Text(myIndexData.tokenNo)),
                          Text(myIndexData.jobNo),
                          Text(myIndexData.vehicleType),
                          Text(myIndexData.vehicleNumber),
                          Text(myIndexData.status),
                        ]);
                      }
                    }),
                  ),
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
