// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDB0S0OxXNp-vgoiGwTS0F2vsYjgh8GVoo',
    appId: '1:956177558277:web:a1359f0d6076f3dd56a56c',
    messagingSenderId: '956177558277',
    projectId: 'vitsllc-assignment',
    authDomain: 'vitsllc-assignment.firebaseapp.com',
    storageBucket: 'vitsllc-assignment.appspot.com',
    measurementId: 'G-LN56KZJKP8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvYt4Uc4op3I9Zn5UvpIeA75k6Cfv_cy4',
    appId: '1:956177558277:android:c62dddfb1c10083356a56c',
    messagingSenderId: '956177558277',
    projectId: 'vitsllc-assignment',
    storageBucket: 'vitsllc-assignment.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5KSmBFoZ1fkyrjY9VATQcR-0LaBYt_j8',
    appId: '1:956177558277:ios:4d378230cd6d625056a56c',
    messagingSenderId: '956177558277',
    projectId: 'vitsllc-assignment',
    storageBucket: 'vitsllc-assignment.appspot.com',
    iosBundleId: 'com.example.vitsllcAssignmentTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5KSmBFoZ1fkyrjY9VATQcR-0LaBYt_j8',
    appId: '1:956177558277:ios:2b5d9be388a7823356a56c',
    messagingSenderId: '956177558277',
    projectId: 'vitsllc-assignment',
    storageBucket: 'vitsllc-assignment.appspot.com',
    iosBundleId: 'com.example.vitsllcAssignmentTask.RunnerTests',
  );
}