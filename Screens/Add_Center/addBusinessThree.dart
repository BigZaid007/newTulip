import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tuliptest/Screens/mainScreens/initialScreen.dart';
import 'package:tuliptest/models/center/model/centerModel.dart';

import '../../Controller/getx_Controller.dart';
import '../../Widgets/appBar/appBarAdding.dart';
import '../../Widgets/btn.dart';
import '../../Widgets/notifScreen.dart';
import '../../auth/userController/userController.dart';
import '../../models/center/services/center_service.dart';
import '../../models/notification.dart';
import '../../services/authService.dart';
import 'addBusinessTwo.dart';

class addBusniessThree extends StatefulWidget {
  final String centerName;
  final File avatarImage;
  final File containerImage;
  final int selectedOption;
  final List service;

  const addBusniessThree(
      this.centerName, this.avatarImage, this.containerImage, this.selectedOption, this.service);


  @override
  State<addBusniessThree> createState() => _addBusniessThreeState();
}

class _addBusniessThreeState extends State<addBusniessThree> {
  TextEditingController businessDescription = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  int id = Get.find<UserController>().userId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarThree(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Center(child: Image.asset('images/text2.png')),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '* معلومات العمل التجاري',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w700),
                      textDirection: TextDirection.rtl,
                    ),
                    Container(
                      width: double.infinity,
                      height: 3.h,
                      color: Colors.black54,
                    ),
                    TextFormField(
                      controller: businessDescription,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'ادخل معلومات المركز هنا'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى إدخال معلومات المركز';
                        }
                        if (value.length > 250) {
                          return 'لا يمكن أن تتجاوز معلومات المركز 250 حرفًا';
                        }
                        return null;
                      },
                      maxLength: 250,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          maxLength}) {
                        return Text(
                          '$currentLength / $maxLength',
                          style: TextStyle(
                            color:
                                currentLength > maxLength! ? Colors.red : null,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12).r,
                child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        centerService().postCenter(centerModel(
                            centerName: widget.centerName,
                            backgroundFile: widget.containerImage,
                            logoFile: widget.avatarImage,
                            sectionsId: widget.selectedOption,
                            service: widget.service,
                            latitude: 10,
                            longitude: 10,
                            countryId: 1,
                            id: id,
                            description: businessDescription.text));
                        print(widget.selectedOption);
                        showAlertDialogSuccuess(context,
                            'سيتم التواصل معكم عند الانتهاء من تدقيق المعلومات');
                        print('Added');


                        // final NotificationModel notification = NotificationModel(
                        //   notificationId: 1,
                        //   details: 'تم تسجيل المركز بنجاح',
                        //   title: 'مبروك',
                        //   dateInsert: DateTime.now(),
                        //   userId: 1,
                        //   shopId: 1,
                        //   centerId: 1,
                        // );
                        //
                        // showNotification(notification);
                      }
                    },
                    child: btnAddBus(
                        context, 'اضافة العمل التجاري', Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
