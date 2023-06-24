import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:chewie/chewie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuliptest/models/Reels/playStory.dart';
import 'package:tuliptest/test/preload/preload.dart';
import 'package:video_player/video_player.dart';

import '../Controller/getx_Controller.dart';
import '../Widgets/Loading/reelsLoading.dart';
import '../auth/userController/userController.dart';
import '../models/Reels.dart';
import '../models/Reels/reelsModel/reelsModelPost.dart';

class ReelsList extends StatefulWidget {
  @override
  _ReelsListState createState() => _ReelsListState();
}

class _ReelsListState extends State<ReelsList> {
  final ReelsController _reelsController = Get.put(ReelsController());
  final ScrollController _scrollController = ScrollController();
  int userId = Get.find<UserController>().userId;
  bool _isLoading = false;
  XFile? _selectedVideo;

  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isPressed = false;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (!_isLoading) {
      setState(() => _isLoading = true);
      await _reelsController.fetchReels();
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        if (_reelsController.reels.isNotEmpty) {
          return Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15,left: 4).r,
                child: InkWell(
                  onTap: () async {
                    final XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
                    if (video != null) {
                      final reelModel = ReelModel2(
                        reelsId: 0,
                        centerId: 2,
                        title: 'reel',
                        details: '',
                        isVisible: true,
                        isTop: true,
                        fileChooseReels: File(video.path),
                      );
                      await ReelPostService.postReel(reelModel);
                    }
                  },
                  child: Container(
                    width: 70.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      border: Border.all(
                          width: 1,
                          color: Color(0xfffce3ee)
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Icon(Icons.add,size: 32.sp,color: Colors.white,),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  itemCount: _reelsController.reels.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _reelsController.reels.length) {
                      final reel = _reelsController.reels[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Future.delayed(Duration(seconds: 1), () {
                                  // Get.to(
                                  //   PreloadPage()
                                  // );
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 70.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                    width: 1,
                                    color: _isPressed ? Colors.red : Colors.pink,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'images/fir.png',
                                    image: reel.image,
                                    fit: BoxFit.cover,
                                    width: 90.w,
                                    height: 90.h,
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'images/fir.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              reel.centerName,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          return loadingReel();
        }
      }),
    );
  }
}
//
class ReelModel {
  int? reelsId;
  int? centerId;
  String? title;
  String? details;
  bool? isVisible;
  bool? isTop;
  File? fileChooseReels;

  ReelModel({
    this.reelsId,
    this.centerId,
    this.title,
    this.details,
    this.isVisible,
    this.isTop,
    this.fileChooseReels,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ReelsId'] = reelsId;
    data['CenterId'] = centerId;
    data['Title'] = title;
    data['Details'] = details;
    data['IsVisible'] = isVisible;
    data['IsTop'] = isTop;
    return data;
  }
}
//
// class reelPostSerice {
//   Future<void> postReel(ReelModel reel) async {
//     final Uri uri = Uri.parse('https://www.tulipm.net/api/Reels');
//
//     final request = http.MultipartRequest('POST', uri)
//       ..fields['ReelsId'] = reel.reelsId?.toString() ?? ''
//       ..fields['CenterId'] = reel.centerId?.toString() ?? ''
//       ..fields['Title'] = reel.title ?? ''
//       ..fields['Details'] = reel.details ?? ''
//       ..fields['IsVisible'] = reel.isVisible?.toString() ?? ''
//       ..fields['IsTop'] = reel.isTop?.toString() ?? '';
//
//     if (reel.fileChooseReels != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//         'FileChooseReels',
//         reel.fileChooseReels!.path,
//         contentType: MediaType('video', 'mp4'),
//         filename: reel.fileChooseReels!.path.split('/').last,
//       ));
//     }
//
//     final response = await request.send();
//     if (response.statusCode == HttpStatus.ok) {
//       print('Reel posted successfully');
//     } else {
//       print('Failed to post reel. Status code: ${response.statusCode}');
//     }
//   }
// }



//   Future<void> pickVideo() async {
//     final XFile? pickedFile =
//         await _picker.pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       // The user picked a video
//       final File videoFile = File(pickedFile.path);
//       // Upload the video file to your server here
//     } else {
//       // The user cancelled the picker
//     }
//   }
// }
