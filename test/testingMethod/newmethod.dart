import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:preload_page_view/preload_page_view.dart';



class NewVideoController extends GetxController {
  final List<VideoPlayerController> controllers = <VideoPlayerController>[].obs;

  @override
  void onInit() {
    super.onInit();
    preloadVideos();
  }

  Future<void> preloadVideos() async {
    final List<String> videoUrls = [
      'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8',
      'https://www.w3schools.com/html/movie.mp4',
      "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
      "https://storage.googleapis.com/gtv-videos-bucket/sample/Sintel.jpg",
      "https://storage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
      "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
      'https://www.w3schools.com/html/movie2.mp4',
      'https://www.w3schools.com/html/movie3.mp4',
      'https://www.example.com/video4.mp4',
      'https://www.example.com/video5.mp4',
      'https://www.example.com/video6.mp4',
      'https://www.example.com/video7.mp4',
      'https://www.example.com/video8.mp4',
      'https://www.example.com/video9.mp4',
      'https://www.example.com/video10.mp4',
    ];

    for (final videoUrl in videoUrls) {
      final controller = VideoPlayerController.network(videoUrl);
      await controller.initialize();
      controllers.add(controller);
    }
  }

  @override
  void onClose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.onClose();
  }
}

class NewVideo extends StatelessWidget {
  final NewVideoController controller = Get.put(NewVideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () {
          final controllers = controller.controllers;
          if (controllers.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return PreloadPageView.builder(
              preloadPagesCount: 1,
              scrollDirection: Axis.horizontal,
              itemCount: controllers.length,
              itemBuilder: (context, index) {
                final controller = controllers[index];
                controller.play();
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayer(controller),
                );
              },
              controller: PreloadPageController(initialPage: 0),
            );
          }
        },
      ),
    );
  }
}

