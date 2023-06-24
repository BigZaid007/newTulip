import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tuliptest/services/authService.dart';
import 'package:tuliptest/Screens/Market/shopProfile/StoreProductsView.dart';

import '../../Widgets/appBar/appBarAdding.dart';
import '../../Widgets/btn.dart';
import '../../models/category.dart';
import 'addBusinessTwo.dart';
import 'controller/category_controller.dart';

class addBusinessOne extends StatefulWidget {
  const addBusinessOne({Key? key}) : super(key: key);

  @override
  State<addBusinessOne> createState() => _addBusinessOneState();
}

class _addBusinessOneState extends State<addBusinessOne> {
  File? _selectedAvatarImage;
  File? _selectedContainerImage;
  String? _newServiceName;
  List _services =[];

  int _selectedOption=0;
  TextEditingController businessName=TextEditingController();
  CategoryController controller = Get.put(CategoryController());
  final businessNameFocusNode = FocusNode();
  LatLng? selectedLocation;

  TextEditingController businessAddress=TextEditingController();
  CircleAvatar _avImage = CircleAvatar(
    child: Image.asset('images/lo.png',fit: BoxFit.contain,),
    radius: 45,
    backgroundColor: Color(0xffF38BB9),
  );

  BoxDecoration _containerDecoration=BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/cover.png'),
      fit: BoxFit.cover
    )
  );

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();
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
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Text('* حقل اجباري',style: TextStyle(
                      fontSize: 18.sp
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

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
                          color: businessNameFocusNode.hasFocus ? Colors.pink : Colors.grey,
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
              SizedBox(height: 20.h,),

              // Obx(() {
              //   final categoryController = Get.find<CategoryController>();
              //   if (categoryController.isLoading.value) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 10),
              //       child: DropdownButtonFormField<String>(
              //         items: [],
              //         decoration: InputDecoration(
              //           hintTextDirection: TextDirection.rtl,
              //           hintStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              //         ),
              //         value: _selectedOption,
              //         onChanged: (value) {
              //           setState(() {
              //             _selectedOption = value!;
              //           });
              //         },
              //         dropdownColor: Colors.white,
              //       ),
              //     );
              //   } else if (categoryController.categories.isEmpty) {
              //     return Text('No categories found.');
              //   } else {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 10),
              //       child: DropdownButtonFormField<String>(
              //         decoration: InputDecoration(
              //           hintTextDirection: TextDirection.rtl,
              //           hintText: '* نوع العمل التجاري',
              //           hintStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              //         ),
              //         value: _selectedOption,
              //         onChanged: (value) {
              //           final category = value!.split('_')[1];
              //           categoryController.updateCategory(category);
              //           setState(() {
              //             _selectedOption = value;
              //           });
              //         },
              //         icon: null, // remove the arrow icon
              //         dropdownColor: Colors.white,
              //         alignment: AlignmentDirectional.centerStart,
              //         items: categoryController.categories.map((category) {
              //           final value = '${category.sectionsId}_${category.categoriesName}';
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(
              //               category.categoriesName,
              //               textDirection: TextDirection.rtl,
              //             ),
              //           );
              //         }).toList(),
              //       ),
              //     );
              //   }
              // }),
          TextButton(
            onPressed: () {
              final categoryController = Get.find<CategoryController>();
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
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'أختر نوع المركز',
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
                        itemCount: categoryController.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          final category = categoryController.categories[index];
                          return InkWell(
                            onTap: () {
                              categoryController.updateCategory(category.categoriesName);
                              Navigator.pop(context);
                              print(category.sectionsId);
                              setState(() {
                                _selectedOption = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                category.categoriesName,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: index == categoryController.getSelectedCategoryIndex()
                                      ? Colors.blue
                                      : Colors.black,
                                ),
                                textAlign: TextAlign.center,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    width: 180.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: Colors.pink
                        )
                    ),
                    child: Text(
                      '* نوع العمل التجاري ',
                      style: GoogleFonts.almarai(
                        fontSize: 17.sp,
                        color: Colors.pink,
                        fontWeight: FontWeight.w700,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    alignment: AlignmentDirectional.center,
                    width: 140.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: _selectedOption != null && _selectedOption >= 0 && _selectedOption < categoryController.categories.length?Colors.pink:Colors.white
                      )
                    ),
                    child: Text(
                      _selectedOption != null && _selectedOption >= 0 && _selectedOption < categoryController.categories.length
                          ? categoryController.categories[_selectedOption].categoriesName
                          : '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ),
          ),




          SizedBox(height: 20.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('* اضف خدمات المركز',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                          fontSize: 15.sp
                      ),),
                    SizedBox(height: 10.h,),
                    InkWell(
                      onTap: (){
                        _showAddServiceDialog(context);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.add, color: Colors.black54),
                            Text(
                              'اضافة خدمة',
                              style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                            ),
                          ],
                        ),
                        width: 120.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black54),
                        ),

                      ),
                    ),

                    Row(
                      children: _services.asMap().entries.map((entry) {
                        final index = entry.key;
                        final service = entry.value;
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(service),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    // Remove the selected service from the list
                                    _services.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
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
                    border: Border.all(
                      color: Colors.pink,
                      width: 1
                    )
                  ),
                  child: Text('* عنوان العمل التجاري',style: GoogleFonts.almarai(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                    color: Colors.pink
                  ),
                      textDirection: TextDirection.rtl,),
                ),
                ),
              ),
              SizedBox(height: 10.h,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 12).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnShopCartnoIcon(context,'رجوع',Colors.white),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: InkWell(
                    splashColor: Colors.pink[300],
                    highlightColor: Colors.pink[300],
                    hoverColor: Colors.pink[300],
                    onTap: () {
                      if (businessName.text.isEmpty) {
                        Get.snackbar(
                          'خطأ',
                          'يرجى إدخال اسم العمل',
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
                      } else if (_selectedOption == null) {
                        Get.snackbar(
                          'خطأ',
                          'يرجى نوع العمل التجاري',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red[200],
                          colorText: Colors.white,
                        );
                      } else if (_services.isEmpty) {
                        Get.snackbar(
                          'خطأ',
                          'يرجى اضافة خدمة واحدة على الاقل',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red[200],
                          colorText: Colors.white,
                        );
                      } else {
                        Get.to(() => addBusinessTwo(
                          businessName.text,
                          _selectedAvatarImage!,
                          _selectedContainerImage!,
                          _selectedOption,
                          _services,
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
                      target: LatLng(33.3152, 44.3661), // Initial location set to Baghdad
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
                  child: Text('تثبيت الموقع',style: GoogleFonts.almarai(),),
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
          backgroundColor: Colors.transparent, // Set background color to transparent
        );
      }
    });
  }



  void _showAddServiceDialog(BuildContext context) async {
    _newServiceName = null;

    await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xfffef1f6),
          title: Text('أضافة خدمة',textDirection: TextDirection.rtl,),

          content: TextFormField(
            decoration: InputDecoration(
              hintText: 'قص شعر',
        hintTextDirection: TextDirection.rtl
            ),
            onChanged: (value) {
              _newServiceName = value;
            },
          ),
          actions: [
            TextButton(
              child: Text('الغاء',style: TextStyle(
                color: Colors.black
              ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('اضافة',style: TextStyle(
                color: Colors.black
              ),),
              onPressed: () {
                if (_newServiceName != null && _newServiceName!.isNotEmpty) {
                  setState(() {
                    // Add new service to your list of services
                    _services.add(_newServiceName!);
                  });

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

}