
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuliptest/auth/authLandingPage.dart';

import '../../utilites/material/font.dart';
import '../../presentaion/splashOnBoardingScreens/Screens/boardingScreens.dart';


class onScreen extends StatefulWidget {
  @override
  State<onScreen> createState() => _onScreenState();
}

class _onScreenState extends State<onScreen> {

  int indicator = 0;
  final PageController pageController = PageController(initialPage: 0);
  int pageNum=3;
  Widget indicatorItem(bool isActive)
  {
    return AnimatedContainer(duration: Duration(milliseconds: 300),
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: isActive?25.w:13.w,
      decoration: BoxDecoration(
        color: isActive? Color(0xffFF9083):Colors.grey,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  List<Widget> pageBuilder()
  {
    List<Widget> list=[];
    for(int i=0;i < pageNum;i++)
    {
      list.add(i==indicator? indicatorItem(true):indicatorItem(false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: font().pinkBG,
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              PageView(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (int page){
                  setState(() {
                    indicator=page;
                  });

                },
                children: <Widget>[
                  One(),Two(),Three()
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height-175,
                child: Row(
                  children:
                    pageBuilder()
                ),
              ),
              GestureDetector(
                onTap: () {
                  // check if the current page is the last page
                  if (indicator < pageNum - 1) {
                    // update the indicator variable to the next page
                    setState(() {
                      indicator++;
                    });
                    // animate the page transition to the next page
                    pageController.animateToPage(indicator, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  } else {
                    // if on the last page, navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => authScreen()),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 620).r,
                  child: Container(
                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                    alignment: AlignmentDirectional.center,
                    width: 51.32.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff202124)
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 620,left: 250).r,
                child: TextButton(
                  onPressed: (){
                    Get.to(()=>authScreen());
                  },
                  child:Text('تخطي الكل',
                      style: GoogleFonts.almarai(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        color: Colors.black54,
                      )),
                ),
              ),
            ],
          )),
    );
  }
}
