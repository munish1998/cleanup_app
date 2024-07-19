// import 'package:flutter/material.dart';
// import 'package:garden_cleaning_app/Splashscreen/SplashScreen.dart';
// import 'package:garden_cleaning_app/TutorialScreen/TutorialScreen1.dart';
// import 'package:garden_cleaning_app/TutorialScreen/Tutorial_Screen.dart';
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
//       body: Stack(
//         children: [
//           FutureBuilder(
//             future: _initializeVideoPlayerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return SizedBox.expand(
//                   child: AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: VideoPlayer(_controller),
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//               padding: EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       _controller.value.isPlaying
//                           ? Icons.pause
//                           : Icons.play_arrow,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         if (_controller.value.isPlaying) {
//                           _controller.pause();
//                         } else {
//                           _controller.play();
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:Cleanup_app/TutorialScreen/Tutorial_Screen.dart';
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
