import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static addData(
      {required String collection,
      String? docId,
      required Map<String, dynamic> myData}) {
    final myDoc = firestore.collection(collection).doc(docId);
    myData["id"] = myDoc.id;
    return myDoc.set(myData);
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

  static Future<DocumentSnapshot<Map<String, dynamic>>> getDoc(
      String collectionPath, String documentId) {
    return FirestoreServices.firestore
        .collection(collectionPath)
        .doc(documentId)
        .get();
  }

  static Future<bool> checkDocumentExistence(
      String collectionPath, String documentId) async {
    try {
      // Get a reference to the document
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(documentId)
          .get();
      // Check if the document exists
      return documentSnapshot.exists;
    } catch (e) {
      print('Error checking document existence: $e');
      return false; // Return false in case of an error
    }
  }
}
