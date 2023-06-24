import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../Controller/getx_Controller.dart';
import '../../Widgets/bottomReel.dart';
import '../../Widgets/reelIcon.dart';
import '../../models/Reels/reelsModel/reelsModelPost.dart';

class ContentController extends GetxController {
  final List<String> videos;
  final int initialIndex;
  final String img;

  late PageController pageController;
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  bool liked = false;
  int currentIndex = 0;
  bool isScrolling = false;
  bool isLoad = false;

  ScrollController scrollController = ScrollController();

  ContentController({
    required this.videos,
    required this.initialIndex,
    required this.img,
  });

  @override
  void onInit() {
    super.onInit();
    currentIndex = initialIndex;
    pageController = PageController(initialPage: currentIndex);
    initializePlayer(currentIndex);
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    isScrolling = scrollController.position.isScrollingNotifier.value;
  }

  Future<void> initializePlayer(int index) async {
    if (videos[index].isNotEmpty) {
      videoPlayerController = VideoPlayerController.network(videos[index]);
      await videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        showControls: false,
        looping: true,
      );
      update();
    } else {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        showControls: false,
        looping: true,
      );
    }
  }

  void disposePlayer() {
    if (!isScrolling) {
      videoPlayerController.pause();
      videoPlayerController.dispose();
      chewieController!.dispose();
    }
  }

  void onPageChanged(int index) {
    disposePlayer();
    initializePlayer(index);
    currentIndex = index;
    update();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    disposePlayer();
    super.onClose();
  }
}


class ContentScreen extends StatefulWidget {
  final List<String> videos;
  final int initialIndex;
  final String img;

  const ContentScreen({
    Key? key,
    required this.videos,
    required this.initialIndex, required this.img,
  }) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}


class _ContentScreenState extends State<ContentScreen> {
  late PageController _pageController;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  List<String> imgList = [];
  bool _liked = false;
  int _currentIndex = 0;
  bool _isScrolling = false;
  bool isLoad=false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    initializePlayer(_currentIndex);

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.isScrollingNotifier.value) {
      _isScrolling = true;
    } else {
      _isScrolling = false;
    }
  }

  Future<void> initializePlayer(int index) async {
    if (widget.videos[index].isNotEmpty) {
      _videoPlayerController = VideoPlayerController.network(widget.videos[index]);
      await _videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        showControls: false,
        looping: true,
      );
      setState(() {});
    } else {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        showControls: false,
        looping: true,
      );
    }
  }
  // Future<void> initializePlayer(int index) async {
  //   _videoPlayerController = VideoPlayerController.network(widget.videos[index]);
  //   await _videoPlayerController.initialize();
  //   _chewieController = ChewieController(
  //     videoPlayerController: _videoPlayerController,
  //     autoPlay: true,
  //     showControls: false,
  //     looping: true,
  //   );
  //   setState(() {});
  // }

  void disposePlayer() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _chewieController = null;
  }


  void onPageChanged(int index) {
    disposePlayer(); // Dispose of the previous video player
    initializePlayer(index); // Initialize the new video player
    setState(() {
      _currentIndex = index;
      // isLoad=true;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    disposePlayer(); // Dispose of the video player when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: bottomReel(),
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [



          PageView.builder(
            controller: _pageController,
            itemCount: widget.videos.length,
            onPageChanged: onPageChanged,
            physics: _isScrolling ? NeverScrollableScrollPhysics() : null,
            itemBuilder: (context, index) {

              return Stack(
                children: [

                  _buildVideoPlayer(index),
                ],
              );
            },
          ),

        ],
      ),
    );
  }

  Widget _buildVideoPlayer(int index) {

    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      return GestureDetector(
        onDoubleTap: () {
          setState(() {
            _liked = !_liked;
          });
        },
        child: Stack(
          children: [
            Chewie(
              controller: _chewieController!,
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
                      Icon(Icons.calendar_month, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        'حجز موعد',
                        style: GoogleFonts.almarai(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
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
            ),
          ],
        ),
      );
    } else {
      return Stack(
        children: [
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: Colors.pink,
            ),
          ),
        ],
      );
    }
  }
}


class ContentScreen2 extends StatefulWidget {
  final String? src;

  const ContentScreen2({Key? key, this.src}) : super(key: key);

  @override
  _ContentScreen2State createState() => _ContentScreen2State();
}

class _ContentScreen2State extends State<ContentScreen2> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.src!);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
            ? GestureDetector(
          onDoubleTap: () {
            setState(() {
              _liked = !_liked;
            });
          },
          child: Chewie(
            controller: _chewieController!,
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Loading...')
          ],
        ),

      ],
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> videos = [
    'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
    'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8',
    "https://www.tulipm.net/\\Uplouds\\Video\\Video-54a9a745-bda5-48e0-a71f-884d6e080ca9.mov",
    "https://www.tulipm.net/\\Uplouds\\Video\\Video-07b4c78b-4f5d-4cfe-baf9-bace324ccd32.mp4",



  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //We need swiper for every content
              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ContentScreen2(
                    src: videos[index],

                  );
                },
                itemCount: videos.length,
                scrollDirection: Axis.vertical,
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class StoriesScreen extends StatelessWidget {
  final PCC pccController = Get.put(PCC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
                () => pccController.isURLsFetched.value
                ? ListView.builder(
                  physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: pccController.videoURLs.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GestureDetector(
                    onTap: () async {
                      pccController.up();
                      print('update');
                      print(pccController.isURLsFetched.value);
                      pccController.isURLsFetched.value=!pccController.isURLsFetched.value;
                      if(pccController.isURLsFetched.value==false)
                        {
                          final XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
                          if (video != null) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 16.0),
                                        Text(
                                          'جاري التحميل...',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            final reelModel = ReelModel2(
                              reelsId: 0,
                              centerId: userId,
                              title: 'reel',
                              details: '',
                              isVisible: true,
                              isTop: true,
                              fileChooseReels: File(video.path),
                            );

                            try {
                              await ReelPostService.postReel(reelModel);
                              pccController.isReelAdded.value = true;
                              Navigator.pop(context); // Close the loading dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Success'),
                                    content: Text('تمت الاضافة بنجاح'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          print('added');
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } catch (error) {
                              Navigator.pop(context);
                              pccController.isReelAdded.value = true; // Close the loading dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Failed to add video.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close the error dialog
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                          pccController.fetchVideoURLs();
                        }
                      print(pccController.isURLsFetched.value);

                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: 65.0.w,
                            height: 65.0.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(38),
                              border: Border.all(
                                color: Colors.pink[300]!,
                                width: 2.0,
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.pink[300]!,
                              size: 24.0,
                            ),
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            'Add',
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11.0, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final videoData = pccController.allVideosData[index - 1];
                final imageUrl = videoData['image'];
                final centerName = videoData['centerName'] ?? 'Reel';
                final videoUrl = pccController.videoURLs[index - 1];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => ContentScreen(
                      img: imageUrl,
                      videos: pccController.videoURLs,
                      initialIndex: index - 1,
                    ));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 65.0.w,
                          height: 65.0.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xffEA6CB0),
                              width: 2.0,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                child: Container(color: Colors.white),
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                              ),
                              errorWidget: (context, url, error) => Image.asset('images/3.png'),
                            ),
                          ),
                        ),
                        SizedBox(height: 7.0),
                        Text(
                          centerName,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11.0, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : reelLoadList(),
          ),
        ),
      ),
    );
  }
}

Widget reelLoadList()
{
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 5, // Number of items in the list
    itemBuilder: (BuildContext context, int index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    },
  );
}
