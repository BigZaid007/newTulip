import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuliptest/Screens/mainScreens/landingPage.dart';
import 'package:tuliptest/Widgets/animationScreen.dart';
import 'package:tuliptest/auth/Register.dart';
import 'package:tuliptest/auth/userController/userController.dart';
import 'package:tuliptest/auth/userController/vistorController.dart';

import '../Screens/mainScreens/initialScreen.dart';

class authScreen extends StatefulWidget {
  const authScreen({Key? key}) : super(key: key);

  @override
  State<authScreen> createState() => _authScreenState();
}

class _authScreenState extends State<authScreen> {
  int userId = Get.find<UserController>().userId;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xffFEF1F6),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(

            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25).r,
                child: Image.asset(
                  'images/1.png',
                  fit: BoxFit.fill,
                  width: 160.w,

                ),
              ),
              Image.asset(
                'images/toppp.png',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
              Image.asset(
                'images/topp.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: 82.h,

              ),

              Positioned.fill(
                child: Image.asset(
                  "images/bott.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Positioned.fill(
                child: Image.asset(
                  "images/bot.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomLeft,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 200).r,
                child: Column(
                  children: [
                    Center(
                      child: Image.asset('images/14.png', width: 206.w, height: 115.h),
                    ),
                    SizedBox(height: 90.h),
                    GestureDetector(
                      onTap: () {

                        Get.to(()=>AnimationLoaderScreen());
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'الدخول كـ زائر',
                          style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: Color(0xff323232)),
                        ),
                        width: 326.w,
                        height: 47.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffEA6CB0),
                          ),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      highlightColor: Colors.pink,
                      hoverColor: Colors.pink[200],
                      onTap: () {
                        Get.to(()=> Register());
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'تسجيل الدخول',
                          style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: Colors.white),
                        ),
                        width: 326.w,
                        height: 47.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffEA6CB0),
                          ),
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffBE338E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 250,left: 210).r,
                child: Image.asset(
                  'images/2.png',
                  fit: BoxFit.fill,
                  width: 200.w,

                ),
              ),





            ],
          )


        ),
      ),
    );
  }
}
