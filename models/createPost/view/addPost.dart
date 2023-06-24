import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tuliptest/Screens/Sections/centerProfile/centerPersonProfile.dart';
import 'package:tuliptest/Screens/Sections/centerProfile/centerProfile.dart';
import 'package:tuliptest/Screens/mainScreens/initialScreen.dart';
import 'package:tuliptest/Widgets/btn.dart';

import '../../posts.dart';
import '../model/createPostModel.dart';


class AddPost extends StatefulWidget {
  final centerName;
  final centerLogo;
  final id;

  const AddPost({Key? key, this.centerName, this.centerLogo, this.id})
      : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  List<File> _imageFiles = [];
  bool isLoading = true;
  TextEditingController detialsContoller=TextEditingController();
  final PostController controller = Get.put(PostController());
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black54,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          widget.centerName,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'تحرير اعلان جديد',
                          style: TextStyle(
                            color: Color(0xffFF9083),
                            fontSize: 12.0.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.0.w),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(widget.centerLogo),
                    backgroundColor: Colors.white12,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 210.h,
                      width: 106.w,
                      decoration: BoxDecoration(
                        color: Color(0xfffacfe6),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: IconButton(
                              onPressed: _getFromGallery,
                              icon: Icon(
                                Icons.image,
                                color: Colors.grey,
                              ),
                              iconSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                            width: 70,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: IconButton(
                              onPressed: _getFromCamera,
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                              iconSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w), // added SizedBox with width of 10
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageFiles.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                height: 210.h,
                                width: 106.w,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(_imageFiles[index]),
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 170.h,
                                left: 5.w,
                                child: Container(
                                  alignment: AlignmentDirectional.center,
                                  height: 28.h,
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _imageFiles.removeAt(index);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.grey,
                                      size: 15.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10).r,
                      child: Text(
                        'تحرير النص',
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.almarai(fontSize: 24),
                      ),
                    ),

                    SizedBox(height: 12.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 3).r,
                      child: TextFormField(
                        controller: detialsContoller,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(25),
                          ),
                            hintTextDirection: TextDirection.rtl,
                            hintText: 'أكتب شرح مختصر لمنتجك / أعلانك'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                print(widget.id);
                print(_imageFiles);
                print(detialsContoller.text);
                PostService postService = PostService();
                String response = await postService.createPost(
                  postsId: 0,
                  centerId: widget.id,
                  modelId: 0,
                  details: detialsContoller.text,
                  images: _imageFiles,
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Container(
                          width: 300, // Set the desired width of the dialog
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'جاري الاضافة...',
                                style: GoogleFonts.almarai(fontWeight: FontWeight.w700),
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: CircularProgressIndicator(
                                  color: Colors.pink,
                                  strokeWidth: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );



                await Future.delayed(Duration(seconds: 3));

                setState(() {
                  isLoading = false;
                });

                setState(() {
                  Navigator.pop(context); // Close the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'تم اضافة الاعلان بنجاح',
                          style: GoogleFonts.almarai(fontWeight: FontWeight.w700),
                          textDirection: TextDirection.rtl,
                        ),
                        content: Text(
                          'تمت الاضافة بنجاح',
                          textDirection: TextDirection.rtl,
                        ),
                        actions: [
                          InkWell(
                            onTap: () {
                              Get.to(()=>centerPersonProfile(widget.id));
                              controller.fetchPosts(controller.userId, controller.index);
                            },
                            child: Center(
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                width: 180.w,
                                height: 34.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.pink[300],
                                ),
                                child: Text('العودة للصفحة الشخصية', style: GoogleFonts.almarai()),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                });

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15).r,
                child: btnShopAd(context, 'نشر الاعلان', Color(0xffBE338E)),
              ),
            )



          ],
        ));
  }

  Future<void> _getFromGallery() async {
    List<PickedFile>? pickedFiles = await ImagePicker().getMultiImage(
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFiles != null) {
      List<File> imageFiles =
          pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      setState(() {
        _imageFiles.addAll(imageFiles); // add images to the list
      });
    }
  }

  Future<void> _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      List<File> imageFiles = [File(pickedFile.path)];
      setState(() {
        _imageFiles.addAll(imageFiles); // add image to the list
      });
    }
  }
}

// PostService postService = PostService();
// List<File> images = [File('path/to/image1.png'), File('path/to/image2.png')];
// await postService.createPost(
// postsId: 0,
// centerId: 3,
// modelId: 0,
// title: 'post for test',
// details: 'testing',
// images: images);
