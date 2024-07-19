import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 70,
          left: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              height: 8,
              width: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20), // Adjust as needed
            const Text(
              'Near by Cleaning',
              style: TextStyle(
                  color: AppColor.rank1Color,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                'In publishing and graph design lorem ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                'In publishing and graph design  ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                'Used to demonstrate the  ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            // Container(
            //   height: 50,
            //   width: 349,
            //   // color: Colors.blue,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10), color: Colors.blue),
            //   child: const Center(
            //       child: Text(
            //     'Next',
            //     style: TextStyle(color: Colors.white),
            //   )),
            // ),
            SizedBox(height: 20), // Adjust as needed

            const SizedBox(
              height: 55,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/image2.png',
                    width: double.infinity,
                  ),
                  //   VideoPlayerWidget(videoAsset: 'assets/images/video.mp4'),
                ), // Replace with your video asset
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      height: 8,
      width: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: index == 0 ? AppColor.rank1Color : Colors.grey,
      ),
    );
  }
}
