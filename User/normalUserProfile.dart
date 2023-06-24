import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tuliptest/Controller/getx_Controller.dart';
import 'package:tuliptest/Screens/mainScreens/initialScreen.dart';
import 'package:tuliptest/User/userService/userService.dart';

import '../Widgets/alertforbus.dart';
import '../Widgets/btn.dart';
import '../auth/userController/userController.dart';

class userNormalScreen extends StatelessWidget {
  final int id;
  final UserController userController = Get.find<UserController>();

  userNormalScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onPressed: () {
              Get.find<InitialScreenController>().changeIndex(0);
            },
          ),
        ],
        backgroundColor: Color(0xff0ffBE338E),
        centerTitle: true,
        title: Text(
          'الصفحة الشخصية',
          style: GoogleFonts.almarai(),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUser(userController.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.pinkAccent,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final user = snapshot.data!;
            return Column(
              children: [
                SizedBox(height: 50.h,),
                Padding(
                  padding: const EdgeInsets.all(5.0).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 170.0.w,
                        height: 190.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: user['logo'] != null
                              ? CachedNetworkImage(
                            imageUrl: user['logo'],
                            placeholder: (context, url) => Icon(Icons.person),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            fit: BoxFit.cover,
                          )
                              : Icon(Icons.person),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(' مرحبا بك',style: GoogleFonts.almarai(
                            fontSize: 25.sp,

                          ),textDirection: TextDirection.rtl,),
                          SizedBox(height: 5.h,),
                          Text(
                            user['name'],
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )



                    ],
                  ),
                ),

                SizedBox(height: 120.h,),
                InkWell(
                    onTap: (){

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alertDialogBus(context);
                        },
                      );

                    },
                    child: btnBusUser(context)),
              ],
            );

          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getUser(int id) async {
    final url = 'https://www.tulipm.net/api/Persons/GetPersonById/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final userJson = json['data'];
      return userJson;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
