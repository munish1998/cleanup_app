import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanup_mobile/Utils/screenConfiguration.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'dart:developer';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? _pref;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _pref = await SharedPreferences.getInstance();
    // Using Future.delayed to ensure the splash screen displays before checking login status
    Future.delayed(Duration(seconds: 3), () {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() async {
    // Retrieve access token from SharedPreferences
    String? accessToken = _pref?.getString(accessTokenKey);

    if (accessToken != null && accessToken.isNotEmpty) {
      log('login access token response ===>>>$accessToken');
      // Navigate to HomeScreen if token is valid
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false, // Remove all previous routes
      ); // This removes all previous routes
    } else {
      // Navigate to LoginScreen if no valid token is found
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Remove all previous routes
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return FlutterSplashScreen.fadeIn(
      onAnimationEnd: () {
        _checkLoginStatus;
      },
      animationDuration: Duration(seconds: 3),
      childWidget: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Image.asset(
            //   "assets/splashBg.png",
            //   fit: BoxFit.fill,
            //   width: double.infinity,
            // ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Image(
                        image: AssetImage(
                  'assets/images/image19.png',
                ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
