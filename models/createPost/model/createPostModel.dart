import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<String> createPost({
    required int postsId,
    required int centerId,
    required int modelId,
    required String details,
    required List<File> images,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://www.tulipm.net/api/Posts'),
    );

    request.fields['PostsId'] = postsId.toString();
    request.fields['CenterId'] = centerId.toString();
    request.fields['ModelId'] = modelId.toString();
    request.fields['Details'] = details;

    for (int i = 0; i < images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'FileChoose',
        images[i].path,
        filename: 'image$i.png',
      ));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      return 'Post created successfully.';
    } else {
      return 'Error creating post.';
    }
  }
}
