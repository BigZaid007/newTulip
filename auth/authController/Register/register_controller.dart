import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Controller/getx_Controller.dart';
import '../../../services/authService.dart';
import '../../OTP/otpScreen.dart';
import '../../OTP/services/OTP_service.dart';
import '../../userController/userController.dart';

class registerController extends GetxController
{
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _passwordVisible = true;
   final Future<SharedPreferences> prfs = SharedPreferences.getInstance();

  Future<void> RegisterAccount(String phone, String name, String password, BuildContext context) async {
    final url = Uri.parse('https://www.tulipm.net/api/Persons/RegisterAccount');
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    final body = {
      'phone': phone,
      'name': name,
      'password': password,
    };
    final response = await http.post(url, headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data['msg']);
      if (data['msg'] == "اسم الحساب  او رقم الهاتف موجود سابقا") {
        print('الحساب موجود مسبقا');
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 1,
                      color: Colors.purpleAccent,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'جارٍ التحميل...',
                      style: TextStyle(fontSize: 16.sp),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            );
          },
        );

        await Future.delayed(Duration(seconds: 2));

        Navigator.of(context, rootNavigator: true).pop();

        await showAlertDialog(context, data['msg']);
        print(response.body);

        print(response.body);
      } else if (data['msg'] == "حدث خطا اثناء عملية جلب البيانات") {
        print('الحساب موجود مسبقا');
        print(response.body);
        showAlertDialog(context, data['msg']);
      } else if (data['msg'] == "تم تسجيل حساب بنجاح") {
        print('تم تسجيل الحساب بنجاح');
        print(response.body);
        int userId = data['data']['id'];
        String name = data['data']['name'];
        String token=data['data']['token'];
        Get.find<UserController>().setUser(userId, name,token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', userId.toString());
        prefs.setString('token', data['data']['token']).toString();
        prefs.setString('Name', name);
        await sendOTPCodeToPhone(phone);
        Get.to(()=>OTPScreen(phone: phone, name: name));
      }
    } else {
      throw Exception('Failed to register account');
    }
  }

}