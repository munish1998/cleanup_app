// import 'package:cleanup_mobile/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class SerializationScreen extends StatefulWidget {
//   const SerializationScreen({super.key});

//   @override
//   State<SerializationScreen> createState() => _SerializationScreenState();
// }

// class _SerializationScreenState extends State<SerializationScreen> {
//   void showNotification() async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             "Notification check", "Notification cleanupApp",
//             priority: Priority.max, importance: Importance.max);
//     DarwinNotificationDetails IosDetails = DarwinNotificationDetails(
//         presentAlert: true, presentSound: true, presentBadge: true);
//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: IosDetails);

//     DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));
//     await flutterLocalNotificationsPlugin.show(
//         0, 'this is cleanupapp', 'test local notification', notificationDetails,
//         payload: "notificatio-payload");
//   }

//   void checkNotification() async {}

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('json data'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showNotification,
//         child: Icon(Icons.notification_add),
//       ),
//     );
//   }
// }
