// import 'dart:async';
// import 'dart:math';
// import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
// import 'package:cleanup_mobile/Utils/commonMethod.dart';
// import 'package:cleanup_mobile/videoPlyaer/tutorialpage.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   bool _isAnimationCompleted = false;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );

//     _animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     _controller.forward().then((_) {
//       setState(() {
//         _isAnimationCompleted = true;
//       });
//     });

//     // After 5 seconds, navigate to the TutorialScreen
//     Timer(const Duration(seconds: 5), () {
//       navPush(context: context, action: LoginScreen());
// Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(
//       builder: (context) => TutorialPage(
//             videoAsset:
//                 'https://webpristine.com/work/cleanup/admin/vedio/vedio1.mp4',
//             infoText: 'Welcome to cleanup mobile',
//           )),
// );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: Colors.white,
//             child: Center(
//               child: Image.asset(
//                 'assets/images/image19.png',
//                 scale: 2,
//               ),
//             ),
//           ),
//           AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               double verticalPosition =
//                   MediaQuery.of(context).size.height * _animation.value * 0.8;
//               double angle = _animation.value * 2 * pi;
//               double horizontalPosition = 50 * sin(angle);

//               return Stack(
//                 children: [
//                   Container(
//                     color: _isAnimationCompleted
//                         ? Colors.lightBlue.shade300
//                         : Colors.transparent,
//                   ),
//                   Positioned(
//                     top: verticalPosition,
//                     left: MediaQuery.of(context).size.width * 0.5 +
//                         horizontalPosition,
//                     right: MediaQuery.of(context).size.width * 0.5 -
//                         horizontalPosition,
//                     child: Container(
//                       height: 100,
//                       color: Colors.lightBlue.shade300,
//                     ),
//                   ),
//                   if (_isAnimationCompleted)
//                     Center(
//                       child: Image.asset(
//                         'assets/images/image20.png',
//                         scale: 2,
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

import 'dart:async';
import 'dart:math';
import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanup_mobile/videoPlyaer/tutorialpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isAnimationCompleted = false;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _init();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward().then((_) {
      setState(() {
        _isAnimationCompleted = true;
      });
      _navigateToNextScreen();
    });
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _navigateToNextScreen() {
    if (_prefs!.getBool(isInitKey) ?? false) {
      if (_prefs!.getBool(isUserLoginKey) ?? false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TutorialPage(
            videoAsset:
                'https://webpristine.com/work/cleanup/admin/vedio/vedio1.mp4',
            infoText: 'Welcome to cleanup mobile',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double verticalPosition = MediaQuery.of(context).size.height *
                  (0.5 - 0.5 * _animation.value);
              double opacity = 1 - _animation.value;

              return Stack(
                children: [
                  CustomPaint(
                    size: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height,
                    ),
                    painter: WavePainter(_animation.value),
                  ),
                  if (_animation.value == 1.0) // When animation completes
                    Container(
                      color: Colors.lightBlue.shade300,
                    ),
                  Positioned(
                    top: verticalPosition,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Opacity(
                        opacity: opacity,
                        child: Image.asset(
                          'assets/images/image19.png',
                          scale: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          if (_isAnimationCompleted && _animation.value == 1.0)
            Center(
              child: Image.asset(
                'assets/images/image20.png',
                scale: 2,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlue.shade300
      ..style = PaintingStyle.fill;

    final path = Path();
    final height = size.height;
    final width = size.width;

    // The y position of the waves
    double waveHeight1 = height * (1 - animationValue);
    double waveHeight2 = height * (1 - animationValue) - height * 0.2;

    // Draw the first wave
    path.moveTo(0, waveHeight1);
    double amplitude1 = 50.0;
    double waveFrequency1 = 2 * pi / width * 3;

    for (double i = 0; i <= width; i++) {
      path.lineTo(i, waveHeight1 - amplitude1 * sin(waveFrequency1 * i));
    }

    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    // Draw the second wave
    path.moveTo(0, waveHeight2);
    double amplitude2 = 70.0;
    double waveFrequency2 = 2 * pi / width * 2.5;

    for (double i = 0; i <= width; i++) {
      path.lineTo(i, waveHeight2 - amplitude2 * sin(waveFrequency2 * i));
    }

    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
