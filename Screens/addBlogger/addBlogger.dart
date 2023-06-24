import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuliptest/auth/userController/userController.dart';
import 'package:tuliptest/models/blogger/blogger_service.dart';

import '../../Widgets/btn.dart';
import '../../Widgets/notifScreen.dart';
import '../../models/blogger/blogger_model.dart';


class addBlogger extends StatefulWidget {
  const addBlogger({Key? key}) : super(key: key);

  @override
  State<addBlogger> createState() => _addBloggerState();
}

class _addBloggerState extends State<addBlogger> {
  bool isModelChecked = false;
  bool isBlockerChecked = false;
  File? _selectedAvatarImage;
  int selectedCheckbox = 0;
  int checkboxValue = 0;
  TextEditingController bloggerName=TextEditingController();
  TextEditingController bloggerController=TextEditingController();
  int userId = Get.find<UserController>().userId;
  final _formKey = GlobalKey<FormState>();
  CircleAvatar _avImage = CircleAvatar(
    child: Image.asset('images/lo.png'),
    radius: 75,
    backgroundColor: Color(0xffF38BB9),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black54,),
          onPressed: (){
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('اضافة المعلومات الخاصة',style: TextStyle(
            color: Colors.black
        ),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              height: 3.0,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffEA6CB0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10).r,
                child: InkWell(
                  onTap: _getFromGalleryAvatar,
                  child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                              Border.all(color: Colors.white, width: 1)),
                          child: _avImage)),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15).r,
                  child: Text('* حقل اجباري',style: TextStyle(
                      fontSize: 18.sp
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('* اسم البلوكر',style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700
                    ),
                      textDirection: TextDirection.rtl,),
                    Container(
                      width: double.infinity,
                      height: 3.h,
                      color: Colors.black54,
                    ),
                    TextFormField(
                      controller: bloggerName,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'ادخل اسم البلوكر'
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى ادخال اسم البلوكر';
                        }
                        if (value.length > 25) {
                          return 'لا يمكن أن يتجاوز طول الاسم 25 حرفًا';
                        }
                        if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                          return 'يجب أن يحتوي الاسم فقط على أحرف وأرقام';
                        }
                        return null;
                      },
                    ),

                  ],
                ),
              ),
              SizedBox(height: 30.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('نوع الحساب',style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700
                    ),
                      textDirection: TextDirection.rtl,),


              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: selectedCheckbox == 1,
                        onChanged: (value) {
                          setState(() {
                            selectedCheckbox = 1;
                            checkboxValue = 1;
                          });
                        },
                      ),
                      Text(
                        'موديل',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: selectedCheckbox == 2,
                        onChanged: (value) {
                          setState(() {
                            selectedCheckbox = 2;
                            checkboxValue = 2;
                          });
                        },
                      ),
                      Text(
                        'بلوكر',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              )


            ],
                ),
              ),
              SizedBox(height: 30.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('* معلومات البلوكر',style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700
                    ),
                      textDirection: TextDirection.rtl,),
                    Container(
                      width: double.infinity,
                      height: 3.h,
                      color: Colors.black54,
                    ),
                    TextFormField(
                      controller: bloggerController,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'ادخل معلومات البلوكر هنا'
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى إدخال معلومات البلوكر';
                        }
                        if (value.length > 250) {
                          return 'لا يمكن أن تتجاوز معلومات البلوكر 250 حرفًا';
                        }
                        return null;
                      },
                      maxLength: 250,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
                        return Text(
                          '$currentLength / $maxLength',
                          style: TextStyle(
                            color: currentLength > maxLength! ? Colors.red : null,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h,),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 12).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnShopCartnoIcon(context,'الغاء',Colors.white),
                    GestureDetector(
                      onTap: (){
                        if (_formKey.currentState!.validate()) {
                          BloggerService().registerModel(RegisterModelRequest(
                            ModelName: 'bloggerName.text',
                            Description:' bloggerController.text',
                            id: userId,
                            lat: '10',
                            long: '10',
                            // countryId: 1,
                            isActive: true,
                            modelTypeId: selectedCheckbox,
                            fileChoose: _selectedAvatarImage!
                          ));




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
                        child: btnShopCart(context, 'تسجيل', Colors.black),
                    ),


                  ],
                ),
              ),




            ],
          ),
        ),
      ),

    );
  }

  void _getFromGalleryAvatar() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      if (pickedFile != null) {
        _selectedAvatarImage = File(pickedFile.path);
        _avImage = CircleAvatar(
          child: Image.file(_selectedAvatarImage!),
          radius: 75,
          backgroundColor: Color(0xffF38BB9),
        );
      }
    });
  }




}