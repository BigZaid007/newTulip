import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuliptest/auth/OTP/otpScreen.dart';

import '../Controller/getx_Controller.dart';
import '../Screens/mainScreens/initialScreen.dart';
import '../Screens/mainScreens/landingPage.dart';
import '../auth/userController/userController.dart';

void signIn(String phone, password, BuildContext context) async {
  try {
    http.Response response = await post(
      Uri.parse("https://www.tulipm.net/api/Persons/Login/${phone},${password}"),
      body: {
        'userName':phone,
        'password':password
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      if (data['msg'] == "اسم المستخدم او كلمة المرور غير صحيحة") {
        print('Login failed');
        print(response.body);
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
      } else {
        print('Login successfully');

        // Store the authentication token and user ID in SharedPreferences

        String? token = data['data']['token'];
        int? userId = data['data']['id'];
        String? name = data['data']['name'];
        if (token != '' && userId != '' && name != '') {
          Get.find<UserController>().setUser(userId!, name!, token!);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('authToken', token);
          print(data);
         Get.to(()=>InitialScreen());

        } else {
          // Handle the error
        }
      }
    } else {
      var data = jsonDecode(response.body.toString());
      print('Login failed');
      print(response.body);
      showAlertDialog(context, data['msg']);
    }
  } catch(e) {
    print(e.toString());
    showAlertDialog(context, 'حدث خطأ في تسجيل الدخول');
  }
}



//
// void reg(String phone , password,BuildContext context) async {
//
//
//   try{
//
//     http.Response response = await post(
//       Uri.parse("https://www.tulipm.net/api/Persons/RegisterAccount"),
//       body: {
//         'phone':phone,
//         'email':'z@yahoo.com',
//         'name':'testname',
//         'userName':'flutter',
//         'password': password,
//         'code':'123456'
//       },
//         headers: {
//           "Accept": "application/json",
//           "content-type":"application/json"
//         }
//
//     );
//
//
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body.toString());
//       print(data['msg']);
//       if(data['msg']=="هذا الحساب موجود سابقا")
//       {
//         print('الحساب موجود مسبقا');
//         print(response.body);
//         showAlertDialog(context, data['msg']);
//       }
//       else if(data['msg']=="تم تسجيل حساب بنجاح")
//       {
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen()));
//       }
//     }
//
//
//
//     else {
//       var data = jsonDecode(response.body.toString());
//       print('failed');
//       print(response.body);
//       print(data['msg']);
//
//
//
//     }
//   }catch(e){
//     print(e.toString());
//   }
// }
//
// register(String phone, password,BuildContext context) async {
//   Map data = {
//     'phone':phone,
//     'email':'testemail.com',
//     'name':'testuser',
//     'userName':'testuser',
//     'password': password,
//     'code':'000000'
//
//   };
//   print(data);
//
//   String body = json.encode(data);
//   var url = "https://www.tulipm.net/api/Persons/RegisterAccount";
//   try
//   {
//     var response = await http.post(
//         Uri.parse(url),
//         body: body,
//         headers: {
//           "Accept": "application/json",
//           "content-type":"application/json"
//         }
//     );
//     print(response.body);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body.toString());
//       print(data['msg']);
//       if(data['msg']=="هذا الحساب موجود سابقا")
//       {
//         print('الحساب موجود مسبقا');
//         print(response.body);
//         showAlertDialog(context, data['msg']);
//       }
//       else if(data['msg']=="حدث خطا اثناء عملية جلب البيانات")
//       {
//         print('الحساب موجود مسبقا');
//         print(response.body);
//         showAlertDialog(context, data['msg']);
//       }
//
//
//
//
//       else if(data['msg']=="تم تسجيل حساب بنجاح")
//       {
//
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen()));
//
//       }
//     }
//
//     else {
//       print('error');
//     }
//   }
//   catch(e)
//   {
//     print(e.toString());
//   }
//
// }



showAlertDialog(BuildContext context,String msg) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("اعادة المحاولة",style: GoogleFonts.almarai(
      fontSize: 15.sp
    ),textDirection: TextDirection.rtl,),
    onPressed:  () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("تحذير",style: GoogleFonts.almarai(
      fontSize: 20.sp
    ),textDirection: TextDirection.rtl,),
    content: Text(msg),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogSuccuess(BuildContext context,String msg) {
  final InitialScreenController controller = Get.put(InitialScreenController());

  // set up the buttons
  Widget continueButton = TextButton(
    child: Container(
      alignment: AlignmentDirectional.center,
      width: 220.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Color(0xffBE338E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text("العودة للصفحة الرئيسية",style: GoogleFonts.almarai(
        fontSize: 16.sp,color: Colors.white
      ),textDirection: TextDirection.rtl,),
    ),
    onPressed:  () {
      controller.currentIndex=0.obs;
      Get.to(()=>InitialScreen());
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    content: Container(
      decoration: BoxDecoration(
        color: Color(0xffF7B4D1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "تم التسجيل",
            textDirection: TextDirection.rtl,
            style: GoogleFonts.almarai(
              fontSize: 22.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Text(
            msg,
            textDirection: TextDirection.rtl,
            style: GoogleFonts.almarai(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Center(child: continueButton),
        ],
      ),
    ),
  );


  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}