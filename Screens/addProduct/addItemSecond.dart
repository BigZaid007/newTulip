import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuliptest/Screens/Market/marketScreenType/storeScreen.dart';
import 'package:tuliptest/Screens/addProduct/service/Product.dart';

import '../../Widgets/btn.dart';
import '../../Widgets/notifScreen.dart';
import '../../Widgets/tags.dart';
import '../../models/notification.dart';
import 'addITem.dart';
import 'additemThird.dart';

class addItemSecond extends StatefulWidget {
  List<File> productImgs;
  int storeId;
  String categoryId;
   addItemSecond(this.productImgs,this.storeId,this.categoryId) ;

  @override
  State<addItemSecond> createState() => _addItemSecondState();
}

class _addItemSecondState extends State<addItemSecond> {
  TextEditingController itemName = TextEditingController();
  TextEditingController itemDet = TextEditingController();
  TextEditingController itemPrice = TextEditingController();
  String _priceSuffix= 'د.ع';
  bool isFavorite = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Image.asset('images/label2.png')],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'اضافة منتج جديد',
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              height: 3.0,
              width: MediaQuery.of(context).size.width / 2,
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
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Container(
                    width: 300.w,
                    height: 149.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent, width: 1),
                      color: Color(0xfffef8fb),
                      image: DecorationImage(
                          alignment: AlignmentDirectional.centerEnd,
                          image: AssetImage('images/i.png')),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10)
                          .r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: [
                          Text(
                            'بحاجة الى المساعدة',
                            style: GoogleFonts.almarai(
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'يمكنك الاتصال بموظفينا لمساعدتك',
                            style: GoogleFonts.almarai(
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 1,
                            width: double.infinity,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Add your phone call logic here
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.phone, color: Colors.redAccent),
                                    SizedBox(width: 5.w),
                                    Text(
                                      'اتصل الان',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 25.h,
                                width: 1.w,
                                color: Colors.grey,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                              ),
                              Text('لاحقا', style: TextStyle(fontSize: 17)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'اسم المنتج',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: itemName,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'ادخل اسم المنتج هنا'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب ادخال اسم المنتج'; // error message to display if the value is empty
                        }
                        return null; // return null if the value is not empty
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'معلومات المنتج',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: itemDet,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'ادخل معلومات المنتج هنا'),
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'سعر المنتج',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: itemPrice,
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        hintText: 'ادخل سعر المنتج هنا/السعر للقطعة المفرد',
                        suffixText: _priceSuffix ,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال قيمة للسعر';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'تحديد كمنتج مفضل',
                          style: GoogleFonts.almarai(
                              fontSize: 17.sp, color: Colors.grey),
                        ),
                        Checkbox(
                          value: isFavorite,
                          onChanged: (bool? value) {
                            if (value != null) {
                              setState(() {
                                isFavorite = value;
                              });
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: btnShopItem2(context, 'رجوع', Colors.white)),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          double itemPriceValue = double.tryParse(itemPrice.text)!;
                          int categoryId=int.parse(widget.categoryId);

                          Product newProduct = Product(
                            productsPrice: itemPriceValue,
                            productsDiscount: 0,
                            isShow: true,
                            isDiscount: true,
                            productsName: itemName.text,
                            shopId: widget.storeId,
                            categoriesId: categoryId,
                            productsDetails: itemDet.text,
                            productsId: 0,
                            fileChoose: widget.productImgs,
                          );

                          try {
                            await addProduct(newProduct);
                            Get.to(()=>addItemThird());
                          } catch (e) {
                            // Handle error
                          }
                        }
                      },
                      child: btnShopItem(context, 'التالي', Color(0xff202124)),
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
