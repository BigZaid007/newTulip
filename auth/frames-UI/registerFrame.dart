import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuliptest/auth/LoginScreen.dart';


import '../../utilites/material/font.dart';
import '../../utilites/material/padding.dart';


Widget frameRegister()
{
  return Stack(
    overflow: Overflow.visible,
    children: [
      Image.asset('images/fr.png'),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 29),
              child: GestureDetector(
                onTap: () {
                  Get.to(LoginScreen());
                },
                child: Text('تسجيل دخول ',
                  style: GoogleFonts.almarai(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                  textDirection: TextDirection.rtl,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 29),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
            )
          ],
        ),
      ),

      Positioned(
        top: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Image(
                image: AssetImage('images/4.png'),
              ),
            ),
            Column(
              children: [
                Text(
                  'مستخدم جديد',
                  style: GoogleFonts.almarai(
                      fontWeight: font().fontWeightPrimary,
                      fontSize: font().fsTitle,
                      color: font().fcGrey),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'إنشاء حساب',
                  style: GoogleFonts.almarai(
                      fontWeight: font().fontWeightPrimary,
                      fontSize: font().fsTitle,
                      color: font().fcBlack),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget TextFormFieldRegister(String text,TextEditingController controller,TextInputType type)
{
  return Stack(
    children: [
      Positioned(
        right: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: padding().formPadding),
          child: Text(
            text,
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
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'يجب ادخال المعلومات';
            }
            return null;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          decoration: InputDecoration(
            hintText: '',

            isDense: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 4),
            ),
            prefixIconConstraints:
            const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
          keyboardType: type,
        ),
      ),
    ],
  );
}

Widget TextFormFieldRegisterPhone(String text,TextEditingController controller,TextInputType type)
{
  return Stack(
    children: [
      Positioned(
        right: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: padding().formPadding),
          child: Text(
            text,
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
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'يجب ادخال المعلومات';
            }
            if(value.length!=11)
              {
                return 'incomplete number 07XXXXXXXXX';
              }
            return null;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          decoration: InputDecoration(
            hintText: '',
            prefixText: '+964',

            isDense: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 4),
            ),
            prefixIconConstraints:
            const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
          keyboardType: type,
        ),
      ),
    ],
  );
}