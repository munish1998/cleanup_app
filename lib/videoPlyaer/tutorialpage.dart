import 'package:cleanup_mobile/Auth_Screen/Login.dart';
import 'package:cleanup_mobile/videoPlyaer/tutorialpage1.dart';
import 'package:cleanup_mobile/videoPlyaer/tutorialpage2.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TutorialPage extends StatelessWidget {
  final String videoAsset;
  final String infoText;
  final VoidCallback? onComplete;
  TutorialPage(
      {required this.videoAsset, required this.infoText, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          VideoPlayerWidget(videoAsset: videoAsset),
          Positioned(
            top: 30,
            right: 20,
            child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyWidget()));
                },
                child: Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            // child: ElevatedButton(

            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => MyWidget()));
            //   },
            //   child: Text('Skip'),
            // ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height *
                0.8, // Adjust the position of the text
            child: Container(
              // color: Colors.blue.withOpacity(0.5),
              color: Colors.black.withOpacity(0.1),
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
          MaterialPageRoute(
              builder: (context) => TutorialPage1(
                    videoAsset:
                        'https://webpristine.com/work/cleanup/admin/vedio/vedio2.mp4',
                    infoText: 'Introduction',
                  )),
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
