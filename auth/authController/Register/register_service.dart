// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:tuliptest/auth/authController/Register/register_model.dart';
//
// import '../../../services/authService.dart';
// import '../../OTP/otpScreen.dart';
// import '../../OTP/services/OTP_service.dart';
//
// void registerAccount(
//     String phone, String name, String password, BuildContext context) async {
//   if (phone == null || name == null || password == null) {
//     showAlertDialog(context, 'Please enter valid data');
//     return;
//   }
//
//   final url = Uri.parse('https://www.tulipm.net/api/Persons/RegisterAccount');
//   final headers = {
//     'accept': '*/*',
//     'Content-Type': 'application/json',
//   };
//   final body = {
//     'phone': phone,
//     'name': name,
//     'password': password,
//   };
//   final response =
//       await http.post(url, headers: headers, body: json.encode(body));
//   if (response.statusCode == 200) {
//     var data = jsonDecode(response.body.toString());
//     print(data['msg']);
//     if (data['msg'] == "هذا الحساب موجود سابقا") {
//       print('الحساب موجود مسبقا');
//       print(response.body);
//       showAlertDialog(context, data['msg']);
//     } else if (data['msg'] == "حدث خطا اثناء عملية جلب البيانات") {
//       print('الحساب موجود مسبقا');
//       print(response.body);
//       showAlertDialog(context, data['msg']);
//     } else if (data['msg'] == "تم تسجيل حساب بنجاح") {
//       await sendOTPCodeToPhone(phone);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => OTPScreen(
//             phone: data['phone'] ?? '',
//             name: data['name'] ?? '',
//             code: data['code'] ?? '',
//           ),
//         ),
//       );
//     }
//   } else {
//     throw Exception('Failed to register account');
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:tuliptest/Screens/mainScreens/initialScreen.dart';

Future<void> RegisterUserWithImage(int id, File imageFile) async {
  final url = 'https://www.tulipm.net/api/Persons/RegisterUser';
  final request = http.MultipartRequest('POST', Uri.parse(url));
  request.fields['Id'] = id.toString();
  request.fields['Long'] = '';
  request.fields['Lat'] = '';
  request.fields['IsActive'] = '';
  request.fields['CountryId'] = '';
  request.files.add(await http.MultipartFile.fromPath('FileChoose', imageFile.path));
  final response = await request.send();
  if (response.statusCode == 200) {
    print('Success!');
    Get.snackbar(
      'Success',
      'تم تسجيل الحساب بنجاح',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    await Future.delayed(Duration(seconds: 2));
    Get.to(()=>InitialScreen());
  } else {
    print('Error: ${response.statusCode}');
  }
}
