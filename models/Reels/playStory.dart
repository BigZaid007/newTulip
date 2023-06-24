import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../../Widgets/bottomReel.dart';
import '../../Widgets/reelIcon.dart';

class StoryVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String avatarUrl;
  final String name;

  StoryVideoPlayer({
    required this.videoUrl,
    required this.avatarUrl,
    required this.name,
  });

  @override
  _StoryVideoPlayerState createState() => _StoryVideoPlayerState();
}

class _StoryVideoPlayerState extends State<StoryVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  late PageController _pageController;
  int _currentIndex = 0;
  bool _isVideoLoaded = false;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initVideoPlayer() async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(widget.videoUrl);

    if (fileInfo != null && fileInfo.file.existsSync()) {
      // Use cached file if it exists
      _videoPlayerController = VideoPlayerController.file(fileInfo.file);
    } else {
      // Download video and cache it
      final videoFile = await cacheManager.getSingleFile(widget.videoUrl);
      _videoPlayerController = VideoPlayerController.file(videoFile);
    }

    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      setState(() {
        _isVideoLoaded = true;
      });
    });
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();

    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: bottomReel(),
      body:_isVideoLoaded?FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              color: Colors.black,
              child: SafeArea(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dx < 0) {
                      if (_currentIndex < 2) {
                        _currentIndex++;
                        _pageController.animateToPage(
                          _currentIndex,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else if (details.velocity.pixelsPerSecond.dx > 0) {
                      if (_currentIndex > 0) {
                        _currentIndex--;
                        _pageController.animateToPage(
                          _currentIndex,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                  },
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Stack(
                        children: [
                          VideoPlayer(_videoPlayerController),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.3),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Align(
                            heightFactor: 4,
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                left: 10,
                                bottom: 10,
                              ),
                              child: reelsIcon(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_month,
                                        color: Colors.white),
                                    SizedBox(width: 5),
                                    Text(
                                      'حجز موعد',
                                      style: GoogleFonts.almarai(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                width: 240,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xffBE338E),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          else if (snapshot.connectionState==ConnectionState.waiting)
            {
              print('waiting');
              return CircularProgressIndicator();
            }
          else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.grey,
              ),
            );
          }
        },
      ):
      Stack(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'images/fir.png',
            image: widget.avatarUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'images/fir.png',
                fit: BoxFit.cover,
              );
            },
          ),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If video is loaded, hide the CircularProgressIndicator
                return SizedBox.shrink();
              } else {
                // If video is still loading, show the CircularProgressIndicator
                return Center(child: CircularProgressIndicator(
                  color: Colors.purpleAccent,
                  strokeWidth: 1,
                ));
              }
            },
          ),
        ],
      )


    );
  }
}

