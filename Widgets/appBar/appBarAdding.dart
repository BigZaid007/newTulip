import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuliptest/Screens/mainScreens/initialScreen.dart';

AppBar appBarOne(BuildContext context)
{
  return AppBar(
    actions: [
      Image.asset('images/label1.png')
    ],
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios,color: Colors.black54,),
      onPressed: (){
        Get.back();
      },
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text('اضافة عملك الخاص',style: TextStyle(
        color: Colors.black
    ),),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          height: 3.0,
          width: MediaQuery.of(context).size.width/3,
          color: Color(0xffEA6CB0),
        ),
      ),
    ),
  );
}

AppBar appBarTwo(BuildContext context)
{
  return AppBar(
    actions: [
      Image.asset('images/label2.png')
    ],
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios,color: Colors.black54,),
      onPressed: (){
        Get.back();
      },
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text('اضافة عملك الخاص',style: TextStyle(
        color: Colors.black
    ),),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          height: 3.0,
          width: MediaQuery.of(context).size.width/2,
          color: Color(0xffEA6CB0),
        ),
      ),
    ),
  );
}

AppBar appBarThree(BuildContext context)
{
  return AppBar(
    actions: [
      Image.asset('images/label3.png')
    ],
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios,color: Colors.black54,),
      onPressed: (){
        Get.back();
      },
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text('اضافة عملك الخاص',style: TextStyle(
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
  );
}


AppBar ModelScreen(BuildContext context)
{
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Vloggers',
            style: GoogleFonts.almarai(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w700)),
        SizedBox(width: 10),
      ],
    ),
    actions: [
      IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_forward,
            color: Colors.black,
          )),
    ],
    elevation: 1,
    backgroundColor: Colors.white,
    leading: Row(
      children: [
        Expanded(
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.filter_list_outlined,
                  color: Colors.black,
                ))),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.map_outlined, color: Colors.black))),
      ],
    ),
  );
}
