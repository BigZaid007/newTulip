import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../RegisterUser/Register_user.dart';

Future<String> sendOTPCodeToPhone(String phone) async {
  final url = Uri.parse('https://www.tulipm.net/api/Persons/SendOTPCodeToPhoneNo/$phone');
  final headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
  };
  final response = await http.post(url, headers: headers);
  if (response.statusCode == 200) {
    final body = response.body;
    return body;
  } else {
    throw Exception('Failed to send OTP code');
  }
}
Future<void> confirmAccount(String phone, String name, String code) async {
  final url = 'https://www.tulipm.net/api/Persons/ConfirmAccount/$code,$name,$phone';

  try {
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final msg = jsonResponse['msg'];
      if (msg == "تم تاكيد حسابك بنجاح") {
        Get.offAll(RegisterUser());
      } else {
        Get.snackbar(
          'خطأ',
          'يرجى التأكد من الرمز المستلم',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء التأكيد',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    Get.snackbar(
      'Error',
      'An error occurred: $e',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

