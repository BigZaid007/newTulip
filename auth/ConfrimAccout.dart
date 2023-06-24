import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuliptest/Screens/Add_Center/addBusinessOne.dart';
import 'package:tuliptest/Screens/mainScreens/initialScreen.dart';
import 'package:tuliptest/auth/OTP/otpScreen.dart';
import 'package:http/http.dart' as http;
import 'package:tuliptest/auth/userController/userController.dart';
import 'package:video_player/video_player.dart';

import 'authLandingPage.dart';




class ConfirmAccountScreen extends StatelessWidget {
  final int id;

  const ConfirmAccountScreen({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyConfirmController(personId: id));

    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          body: Center(
            child: Container(
              width: 300.w,
              height: 300.h,
              child: Lottie.asset('images/fl.json')
            ),
          ),
        );
      } else {
        final personTypeId = controller.personData.value['personTypeId'];
        print('personTypeId: $personTypeId'); // Print the value of personTypeId

        if (personTypeId == null || personTypeId == 0) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pink[200],
              centerTitle: true,
              title: Text('تأكيد الحساب'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(22.0).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('يرجى لتأكيد الحساب',style: GoogleFonts.almarai(
                    fontSize: 22.sp,
                  ),textDirection: TextDirection.rtl,),
                  SizedBox(height: 5.h,),
                  Text('سيتم ارسال رمز التأكيد الى الرقم',style: GoogleFonts.almarai(
                    fontSize: 22.sp,
                  ),textDirection: TextDirection.rtl,),
                  SizedBox(height: 10.h,),
                  Text('${controller.personData.value['phone']}',style: GoogleFonts.almarai(
                    fontSize: 22.sp
                  ),textDirection: TextDirection.rtl,),
                  SizedBox(height: 10.h,),
                  InkWell(
                    onTap: (){
                      Get.off(()=>OTPScreen(phone: controller.personData.value['phone'], name: controller.personData.value['name']));
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: Colors.pink[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: 130.w,
                      height: 50.h,
                      child: Text('تأكيد الحساب',style: GoogleFonts.almarai(
                        fontSize: 22.sp
                      ),),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 16),
                                Text('جاري تسجيل الخروج...'),
                              ],
                            ),
                          );
                        },
                      );

                      UserController userController = Get.find<UserController>();
                      userController.clearUser();

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('token', '');

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context); // Close the loading dialog
                        Get.to(() => authScreen());
                      });
                    },
                    child: Text(
                      'العودة لصفحة التسجيل',
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.w700,
                        color: Color(0xffB3261E),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          Future.delayed(Duration.zero, () {
            Get.off(() => InitialScreen());
          });        }
        return Scaffold(

          body: Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: Colors.pink,
            ),
          ),
        );
      }
    });
  }
}

class MyConfirmController extends GetxController {
  final int personId;
  Rx<Map<String, dynamic>> personData = Rx<Map<String, dynamic>>({});
  var isLoading = true.obs;

  MyConfirmController({required this.personId});

  @override
  void onInit() {
    super.onInit();
    _fetchPersonData();
  }

  Future<void> _fetchPersonData() async {
    try {
      final response = await http.get(Uri.parse('https://www.tulipm.net/api/Persons/GetPersonById/$personId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        personData.value = data;
      } else {
        throw Exception('Failed to load person data');
      }
    } catch (e) {
      throw Exception('Failed to load person data');
    } finally {
      await Future.delayed(Duration(seconds: 3)); // Delay for 3 seconds
      isLoading.value = false;
    }
  }
}










