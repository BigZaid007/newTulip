import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

Widget productAppBar(BuildContext context) {
  return AppBar(
    actions: [Image.asset('images/label1.png')],
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black54,
      ),
      onPressed: () {
        Get.back();
      },
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text(
      'اضافة منتج جديد',
      style: TextStyle(color: Colors.black),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Container(
        height: 3.0,
        width: MediaQuery.of(context).size.width / 3,
        color: Color(0xffEA6CB0),
      ),
    ),
  );
}

Widget contanctInfo()
{
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16).r,
    child: Center(
      child: Container(
        width: 300.w,
        height: 149.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.redAccent, width: 1),
          color: Color(0xfffef8fb),
          image: DecorationImage(
              alignment: AlignmentDirectional.centerEnd,
              image: AssetImage('images/i.png')),
        ),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
              .r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Text(
                'بحاجة الى المساعدة',
                style: GoogleFonts.almarai(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'يمكنك الاتصال بموظفينا لمساعدتك',
                style: GoogleFonts.almarai(
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                color: Colors.grey,
                height: 1,
                width: double.infinity,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Add your phone call logic here
                    },
                    child: Row(
                      children: [
                        Icon(Icons.phone, color: Colors.redAccent),
                        SizedBox(width: 5.w),
                        Text(
                          'اتصل الان',
                          style: TextStyle(
                              color: Colors.redAccent, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25.h,
                    width: 1.w,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Text('لاحقا', style: TextStyle(fontSize: 17)),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}