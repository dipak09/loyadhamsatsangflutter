import 'dart:math';
import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class MessagingService {


  Future<void> showNotification({required RemoteMessage message}) async {
    print("firebase start");
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000000).toString(),
        'High Importance Notification',
        // 'myfxbay',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      // channel.description.toString(),
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
      channelShowBadge: true,
    );
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(
      Duration.zero,
          () {
        flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            notificationDetails);
      },
    );
    print("channnelID${channel.id.toString()}");
    print("channnelName${channel.name}");
    print("channnelName${channel.description}");
  }

  Future<void> initialLocalNotification(
      {required RemoteMessage message,required BuildContext context}) async {
    var androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {

        });
  }

  static String? fcmToken; // Variable to store the FCM token

  static final MessagingService _instance = MessagingService._internal();

  factory MessagingService() => _instance;

  MessagingService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init(BuildContext context) async {
    print("firebase start");
    // Requesting permission for notifications
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted notifications permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User granted  provisional notifications permission");
    } else {
      debugPrint("User denied notifications permission");
    }

    debugPrint(
        'User granted notifications permission: ${settings.authorizationStatus}');

    // Retrieving the FCM token
    fcmToken = await _fcm.getToken();
    print('fcmToken: $fcmToken');
    deviceToken = fcmToken.toString();

    // Handling background messages using the specified handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listening for incoming messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.notification!.title.toString()}');
      debugPrint('Notification data: ${message.data}');

      if (message.notification != null) {
        if (message.notification!.title != null &&
            message.notification!.body != null) {
          final notificationData = message.data;
          initialLocalNotification(message: message,context: context);
          showNotification(message: message);
        }
      }
    });

    // Handling the initial message received when the app is launched from dead (killed state)
    // When the app is killed and a new notification arrives when user clicks on it
    // It gets the data to which screen to open
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(context, message);
      }
    });

    // Handling a notification click event when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'onMessageOpenedApp: ${message.notification!.title.toString()}');
      _handleNotificationClick(context, message);
    });
  }

  // Handling a notification click event by navigating to the specified screen
  void _handleNotificationClick(BuildContext context, RemoteMessage message) {
    final notificationData = message.data;

    if (notificationData.containsKey('screen')) {
      final screen = notificationData['screen'];
      Navigator.of(context).pushNamed(screen);
    }
  }
}

// Handler for background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Future<void> showNotification({required RemoteMessage message}) async {
  //
  //   AndroidNotificationChannel channel = AndroidNotificationChannel(
  //       Random.secure().nextInt(1000000).toString(),
  //       'High Importance Notification',
  //       // 'myfxbay',
  //       importance: Importance.max
  //   );
  //   AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
  //     channel.id.toString(),
  //     channel.name.toString(),
  //     // channel.description.toString(),
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //     icon: '@mipmap/ic_launcher',
  //     channelShowBadge: true,
  //   );
  //   DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
  //       presentAlert: true,
  //       presentBadge: true,
  //       presentSound: true
  //   );
  //   NotificationDetails notificationDetails = NotificationDetails(
  //       android: androidNotificationDetails,
  //       iOS: darwinNotificationDetails
  //   );
  //   Future.delayed(Duration.zero,
  //         () {
  //       flutterLocalNotificationsPlugin.show(
  //           0,
  //           message.notification!.title.toString(),
  //           message.notification!.body.toString(),
  //           notificationDetails);
  //     },
  //   );
  // }
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   showNotification(message: message);
  // });
  debugPrint('Handling a background message: ${message.notification!.title}');
}
