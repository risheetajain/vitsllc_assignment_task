import 'dart:io';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../views/notification_dialog.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    InitializationSettings initializationSettingsAndroid =
        const InitializationSettings(
      android: AndroidInitializationSettings(
          "@drawable/ic_launcher"), //intialization setting  for android
      iOS: DarwinInitializationSettings(),
    );

    _notificationsPlugin.initialize(initializationSettingsAndroid,
        onDidReceiveNotificationResponse: (details) {
      if (details.input != null) {}
    }, onDidReceiveBackgroundNotificationResponse: (details) {
      print(details);
    });
  }

  static void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification!.body}');
        showDialog(
            context: context,
            builder: ((BuildContext context) {
              return DynamicDialog(
                  title: message.notification!.title,
                  body: message.notification!.body);
            }));
      }
    });
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      print(message.notification!.android!.sound);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            message.notification!.android!.sound ?? "Channel Id",
            message.notification!.android!.sound ?? "Main Channel",
            groupKey: "gfg",
            color: Colors.green,
            importance: Importance.max,
            sound: RawResourceAndroidNotificationSound(
                message.notification!.android!.sound ?? "gfg"),
            playSound: true,
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data['route']);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      RemoteMessage message) async {
    final String largeIconPath = await downloadAndSaveFile(
        message.notification!.android!.imageUrl!, 'largeIcon');
    final String bigPicturePath = await downloadAndSaveFile(
        message.notification!.android!.imageUrl!, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            hideExpandedLargeIcon: true,
            contentTitle: 'overridden <b>big</b> content title',
            htmlFormatContentTitle: false,
            summaryText: 'summary <i>text</i>',
            htmlFormatSummaryText: false);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'big text channel id', 'big text channel name',
            channelDescription: 'big text channel description',
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _notificationsPlugin.show(1, message.notification!.title,
        message.notification!.body, platformChannelSpecifics);
  }

  // static Future<void> notificationWithImage(RemoteMessage message) async {
  //   String? imageUrl;
  //   imageUrl ??= message.notification!.android?.imageUrl;
  //   imageUrl ??= message.notification!.apple?.imageUrl;

  //   final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //         id: id,
  //         icon: "resource://drawable/ic_launcher",
  //         channelKey: "Cricstock",
  //         title: message.notification!.title,
  //         body: message.notification!.body,
  //         bigPicture: imageUrl,
  //         notificationLayout: NotificationLayout.BigPicture,
  //         autoDismissible: true,
  //         color: Colors.green),
  //   );
  // }

  static Future<void> showNotification(String title, String body) async {
    // Create the notification
    await _notificationsPlugin.show(
      0, // Provide a unique ID for the notification
      title, // Title of the notification
      body,
      const NotificationDetails(), // Body of the notification

      payload: 'item x', // Optional payload
    );
  }
}
