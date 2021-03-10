import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("================== onBackgroundMessage: $message");
  return Future<void>.value();
}

Future onSelectNotification(String payload) async {}

class NotificationHandlerService {
  FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  static final NotificationHandlerService _singleton =
      NotificationHandlerService._internal();

  factory NotificationHandlerService() {
    return _singleton;
  }
  NotificationHandlerService._internal();

  initializeFcmNotification() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });
      _fcm.getToken().then((value) => log('$value'));
      _fcm.requestNotificationPermissions(
        IosNotificationSettings(
          sound: true,
          badge: true,
          alert: true,
        ),
      );
    }
    _fcm.getToken().then((value) => log('$value'));
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("---------------------On Message--------------------");
        displayNotification(
            message['notification']['title'], message['notification']['body']);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("---------------------On Lunch--------------------");
      },
      onResume: (Map<String, dynamic> message) async {
        print("---------------------On Resume--------------------");
      },
    );
  }

  void dispose() {
    iosSubscription.cancel();
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }

  void displayNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$body', platformChannelSpecifics,
        payload: 'item x');
  }
}
