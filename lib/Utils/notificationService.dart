// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:developer';

// Future<void> onbackgroundhandler(RemoteMessage message) async {
//   log('message received===>>>>${message.notification!.title.toString()}');
// }

// class notificationService {
//   static Future<void> initialized() async {
//     NotificationSettings notificationSettings =
//         await FirebaseMessaging.instance.requestPermission();
//     if (notificationSettings.authorizationStatus ==
//         AuthorizationStatus.authorized) {
//       log('notification initialized');
//       log('notitication process');
//       FirebaseMessaging.onBackgroundMessage(
//           (message) => onbackgroundhandler(message));
//       FirebaseMessaging.onMessage.listen((message) {
//         log('message received===>>>>${message.notification!.title.toString()}');
//         log('notification message ===>>>${message.notification!.body.toString()}');
//       });
//     }
//   }
// }
