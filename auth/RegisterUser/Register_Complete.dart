import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuliptest/Screens/mainScreens/initialScreen.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true,period: Duration(seconds: 3));

    _opacityAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    // Delay navigation to initial screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(InitialScreen());
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150.0.w,
                  height: 150.0.h,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                    strokeWidth: 8.0,
                  ),
                ),
                FadeTransition(
                  opacity: _opacityAnimation!,
                  child: Icon(
                    Icons.check_circle,
                    size: 80.0.sp,
                    color: Colors.pink[200],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0.h),
            Text(
              'تم التسجيل بنجاح',
              style: TextStyle(fontSize: 18.0.sp, color: Colors.pink[200]),
            ),
          ],
        ),
      ),
    );
  }
}

