import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Message/View/MessageScreen.dart';
import '../../../Screens/makeReserve/reserveScreen.dart';

Widget Postcontainer()
{
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0).r,
    height: 1,
    color: Colors.grey[300],
  );
}

Widget postBtn(BuildContext context,int userId,int centerId,String logo,String name)
{
  return  Padding(
    padding: const EdgeInsets.only(top: 3).r,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap:(){
            Get.to(()=>MessageScreen(senderId: userId, receiverId: centerId,logo: logo,name: name,));
          },
          child: Container(
            alignment: AlignmentDirectional.center,
            width: 150.w,
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color:  Color(0xffA61379),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.telegram,color: Color(0xffA61379),),
                SizedBox(width: 8.w,),
                Text('مراسلة',style: GoogleFonts.almarai(
                    fontSize: 15.sp
                ),),

              ],
            ),
          ),
        ),
        SizedBox(width: 5.w,),
        InkWell(
          onTap: (){
            Get.to(()=>ReservationScreen(centerId: centerId,centerName: name,));

          },
          child: Container(
            width: 150.w,

            alignment: AlignmentDirectional.center,
            height: 30.h,
            decoration: BoxDecoration(
              color: Color(0xffA61379),

              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month,color: Colors.white,),
                SizedBox(width: 8.w,),
                Text('حجز موعد',style: GoogleFonts.almarai(
                    fontSize: 15.sp,
                    color: Colors.white
                ),),

              ],
            ),
          ),
        ),
      ],
    ),
  );
}