import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuliptest/Screens/Add_Shop/addShopThree.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'dart:io';

import '../../Widgets/appBar/appBarAdding.dart';
import '../../Widgets/btn.dart';
import '../../models/category.dart';
import '../../models/shops.dart';
import 'addShopTwo.dart';
import 'controllerShop.dart';
import 'package:http/http.dart' as http;

class addShopOne extends StatefulWidget {
  const addShopOne({Key? key}) : super(key: key);

  @override
  State<addShopOne> createState() => _addShopOneState();
}

class _addShopOneState extends State<addShopOne> {
  List<int> _selectedOptions = [];
  TextEditingController businessAddress = TextEditingController();
  File? _selectedAvatarImage;
  File? _selectedContainerImage;
  LatLng? selectedLocation;
  final businessNameFocusNode = FocusNode();

  TextEditingController businessName = TextEditingController();
  final shopController = Get.put(ShopCategoriesController());

  CircleAvatar _avImage = CircleAvatar(
    child: Image.asset('images/lo.png'),
    radius: 45,
    backgroundColor: Color(0xffF38BB9),
  );

  BoxDecoration _containerDecoration = BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/cover.png'), fit: BoxFit.cover));

  @override
  void initState() {
    super.initState();
    shopController.fetchShops();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBarOne(context),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  GestureDetector(
                    onTap: _getFromGallery,
                    child: Container(
                      width: double.infinity,
                      height: 120.h,
                      decoration: _containerDecoration,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: InkWell(
                      onTap: _getFromGalleryAvatar,
                      child: Center(
                        child: ClipOval(
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: _avImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text(
                    '* حقل اجباري',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '* اسم المتجر ',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w700),
                      textDirection: TextDirection.rtl,
                    ),
                    Container(
                      width: double.infinity,
                      height: 3.h,
                      color: Colors.black54,
                    ),
                    TextFormField(
                      controller: businessName,
                      focusNode: businessNameFocusNode,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        label: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Text(
                            '* اسم العمل التجاري',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: businessNameFocusNode.hasFocus
                                ? Colors.pink
                                : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Colors.pink,
                            width: 2.0,
                          ),
                        ),
                        hintTextDirection: TextDirection.rtl,
                        hintText: 'ادخل اسم المركز هنا',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى ادخال اسم المركز';
                        }
                        if (value.length > 25) {
                          return 'لا يمكن أن يتجاوز طول الاسم 25 حرفًا';
                        }
                        if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                          return 'يجب أن يحتوي الاسم فقط على أحرف وأرقام';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(() {
                final categories = shopController.shops;
                final isSelected = _selectedOptions.isNotEmpty;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Container(
                                  alignment: AlignmentDirectional.center,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: Text(
                                    'أختر نوع المتجر',
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.almarai(
                                      fontSize: 22.sp,
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                ),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      final category = categories[index];
                                      final categorySelected = _selectedOptions
                                          .contains(category.categoriesId);

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (!categorySelected) {
                                              _selectedOptions
                                                  .add(category.categoriesId);
                                            }
                                          });
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Card(
                                          color: categorySelected
                                              ? Colors.grey[300]
                                              : null,
                                          child: ListTile(
                                            title: Text(
                                              category.ShopName,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            trailing: categorySelected
                                                ? Icon(Icons.check)
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              width: 179.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 8),
                                  Text(
                                    'أضف عملك التجاري',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            isSelected
                                ? Wrap(
                                    spacing: 8,
                                    children:
                                        _selectedOptions.map((categoryId) {
                                      final category = categories.firstWhere(
                                          (c) => c.categoriesId == categoryId);
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedOptions.remove(categoryId);
                                          });
                                        },
                                        child: Chip(
                                          label: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                category.ShopName,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.close,
                                                size: 16.sp,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          backgroundColor: Colors.pink[200],
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.grey),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () async {
                    LatLng selectedLocation = await _showMapDialog(context);
                    if (selectedLocation != null) {
                      double latitude = selectedLocation.latitude;
                      double longitude = selectedLocation.longitude;
                      print('Latitude: $latitude');
                      print('Longitude: $longitude');
                    }
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    height: 35.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.pink, width: 1)),
                    child: Text(
                      '* عنوان المتجر',
                      style: GoogleFonts.almarai(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.pink),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 12).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnShopCartnoIcon(context, 'رجوع', Colors.white),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: InkWell(
                        splashColor: Colors.pink[300],
                        highlightColor: Colors.pink[300],
                        hoverColor: Colors.pink[300],
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(width: 16),
                                    Text('جاري المعالجة...'),
                                  ],
                                ),
                              );
                            },
                          );

                          if (businessName.text.isEmpty) {
                            Get.snackbar(
                              'خطأ',
                              'يرجى إدخال اسم المتجر',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red[200],
                              colorText: Colors.white,
                            );
                          } else if (_selectedAvatarImage == null) {
                            Get.snackbar(
                              'خطأ',
                              'يرجى إدخال الصورة الشخصية',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red[200],
                              colorText: Colors.white,
                            );
                          } else if (_selectedContainerImage == null) {
                            Get.snackbar(
                              'خطأ',
                              'يرجى إدخال صورة الغلاف',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red[200],
                              colorText: Colors.white,
                            );
                          } else if (_selectedOptions == null) {
                            Get.snackbar(
                              'خطأ',
                              'يرجى نوع العمل التجاري',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red[200],
                              colorText: Colors.white,
                            );
                          } else {
                            // Perform your logic here
                            print(_selectedOptions);
                            // Simulating delay for demonstration purposes
                            await Future.delayed(Duration(seconds: 2));
                            Navigator.pop(context); // Close the loading dialog
                            Get.to(() => addShopThree(
                                  businessName.text,
                                  _selectedAvatarImage!,
                                  _selectedContainerImage!,
                                  _selectedOptions,
                                ));
                          }
                        },
                        child: btnShopCart(context, 'التالي', Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getFromGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      // Crop the image
      final File imageFile = File(pickedFile.path);
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 4.0, ratioY: 3.0),
      );

      if (croppedFile != null) {
        // Set the selected container image to the cropped image
        setState(() {
          _selectedContainerImage = croppedFile;
        });

        // Update the container decoration with the selected image
        _containerDecoration = BoxDecoration(
          image: DecorationImage(
            image: FileImage(_selectedContainerImage!),
            fit: BoxFit.cover,
          ),
        );
      }
    }
  }

  Future<LatLng> _showMapDialog(BuildContext context) async {
    LatLng selectedLocation = LatLng(33.3152, 44.3661);

    Set<Marker> _createMarkers(LatLng location) {
      return <Marker>[
        Marker(
          markerId: MarkerId("selectedLocation"),
          position: location,
          icon: BitmapDescriptor.defaultMarker,
        ),
      ].toSet();
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 400,
            child: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          33.3152, 44.3661), // Initial location set to Baghdad
                      zoom: 15,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      // Perform any map-related initialization here
                    },
                    markers: _createMarkers(selectedLocation),
                    onTap: (LatLng location) {
                      setState(() {
                        selectedLocation = location;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedLocation != null) {
                      Navigator.of(context).pop(selectedLocation);
                    } else {
                      print("No location selected");
                    }
                  },
                  child: Text(
                    'تثبيت الموقع',
                    style: GoogleFonts.almarai(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return selectedLocation;
  }

  void _getFromGalleryAvatar() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      if (pickedFile != null) {
        _selectedAvatarImage = File(pickedFile.path);
        _avImage = CircleAvatar(
          backgroundImage: FileImage(_selectedAvatarImage!),
          radius: 45,
          backgroundColor:
              Colors.transparent, // Set background color to transparent
        );
      }
    });
  }
}

class ShopCategoriesController extends GetxController {
  final _shops = <Shops>[].obs;
  List<Shops> get shops => _shops.value;

  void fetchShops() async {
    var apiUrl = 'https://www.tulipm.net/api/Categories/GetAll';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final shopsJson = data['data'] as List<dynamic>;
      final shopsList = shopsJson.map((json) => Shops.fromJson(json)).toList();
      _shops.value = shopsList;
    } else {
      throw Exception('Failed to load services');
    }
  }
}
