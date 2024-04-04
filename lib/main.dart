import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vitsllc_assignment_task/views/admin_home_screen.dart';
import 'package:vitsllc_assignment_task/views/login_signup.dart';

import 'firebase_options.dart';
import 'services/local_notification.dart';
import 'services/shared_pref.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox(userHiveBox);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize();

    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //   print("Initial Message ${message.toString()}");
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   print("Message on App opened ${event.toString()}");
    // });
    // FirebaseMessaging.onMessage.listen((event) {
    //   print("Message when it is termation mode ${event.toString()}");
    //   if (event.notification != null) {
    //     LocalNotificationService.display(event);
    //   }
    // });
    LocalNotificationService.messageListener(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VITSLLC Assignment',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PhoneOTPVerification(),
    );
  }
}
