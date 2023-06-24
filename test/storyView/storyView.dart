import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:video_player/video_player.dart';

class Story {
  final String videoUrl;
  final String caption;

  Story({required this.videoUrl, required this.caption});
}

class StoryController extends GetxController {
  final stories = <Story>[
    Story(videoUrl: 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4', caption: 'Story 1'),
    Story(videoUrl: 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4', caption: 'Story 2'),
    Story(videoUrl: 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4', caption: 'Story 3'),
  ].obs;

  final PreloadPageController pageController = PreloadPageController();
}

class StoryView extends GetView<StoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.stories.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.stories.length,
            itemBuilder: (context, index) {
              final story = controller.stories[index];
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.pageController.jumpToPage(index);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        story.videoUrl,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: PreloadPageView.builder(
                      controller: controller.pageController,
                      preloadPagesCount: 2,
                      itemCount: controller.stories.length,
                      itemBuilder: (context, pageIndex) {
                        return VideoPlayerWidget(
                          videoUrl: controller.stories[pageIndex].videoUrl,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        }
      })
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}
