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

    // Initialize native Ios Notifications
    // final DarwinInitializationSettings initializationSettingsIOS =
    //     DarwinInitializationSettings();

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

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
    });
  }

  Future<String?> getToken() async {
    _token = await _firebaseMessaging.getToken();

    log("FCM: $_token");
    log('fcm token key =====>>>>>$_token');
    log('fcm refresh token key===>>>>>$token');

    _firebaseMessaging.onTokenRefresh.listen((token) {
      _token = token;
    });
    return _token;
  }

  Future<NotificationSettings> _requestPermission() async {
    return await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        announcement: false);
  }

  void _registerForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((remoteMessage) async {
      log(" --- foreground message received ---$_token");
      log('notification title${remoteMessage.data['title']}');
      //  log('notification title====>>>>${remoteMessage.data['title']}');
      log('notifiction title response===>>>>>>>>>>>>>${remoteMessage.notification!.title}');
      log('body response===>>>>${remoteMessage.notification!.body}');
      log('chat message response ====>>>${remoteMessage.notification!.android}');
      log('messageID response>>>====${remoteMessage.messageId}');
      log('message details ====>>>>${remoteMessage.data}');
      await showTextNotification('${remoteMessage.data['title']}',
          '${remoteMessage.data['body']}', '#0909');
    });
    // log('chat message notification response====>>>>${}')
  }

  Future<void> showTextNotification(
    String title,
    String body,
    String orderID,
  ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: orderID);
  }
}

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseMessaging.instance.getInitialMessage();
  log('A bg message just showed up :  ${message.messageId}');
  await MessagingService().showTextNotification(
      '${message.data['title']}', '${message.data['body']}', '#0909');
}
