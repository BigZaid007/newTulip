import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:tuliptest/test/preload/player.dart';

import '../../Controller/getx_Controller.dart';

class PreloadPage extends StatelessWidget {

  const PreloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(PCC());

    // Call fetchVideoURLs on initialization
    c.fetchVideoURLs();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () async {
            // Dispose the controller when navigating back to the previous screen
            await c.disposeController(c.api);
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Obx(
              () {
            if (!c.isURLsFetched.value) {
              // Display loading indicator or placeholder while waiting for video URLs
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

            return SizedBox(
              child: PreloadPageView.builder(
                itemBuilder: (ctx, i) {

                  return Player(i: i);
                },
                onPageChanged: (i) async {
                  c.updateAPI(i);
                },
                // If you are increasing or decreasing preload page count, change accordingly in the player widget
                preloadPagesCount: 3,
                controller: PreloadPageController(initialPage: 0),
                itemCount: c.videoURLs.length,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
              ),
            );
          },
        ),
      ),
    );
  }
}
