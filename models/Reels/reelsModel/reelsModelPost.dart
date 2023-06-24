import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ReelModel2 {
  int? reelsId;
  int? centerId;
  String? title;
  String? details;
  bool? isVisible;
  bool? isTop;
  File? fileChooseReels;

  ReelModel2({
    this.reelsId,
    this.centerId,
    this.title,
    this.details,
    this.isVisible,
    this.isTop,
    this.fileChooseReels,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ReelsId'] = reelsId;
    data['CenterId'] = centerId;
    data['Title'] = title;
    data['Details'] = details;
    data['IsVisible'] = isVisible;
    data['IsTop'] = isTop;
    return data;
  }
}

class ReelPostService {
  static Future<void> postReel(ReelModel2 reel) async {
    final Uri uri = Uri.parse('https://www.tulipm.net/api/Reels');

    final request = http.MultipartRequest('POST', uri)
      ..fields['ReelsId'] = reel.reelsId.toString()
      ..fields['CenterId'] = reel.centerId.toString()
      ..fields['Title'] = reel.title!
      ..fields['Details'] = reel.details!
      ..fields['IsVisible'] = reel.isVisible!.toString()
      ..fields['IsTop'] = reel.isTop!.toString()
      ..files.add(await http.MultipartFile.fromPath(
          'FileChooseReels', reel.fileChooseReels!.path,
          contentType: MediaType('video', 'mp4')));

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Reel posted successfully');
    } else {
      response.stream.transform(utf8.decoder).listen((errorBody) {
        print('Failed to post reel. Error: $errorBody');
      }).onDone(() {
        print('Failed to post reel. Status code: ${response.statusCode}');
        print('Failed to post reel. Request: ${response.request}');
        print('Failed to post reel. Reason phrase: ${response.reasonPhrase}');
      });
    }

  }
}
