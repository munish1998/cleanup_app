import 'dart:developer';
import 'package:cleanup_mobile/Auth_Screen/Changepassword.dart';
import 'package:cleanup_mobile/Auth_Screen/Login.dart';
import 'package:cleanup_mobile/Auth_Screen/Register.dart';
import 'package:cleanup_mobile/Auth_Screen/Sendotp.dart';
import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/Auth_Screen/Verifyotp.dart';
import 'package:cleanup_mobile/Providers/allProviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipnap/launcher");
  DarwinInitializationSettings darwinInitializationSettings =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true);
  InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings);
  bool? initialized =
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  log('intialized===$initialized');
  // WidgetsFlutterBinding.ensureInitialized();
//  await notificationService.initialized();
  // AndroidInitializationSettings androidInitializationSettings =
  //     AndroidInitializationSettings("");
  // DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
  // InitializationSettings initializationSettings = InitializationSettings(
  //     android: androidInitializationSettings, iOS: iosSettings);
  // bool? isInitialized =
  //     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // log('isInitialized====>>>$isInitialized');
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
        home: LoginScreen(),
      ),
    );
  }
}
