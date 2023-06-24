import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Screens/mainScreens/landingPage.dart';
import 'package:http/http.dart' as http;

import 'login_model.dart';

Future<void> sendLoginRequest(String email, String password,BuildContext context) async {

  final response = await http.post(
    Uri.parse("https://www.tulipm.net/api/Persons/Login/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  var data = jsonDecode(response.body.toString());


  if (response.statusCode == 200) {
    print('success');
    //Get.to(()=>landingPage());
    print(data);


    print(response.body);
  } else {
    // Login failed
    print('Failed to log in: ${response.body}');
  }
}
