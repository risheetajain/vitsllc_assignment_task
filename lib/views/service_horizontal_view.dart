import 'package:flutter/material.dart';
import 'package:vitsllc_assignment_task/constants/collection_string.dart';
import 'package:vitsllc_assignment_task/services/firestore_services.dart';
import 'package:vitsllc_assignment_task/views/tokens_list.dart';

class HorizontalServiceList extends StatefulWidget {
  const HorizontalServiceList({super.key});

  @override
  State<HorizontalServiceList> createState() => _HorizontalServiceListState();
}

class _HorizontalServiceListState extends State<HorizontalServiceList> {
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
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = snapshot.data.docs[index].data()
                                as Map<String, dynamic>;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const TokenList(),
                                ));
                              },
                              child: Container(
                                height: 100,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Title: ${item["title"]}'),
                                    Text('Status: ${item["status"]}'),
                                    Text('Description: ${item["description"]}'),
                                    // Add any other widgets or data fields you have
                                  ],
                                ),
                              ),
                            );
                          });
              }
            }));
  }
}
