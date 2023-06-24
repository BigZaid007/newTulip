import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuliptest/test/preload/playerScreen.dart';
import 'package:tuliptest/test/preload/preload.dart';
import 'package:video_player/video_player.dart';

import '../../Controller/getx_Controller.dart';
import '../../auth/userController/userController.dart';
import '../../models/Reels/reelsModel/reelsModelPost.dart';



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final PCC controller = Get.put(PCC());

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
            () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.allVideosData.length + 1, // Add 1 for the "Add" button
          itemBuilder: (context, index) {
            if (index == 0) {
              // Render the "Add" button container as the first item
              return GestureDetector(
                onTap: () async {
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
                                  Navigator.pop(context); // Close the success dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      setState(() {}); // Rebuild the video list
                    } catch (error) {
                      Navigator.pop(context); // Close the loading dialog
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
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 70.0,
                        height: 60.0,
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

            // Render the regular video item
            final videoData = controller.allVideosData[index - 1];
            final imageUrl = videoData['image'];
            final centerName = videoData['centerName'] ?? 'Reel';

            return GestureDetector(
              onTap: () async {
                Get.to(() => PreloadPage());
                print(index);
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 70.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(38),
                        border: Border.all(
                          color: Colors.pink[300]!,
                          width: 2.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            child: Container(color: Colors.white),
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset('images/3.png'),
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
        ),
      ),
    );
  }
}
