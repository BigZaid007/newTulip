import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuliptest/Widgets/bottomReel.dart';
import 'package:video_player/video_player.dart';

import '../../Controller/getx_Controller.dart';
import '../../Widgets/reelIcon.dart';


class Player extends StatelessWidget {
  final int i;

  Player({Key? key, required this.i}) : super(key: key);

  final PCC c = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PCC>(
      initState: (x) async {

        //Need to change conditions according preaload page count
        //Don't load too many pages it will cause performance issue.
        // Below is for 1 page preaload.
        if (c.api > 4) {
          await c.disposeController(c.api - 3);
        }
        if (c.api < c.videoPlayerControllers.length - 3) {
          await c.disposeController(c.api + 3);
        }
        if (!c.initializedIndexes.contains(i)) {
          await c.initializePlayer(i);
        }
        if (c.api > 0) {
          if (c.videoPlayerControllers[c.api - 1] == null) {
            await c.initializeIndexedController(c.api - 1);
          }
        }
        if (c.api < c.videoPlayerControllers.length - 1) {
          if (c.videoPlayerControllers[c.api + 1] == null) {
            await c.initializeIndexedController(c.api + 1);
          }
        }
      },
      builder: (_) {
        if (c.videoPlayerControllers.isEmpty ||
            c.videoPlayerControllers[c.api] == null ||
            !c.videoPlayerControllers[c.api]!.value.isInitialized) {
          return Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
            ),
          );
        }

        if (i == c.api) {
          //If Index equals Auto Play Index
          //Set AutoPlay True Here
          if (i < c.videoPlayerControllers.length) {
            if (c.videoPlayerControllers[c.api]!.value.isInitialized) {
              c.videoPlayerControllers[c.api]!.play();
            }
          }
          print('AutoPlaying ${c.api}');
        }
        return Scaffold(
          bottomNavigationBar: bottomReel(),
          body: Stack(
            children: [
              c.videoPlayerControllers.isNotEmpty &&
                  c.videoPlayerControllers[c.api]!.value.isInitialized
                  ? GestureDetector(
                onTap: () {
                  if (c.videoPlayerControllers[c.api]!.value.isPlaying) {
                    print("paused");
                    c.videoPlayerControllers[c.api]!.pause();
                  } else {
                    c.videoPlayerControllers[c.api]!.play();
                    print("playing");
                  }
                },
                child: VideoPlayer(c.videoPlayerControllers[c.api]!),
              )
                  : Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                ),
              ),
              Align(
                heightFactor: 4,
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  child: reelsIcon(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month,
                            color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'حجز موعد',
                          style: GoogleFonts.almarai(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    width: 240,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffBE338E),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}