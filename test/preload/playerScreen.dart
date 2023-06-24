import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';



class VideoPlayerScreen extends StatefulWidget {
  final List<String> videoUrls;
  final int initialIndex;

  VideoPlayerScreen({
    required this.videoUrls,
    required this.initialIndex,
  });

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late PageController _pageController;
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _videoPlayerController = VideoPlayerController.network(widget.videoUrls[widget.initialIndex]);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      setState(() {}); // Update the state after the video player is initialized
    });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PreloadPageView.builder(
              controller: PreloadPageController(initialPage: 0),
              itemCount: widget.videoUrls.length,
              preloadPagesCount: 3,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

