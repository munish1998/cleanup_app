import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/Auth_Screen/SignUp.dart';
import 'package:cleanup_mobile/videoPlyaer/tutorialpage1.dart';
import 'package:cleanup_mobile/videoPlyaer/tutorialpage2.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TutorialPage2 extends StatelessWidget {
  final String videoAsset;
  final String infoText;
  final VoidCallback? onComplete;
  TutorialPage2(
      {required this.videoAsset, required this.infoText, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          VideoPlayerWidget(videoAsset: videoAsset),
          Positioned(
            top: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Skip'),
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height *
                0.8, // Adjust the position of the text
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Text(
                  infoText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoAsset;

  VideoPlayerWidget({required this.videoAsset});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://webpristine.com/work/cleanup/admin/vedio/vedio2.mp4'));
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        // Navigate to TutorialPage1 when video completes
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox.expand(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
