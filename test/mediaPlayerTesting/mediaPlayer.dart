import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyMediaPlayerWidget extends StatefulWidget {
  @override
  _MyMediaPlayerWidgetState createState() => _MyMediaPlayerWidgetState();
}

class _MyMediaPlayerWidgetState extends State<MyMediaPlayerWidget> {
  final List<String> videoUrls = [
    "https://www.tulipm.net/\\Uplouds\\Video\\Video-b4cf6cbd-fff6-4dd8-8c7c-7cabf1f41792_Part_1.mp4",
    "https://www.tulipm.net/\\Uplouds\\Video\\Video-b4cf6cbd-fff6-4dd8-8c7c-7cabf1f41792_Part_2.mp4",
    "https://www.tulipm.net/\\Uplouds\\Video\\Video-b4cf6cbd-fff6-4dd8-8c7c-7cabf1f41792_Part_3.mp4",
    "https://www.tulipm.net/\\Uplouds\\Video\\Video-b4cf6cbd-fff6-4dd8-8c7c-7cabf1f41792_Part_4.mp4",
    "https://www.tulipm.net/\\Uplouds\\Video\\Video-b4cf6cbd-fff6-4dd8-8c7c-7cabf1f41792_Part_5.mp4"
  ];

  VideoPlayerController? _videoPlayerController;
  int _currentIndex = 0;

  void convertToPartsUrl() async {
    if (_currentIndex >= videoUrls.length) {
      // All parts have been played
      return;
    }

    final partUrl = videoUrls[_currentIndex];
    _videoPlayerController = VideoPlayerController.network(partUrl)
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController!.play();
        });
        _videoPlayerController!.addListener(() {
          if (_videoPlayerController!.value.position >=
              _videoPlayerController!.value.duration) {
            // Current part has ended
            _currentIndex++;
            if (_currentIndex < videoUrls.length) {
              // Play the next part
              _videoPlayerController!.pause();
              _videoPlayerController!.dispose();
              convertToPartsUrl();
            }
          }
        });
      });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                convertToPartsUrl();
              },
              child: Text('Convert to Parts URL'),
            ),
            if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
          ],
        ),
      ),
    );
  }
}
