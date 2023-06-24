import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuliptest/test/streaming/content.dart';


class StreamPlayer extends StatelessWidget {
  final List<String> videos = [
    'https://customer-dhspk14y0q1hi878.cloudflarestream.com/43b86ce5f66707d13c28b1480f3a8767/manifest/video.mpd',
    'https://customer-dhspk14y0q1hi878.cloudflarestream.com/b3e92da498f763a9fd4b21c6bbe40f55/manifest/video.mpd',
    'https://customer-dhspk14y0q1hi878.cloudflarestream.com/47eee056f1093847c6a4579c91f26348/manifest/video.mpd',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //We need swiper for every content
              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ContentScreen2(
                    src: videos[index],
                  );
                },
                itemCount: videos.length,
                scrollDirection: Axis.vertical,
              ),

            ],
          ),
        ),
      ),
    );
  }
}