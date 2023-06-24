import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuliptest/Screens/mainScreens/landingPage.dart';
import 'package:tuliptest/Widgets/btn.dart';
import 'package:tuliptest/auth/OTP/services/OTP_service.dart';
import 'package:tuliptest/auth/RegisterUser/Register_user.dart';


import '../../Screens/mainScreens/initialScreen.dart';
import '../../utilites/material/font.dart';
import '../userController/vistorController.dart';
import 'otpField.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String name;




  const OTPScreen(
      {Key? key, required this.phone, required this.name})
      : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  final List<TextEditingController> _controllers = List.generate(
      4,
      (_) =>
          TextEditingController()); // Create a list of 6 text editing controllers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffce3ee),
      appBar: AppBar(
        backgroundColor: Color(0xfffce3ee),
        title: Text('OTP Verification',style: TextStyle(
          color: Colors.black
        ),),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'images/3.png',
                width: 250.w,
                height: 200.h,
              ),
              Text('يرجى إدخال رمز التحقق المُرسل الى الرقم ${widget.phone}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.almarai(fontSize: 22, color: Colors.black)),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 4; i++)
                    SizedBox(
                      width: 50.w,
                      child: TextField(
                        controller: _controllers[i],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                          hintText: '*',
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && i < 5) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && i > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                ],
              ),
              SizedBox(height: 50.h),
              InkWell(
                onTap: () async {
                  String otp = '';
                  for (int i = 0; i < 4; i++) {
                    otp += _controllers[i].text;
                  }
                  await confirmAccount(widget.phone, widget.name, otp);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15).r,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Text('تأكيد الرمز',
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: font().fontWeightBtn,
                            color: Colors.white)),
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffBE338E)),
                  ),
                ),
              ),
              SizedBox(height: 50.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      await sendOTPCodeToPhone(widget.phone);
                    },
                    child: Text('اعادة ارسال الرمز',style: GoogleFonts.almarai(
                        fontSize: 16.sp,color: Colors.pink
                    ),),
                  ),
                  SizedBox(width: 8.w,),
                  Text('لم تستلم الرمز الى الان؟',style: GoogleFonts.almarai(
                      fontSize: 16.sp,color: Colors.black
                  ),),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
