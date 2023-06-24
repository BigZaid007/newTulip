import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuliptest/auth/ConfrimAccout.dart';
import 'package:tuliptest/presentaion/splashOnBoardingScreens/splashScreen.dart';
import 'Widgets/notifScreen.dart';
import 'package:get/get.dart';

import 'auth/userController/userController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(UserController());
  // Initialize the local notification plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(UserController());

    if(authController.userId==0)
      {
        print(authController.userId);
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, child) {
            return splashScreen();
          },
        );
      } else {
      print(authController.userId);
      return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, child) {
          return ConfirmAccountScreen(id: authController.userId,);
        },
      );
      }
  }
}





