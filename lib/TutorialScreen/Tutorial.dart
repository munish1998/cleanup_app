import 'package:cleanup_mobile/Auth_Screen/Login.dart';
import 'package:cleanup_mobile/Auth_Screen/SignUp.dart';
import 'package:cleanup_mobile/TutorialScreen/Tutorial1.dart';
import 'package:cleanup_mobile/TutorialScreen/Tutorial2.dart';
import 'package:cleanup_mobile/TutorialScreen/Tutorial3.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // Set width of the container
        child: Stack(
          children: [
            PageView(
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              controller: _controller,
              children: const [IntroScreen3()],
              // children: const [IntroScreen1(), IntroScreen2(), IntroScreen3()],
            ),
            Positioned(
              top: 335,
              left: 170,
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildIndicator(0),
                    buildIndicator(1),
                    buildIndicator(2),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 25),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 390,
              left: MediaQuery.of(context).size.width / 2 -
                  170, // Adjust the positioning
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                  // if (_currentPage < 2) {
                  //   _controller.nextPage(
                  //     duration: const Duration(milliseconds: 500),
                  //     curve: Curves.easeIn,
                  //   );
                  // } else {
                  //   Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (_) => const MyWidget()),
                  //   );
                  // }
                },
                child: Container(
                  width: 349,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.rank1Color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      height: 8,
      width: _currentPage == index ? 8 : 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: _currentPage == index ? AppColor.rank1Color : Colors.grey,
      ),
    );
  }
}
