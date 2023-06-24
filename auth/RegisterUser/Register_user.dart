import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tuliptest/Screens/mainScreens/initialScreen.dart';
import 'package:tuliptest/auth/LoginScreen.dart';
import 'package:tuliptest/auth/RegisterUser/Register_Complete.dart';
import 'package:tuliptest/services/authService.dart';

import '../authController/Register/register_service.dart';
import '../userController/userController.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final UserController userController = Get.find();

  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffce3ee),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        centerTitle: true,
        backgroundColor: Color(0xfffce3ee),
        title: Text(
          'أختر صورة شخصية',
          textDirection: TextDirection.rtl,
          style: GoogleFonts.almarai(fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'اختر صورة شخصية للحساب لأنهاء عملية تسجيل الحساب بنجاح , يمكنك تغيير الصورة لاحقا',
                style:
                    GoogleFonts.almarai(fontSize: 20.sp, color: Colors.black),
                textDirection: TextDirection.rtl,
              ),
            ),
            // Display the current profile image (if there is one)
            Container(
              width: 200.w,
              height: 200.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: _selectedImage != null
                  ? ClipOval(
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.person, size: 100),
            ),
            SizedBox(height: 20.h),
            // Button to choose a new image
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                highlightColor: Colors.red,
                splashColor: Colors.red,
                onTap: () async {
                  print(userController.userId);
                  await _pickImage();
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: 210.w,
                  height: 40.h,
                  child: Text(
                    'أختر صورة شخصية للحساب',
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.almarai(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,

                      child: InkWell(

                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          print('object');
                          if (_selectedImage != null) {
                            File imageFile = _selectedImage ??
                                File("path/to/placeholder/image.png");
                            RegisterUserWithImage(
                                userController.userId, imageFile);
                            Get.off(() => SuccessScreen());
                          } else
                            print('empty image');
                        },
                        hoverColor: Colors.pink[300],
                        splashColor: Colors.pink[300],

                        child: Container(
                          alignment: AlignmentDirectional.center,
                          width: 200.w,
                          height: 40.h,
                          child: Text(
                            'حفظ الصورة',
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.almarai(
                                fontSize: 16.sp, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        highlightColor: Colors.grey[200],
                        splashColor: Colors.grey[700],
                        onTap: () {
                          AssetImage placeholderImage =
                              AssetImage('images/3.png');
                          RegisterUserWithImage(
                              userController.userId, placeholderImage as File);
                          Get.off(() => SuccessScreen());
                        },
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          width: 200.w,
                          height: 40.h,
                          child: Text(
                            'تخطي',
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.almarai(
                                fontSize: 16.sp, color: Colors.black),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
