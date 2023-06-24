import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


import '../Screens/Add_Center/addBusinessOne.dart';
import '../Screens/Add_Shop/addShopOne.dart';
import '../Screens/addBlogger/addBlogger.dart';

Widget alertDialogBus(BuildContext context) {
  return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Color(0xfffef1f6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
            color: Color(0xfffef1f6),
            width: 400.0.w,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/4.png'),
                          alignment: AlignmentDirectional.topStart),
                      color: Color(0xffBE338E),
                    ),
                    child: Center(
                      child: Text(
                        'أختر نوع الحساب',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      highlightColor: Colors.pink[300],
                      splashColor: Colors.pink[300],
                      onTap: () {
                        Get.back();
                        Get.to(() => addBusinessOne());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0).r,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                            color: Color(0xfffef1f6),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10.0,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'حساب مركز',
                              style:GoogleFonts.almarai(
                                fontSize: 18.0.sp,
                                color: Colors.black,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      Get.to(() => addShopOne());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0).r,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                          color: Color(0xfffef1f6),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'حساب متجر',
                            style: GoogleFonts.almarai(
                              fontSize: 18.0.sp,
                              color: Colors.black,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      Get.to(() => addBlogger());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0).r,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                          color: Color(0xfffef1f6),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'حساب بلوكر/موديل',
                            style: GoogleFonts.almarai(
                              fontSize: 18.0.sp,
                              color: Colors.black,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                  )
                ],),),
      ),);
}
