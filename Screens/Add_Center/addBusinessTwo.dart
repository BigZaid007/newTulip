import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/appBar/appBarAdding.dart';
import '../../Widgets/btn.dart';
import '../../Widgets/timePicker.dart';
import 'addBusinessThree.dart';

class addBusinessTwo extends StatefulWidget {

  final String centerName;

  final File avatarImage;
  final File containerImage;
  final int selectedOption;
  final List service;

  const addBusinessTwo(this.centerName,this.avatarImage, this.containerImage, this.selectedOption, this.service);

  @override
  State<addBusinessTwo> createState() => _addBusinessTwoState();
}

class _addBusinessTwoState extends State<addBusinessTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTwo(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [

            SizedBox(height: 50.h,),
            Center(child: Image.asset('images/text.png')),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 120).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('مغلق',style: GoogleFonts.almarai(
                      color: Colors.red,
                      fontSize: 16.sp
                  ),),

                  Text('مفتوح',style: GoogleFonts.almarai(
                      color: Colors.green,
                      fontSize: 16.sp
                  ),),
                ],
              ),
            ),
            day('السبت'),
            day('الاحد'),
            day('الاثنين'),
            day('الثلاثاء'),
            day('الاربعاء'),
            day('الخميس'),
            day('الجمعة'),

            SizedBox(
              height: 30.h,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 12).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap:(){
                        Get.back();
                      },

                      child: btnShopCartnoIcon(context,'رجوع',Colors.white)),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: InkWell(

                        onTap: (){
                          Get.to(()=>addBusniessThree(
                            widget.centerName,
                            widget.avatarImage,
                            widget.containerImage,
                            widget.selectedOption,
                            widget.service

                          ));
                        },

                        child: btnShopCart(context, 'التالي', Colors.black)),
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

Widget day(String dName) {
  return Padding(
    padding: const EdgeInsets.all(8.0).r,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TimePickerContainer(iconColor: Colors.red[300]),
        TimePickerContainer(iconColor: Colors.green[300]),
        SizedBox(
          width: 12.w,
        ),
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            dName,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            textDirection: TextDirection.rtl,
          ),
          width: 50.w,
          height: 50.h,
          decoration:
          BoxDecoration(color: Color(0xffBE338E), shape: BoxShape.circle),
        ),
      ],
    ),
  );
}
