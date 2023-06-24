import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../Screens/mainScreens/initialScreen.dart';

class AnimationLoaderScreen extends StatefulWidget {
@override
_AnimationLoaderScreenState createState() => _AnimationLoaderScreenState();
}

class _AnimationLoaderScreenState extends State<AnimationLoaderScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds and then navigate to the InitialScreen
    Future.delayed(Duration(seconds: 4), () {
      Get.offAll(InitialScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300.w,
          height: 300.h,
          child: Lottie.asset('images/fl.json'),
        ),
      ),
    );
  }
}