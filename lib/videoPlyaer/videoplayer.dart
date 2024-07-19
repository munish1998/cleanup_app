// import 'package:cleanup_mobile/TutorialScreen/Tutorial.dart';
// import 'package:flutter/material.dart';

// import 'package:video_player/video_player.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Splash Screen',
//       theme: ThemeData.dark(),
//       home: VideoSplashScreen(),
//     );
//   }
// }

// class VideoSplashScreen extends StatefulWidget {
//   @override
//   _VideoSplashScreenState createState() => _VideoSplashScreenState();
// }

// class _VideoSplashScreenState extends State<VideoSplashScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/images/vide.mp4');
//     _initializeVideoPlayerFuture = _controller.initialize().then((_) {
//       setState(() {});
//       _controller.play();
//     });

//     _controller.addListener(() {
//       if (_controller.value.position >= _controller.value.duration) {
//         Future.delayed(Duration(seconds: 0), () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => TutorialScreen()),
//           );
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder(
//               future: _initializeVideoPlayerFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return SizedBox.expand(
//                     child: AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     ),
//                   );
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: Text(
//                   'Information about the app', // Replace this with your content
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://webpristine.com/work/cleanup/admin/vedio/vedio2.mp4'))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
      ),
    );
  }
}
