import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';

import 'package:cleanup_mobile/Providers/allProviders.dart';
import 'package:cleanup_mobile/SplashScreen/SplashScreen.dart';
import 'package:cleanup_mobile/Utils/messagingService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//MessagingService _msgService = MessagingService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //   // Replace with actual values
      //   options: FirebaseOptions(
      //     apiKey: "AIzaSyBtr4YxUIDzMARKWHJUjtKYJoCo3RUQQmw",
      //     appId: "1:30736213150:android:64ca324d5dea35c1a0078f",
      //     messagingSenderId: "30736213150",
      //     projectId: "cleanup-44c1b",
      );

  // await _msgService.init();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AllProviders().allProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cleanup',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
