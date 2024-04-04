// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class FirebaseAuthServices {
//   static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   static Future sendOTP(String phoneNumber) async {
//     try {
//       return firebaseAuth.signInWithPhoneNumber(phoneNumber);
//     } catch (e) {
//       if (e is FirebaseAuthException) {
//         Fluttertoast.showToast(msg: e.message ?? "Something went wrong");
//       } else {
//         Fluttertoast.showToast(msg: "Something went wrong");
//       }
//     }
//   }

//   static Future verifyOTP(String phoneNumber, String otp) async {
//     try {
//       return firebaseAuth.verifyPhoneNumber(
//           phoneNumber: phoneNumber,
//           verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
//           verificationFailed: (FirebaseAuthException error) {},
//           codeSent: (String verificationId, int? forceResendingToken) {},
//           codeAutoRetrievalTimeout: (String verificationId) {});
//     } catch (e) {
//       if (e is FirebaseAuthException) {
//         Fluttertoast.showToast(msg: e.message ?? "Something went wrong");
//       } else {
//         Fluttertoast.showToast(msg: "Something went wrong");
//       }
//     }
//   }
// }
