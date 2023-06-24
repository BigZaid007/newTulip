import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuliptest/Screens/mainScreens/initialScreen.dart';

import '../../Widgets/btn.dart';
import '../../Widgets/notifScreen.dart';
import '../../models/notification.dart';
import 'addITem.dart';

class addItemThird extends StatefulWidget {
  const addItemThird({Key? key}) : super(key: key);

  @override
  State<addItemThird> createState() => _addItemThirdState();
}

class _addItemThirdState extends State<addItemThird> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset('images/label3.png')
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'اضافة منتج جديد',
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              height: 3.0,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffEA6CB0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            SizedBox(height: 100.h,),
            Image(image: AssetImage('images/box.png'),
            ),
            SizedBox(height: 10.h,),
            Text('!تمت اضافة المنتج بنجاح',style: GoogleFonts.almarai(
              fontWeight: FontWeight.w700,
              fontSize: 28.sp
            ),),

            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(()=>InitialScreen());
                    },
                    child: btnShopItem2(context, 'العودة الى المتجر', Colors.white)),

                GestureDetector(
                    onTap: () {
                      final NotificationModel notification = NotificationModel(
                        notificationId: 1,
                        details: 'تم اضافة المنتج بنجاح',
                        title: 'مبروك',
                        dateInsert: DateTime.now(),
                        userId: 1,
                        shopId: 1,
                        centerId: 1,
                      );

                      showNotification(notification);

                    },
                    child: btnShopCart(context, 'اضافة المنتج', Color(0xff202124)))
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
