import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuliptest/Widgets/btn.dart';
import 'package:tuliptest/auth/LoginScreen.dart';

import 'package:tuliptest/services/authService.dart';

import '../utilites/material/font.dart';
import '../utilites/material/padding.dart';
import 'authController/Register/register_controller.dart';
import 'authController/Register/register_service.dart';
import 'frames-UI/registerFrame.dart';

class Register extends StatelessWidget {

  registerController controller=Get.put(registerController());

  bool _passwordVisible = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFEF1F6),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                frameRegister(),
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  children: [
                    TextFormFieldRegister('اسم المستخدم',controller.nameController,TextInputType.text),
                     SizedBox(
                      height: 50.h,
                    ),
                    TextFormFieldRegisterPhone('رقم الهاتف',controller.phoneController,TextInputType.number),
                     SizedBox(
                      height: 50.h,
                    ),
                    Stack(
                      children: [
                        Positioned(
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: padding().formPadding),
                            child: Text(
                              'البريد الالكتروني (أختياري)',
                              style: GoogleFonts.almarai(
                                  fontSize: font().fsHint,
                                  fontWeight: font().fontWeightSecondary,
                                  color: font().HintColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: padding().formPadding),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                isDense: true, hintText: 'Tulip@gmail.com'),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: padding().formPadding),
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Text(
                          'كلمة المرور',
                          style: GoogleFonts.almarai(
                              fontSize: font().fsHint,
                              fontWeight: font().fontWeightSecondary,
                              color: font().HintColor),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: padding().formPadding),
                          child: TextFormField(
                            controller: controller.passController,
                            obscureText: _passwordVisible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  _passwordVisible = !_passwordVisible;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 70.h,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        print('log');
                        await controller.RegisterAccount(controller.phoneController.text, controller.nameController.text, controller.passController.text, context);
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Color(0xffBE338E),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        width: 350.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        child: Text(
                          'إرسال رمز التفعيل',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    hoverColor: Colors.pink[300],
                    splashColor: Colors.pink[300],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
