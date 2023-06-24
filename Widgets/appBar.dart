import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuliptest/notification/norificationsScreen.dart';
import 'package:tuliptest/services/authService.dart';

import '../Message/View/ChatScreen.dart';
import '../Message/View/MessageScreen.dart';
import '../auth/authLandingPage.dart';
import '../auth/userController/userController.dart';
import '../Screens/Menu/menuScreen.dart';

AppBar landingAppBar(BuildContext context)
{
  int userId = Get.find<UserController>().userId;

  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xfffce3ee),
    leading:GestureDetector(
      onTap: () {
        if(userId==0)
        {
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text(
                'يجب انشاء حساب لغرض عرض الصفحة الشخصية',
                style: GoogleFonts.almarai(fontSize: 15.sp),
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: Color(0xfffce3ee),
              title: Text(
                'يرجى إنشاء حساب',
                textDirection: TextDirection.rtl,
                style: GoogleFonts.almarai(fontSize: 20.sp),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 120.w,
                    height: 40.h,
                    child: Text(
                      'العودة',
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.almarai(fontSize: 16.sp, color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => authScreen());
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 120.w,
                    height: 40.h,
                    child: Text(
                      'إنشاء حساب',
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.almarai(fontSize: 16.sp, color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            );
          });
        }
        else
        Get.to(MenuScreen());
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffF38BB9), width: 1.3),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Color(0xfffef4f8),
          ),
          child:  Icon(
            FontAwesomeIcons.bars,
            color: Color(0xffA61379),
          ),
          // remove the onPressed property
        ),
      ),
    ),


    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 13, top: 10),
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  if(userId==0)
                  {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        content: Text(
                          'يجب انشاء حساب لغرض عرض الصفحة الشخصية',
                          style: GoogleFonts.almarai(fontSize: 15.sp),
                          textDirection: TextDirection.rtl,
                        ),
                        backgroundColor: Color(0xfffce3ee),
                        title: Text(
                          'يرجى إنشاء حساب',
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.almarai(fontSize: 20.sp),
                        ),
                        actions: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              width: 120.w,
                              height: 40.h,
                              child: Text(
                                'العودة',
                                textDirection: TextDirection.rtl,
                                style: GoogleFonts.almarai(fontSize: 16.sp, color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => authScreen());
                            },
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              width: 120.w,
                              height: 40.h,
                              child: Text(
                                'إنشاء حساب',
                                textDirection: TextDirection.rtl,
                                style: GoogleFonts.almarai(fontSize: 16.sp, color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
                  }
                  else
                    print(userId);
                  Get.to(()=>NotificationsScreen());
                },
                icon: const Icon(
                  Icons.notifications_active,
                  color: Color(0xffA61379),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: (){
                  if(userId==0)
                  {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        content: Text(
                          'يجب انشاء حساب لغرض عرض الصفحة الشخصية',
                          style: GoogleFonts.almarai(fontSize: 15.sp),
                          textDirection: TextDirection.rtl,
                        ),
                        backgroundColor: Color(0xfffce3ee),
                        title: Text(
                          'يرجى إنشاء حساب',
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.almarai(fontSize: 20.sp),
                        ),
                        actions: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              width: 120.w,
                              height: 40.h,
                              child: Text(
                                'العودة',
                                textDirection: TextDirection.rtl,
                                style: GoogleFonts.almarai(fontSize: 16.sp, color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => authScreen());
                            },
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              width: 120.w,
                              height: 40.h,
                              child: Text(
                                'إنشاء حساب',
                                textDirection: TextDirection.rtl,
                                style: GoogleFonts.almarai(fontSize: 16.sp, color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
                  }
                  else
                  Get.to(()=>ChatScreen(userID: userId));
                },
                child: Container(
                  width: 50,
                  child: Icon(FontAwesomeIcons.comments,color: Color(0xffA61379),)
                ),
              )
            ],
          ),
          width: 127,
          height: 46,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffF38BB9), width: 1.3),
              borderRadius: BorderRadius.circular(23.4),
              color: Color(0xfffef4f8)),
        ),
      ),
    ],
  );
}