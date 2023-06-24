import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuliptest/Screens/addProduct/addItemSecond.dart';
import 'package:tuliptest/Screens/Market/marketScreenType/storeScreen.dart';
import 'package:tuliptest/Screens/addProduct/productWidget/productWidget.dart';
import 'package:tuliptest/Widgets/tags.dart';
import 'package:http/http.dart' as http;

import '../../Widgets/btn.dart';

class addItems extends StatefulWidget {
  int storeId;

  addItems(this.storeId);

  @override
  State<addItems> createState() => _addItemsState();
}

class _addItemsState extends State<addItems> {
  List<File> _imageFiles = [];
  String? _selectedCategory;
  List<dynamic> _categories = [];

  Future<void> _getCategories() async {
    final url = Uri.parse('https://www.tulipm.net/api/Categories/GetAll');
    final response = await http.get(url);

    print(response.body);
    print('hello');
    if (response.statusCode == 200) {
      setState(() {
        _categories = jsonDecode(response.body)['data'];
        print(_categories);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            contanctInfo(),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'اضافة صور للمنتج',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    Text(
                      'اختر ثلاث صور مناسبة للمنتج',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    // Add spacing between the items
                    children: List.generate(
                      _imageFiles.length,
                      (index) {
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
                              top: 170,
                              left: 5,
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                height: 28.h,
                                width: 28.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _imageFiles.removeAt(index);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
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
                          width: 40.w,
                          height: 40.h,
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
                          height: 2.h,
                          width: 70.w,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 40.h,
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
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 30).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'اختر فئة المنتج',
                    style: TextStyle(fontSize: 22.sp),
                    textDirection: TextDirection.rtl,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map<Widget>((category) {
                      final categoryId = category['categoriesId'].toString();
                      final categoryName = category['categoriesName'];

                      return ChoiceChip(
                        label: Text(
                          categoryName,
                          style: TextStyle(
                            color: _selectedCategory == categoryId
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: _selectedCategory == categoryId,
                        selectedColor: Color(0xff0fffacfe6),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              _selectedCategory = categoryId;
                            } else {
                              _selectedCategory = '';
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  // tag(),

                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      btnShopItem2(context, 'رجوع', Colors.white),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            print(_imageFiles);
                            print(widget.storeId);
                            print(_selectedCategory);
                            Get.to(() => addItemSecond(_imageFiles,
                                widget.storeId, _selectedCategory!));
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text('التالي',
                                style: GoogleFonts.roboto(
                                    fontSize: 14.sp,
                                    color: Colors.white)),
                            height: 40.h,
                            width: 130.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0), color: Color(0xff121212)),
                          ),)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
