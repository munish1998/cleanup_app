import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? _token;

  String? get token => _token;

  Future init() async {
    final settings = await _requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _getToken();
      _registerForegroundMessageHandler();
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future _getToken() async {
    _token = await _firebaseMessaging.getToken();
    log("FCM token key: $_token");

    _firebaseMessaging.onTokenRefresh.listen((token) {
      _token = token;
      log("Token refreshed: $_token");
    });
  }

  Future<NotificationSettings> _requestPermission() async {
    return await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _registerForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log(" --- Foreground message received ---");
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Notification title: ${message.notification!.title}');
        log('Notification body: ${message.notification!.body}');
      }

      await showTextNotification(
        message.notification?.title ?? 'No title',
        message.notification?.body ?? 'No body',
        '#0909',
      );
    });
  }

  Future<void> showTextNotification(
    String title,
    String body,
    String orderID,
  ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: orderID,
    );
  }
}

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Background message: ${message.messageId}');
  log('Message data: ${message.data}');

  if (message.notification != null) {
    log('Notification title: ${message.notification!.title}');
    log('Notification body: ${message.notification!.body}');
  }

  await MessagingService().showTextNotification(
    message.notification?.title ?? 'No title',
    message.notification?.body ?? 'No body',
    '#0909',
  );
}
