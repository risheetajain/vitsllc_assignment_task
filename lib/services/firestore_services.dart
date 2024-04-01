import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static addData(
      {required String collection,
      String? docId,
      required Map<String, dynamic> myData}) {
    return firestore.collection(collection).doc(docId).set(myData);
  }

  static updateData(
      {required String collection,
      String? docId,
      required Map<String, dynamic> myData}) {
    return firestore.collection(collection).doc(docId).update(myData);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream(
      String collection) {
    return FirestoreServices.firestore.collection(collection).snapshots();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getCollection(
      String collection) {
    return FirestoreServices.firestore.collection(collection).get();
  }
}
