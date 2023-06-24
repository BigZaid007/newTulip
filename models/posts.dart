import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuliptest/Screens/Sections/centerProfile/centerPost.dart';
import 'package:video_player/video_player.dart';

import '../Screens/Sections/centerProfile/PostView.dart';
import '../auth/userController/userController.dart';

class Post {
  final int postsId;
  final int modelId;
  final int centerId;
  final String? details;
  final int likesCount;
  final int commentCount;
  final int seenCount;
  final DateTime dateInsert;
  final String postTopOne;
  final String? countryName;
  final String centerName;
  final String? modelName;
  final bool isLiked;
  final List<String> postsFilesUrls;

  Post({
    required this.postsId,
    required this.modelId,
    required this.centerId,
    this.details='new',
    required this.likesCount,
    required this.commentCount,
    required this.seenCount,
    required this.dateInsert,
    required this.postTopOne,
    this.countryName,
    required this.centerName,
    this.modelName,
    required this.isLiked,
    required this.postsFilesUrls,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final List<dynamic> postsFilesJson = json['postsFiles'] ?? [];
    final List<String> postsFilesUrls = postsFilesJson
        .map((json) => (json['url'] as String?)?.replaceAll('\\', '/'))
        .where((url) => url != null)
        .cast<String>()
        .toList();

    return Post(
      postsId: json['postsId'],
      modelId: json['modelId'],
      centerId: json['centerId'],
      details: json['details'],
      likesCount: json['likesCount'],
      commentCount: json['commentCount'],
      seenCount: json['seenCount'],
      dateInsert: DateTime.parse(json['dateInsert']),
      postTopOne: json['postTopOne'],
      countryName: json['countryName'],
      centerName: json['centerName'],
      modelName: json['modelName'],
      isLiked: json['isLiked'],
      postsFilesUrls: postsFilesUrls,
    );
  }
}

class postList extends StatelessWidget {
  final PostController controller = Get.put(PostController());
  int userId = Get.find<UserController>().userId;

  @override
  Widget build(BuildContext context) {
    controller.fetchPosts(userId, 1); // Fetch the initial set of posts

    return Obx(() {
      if (controller.posts.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return PostWidget(
              postId: post.postsId,
              centerId: post.centerId,
              name: post.centerName,
              content: post.details??'',
              avatarImageUrl: post.postTopOne,
              comments: post.commentCount,
              likes: post.likesCount,
              isLiked: post.isLiked,
              date: DateFormat('yyyy-MM-dd').format(post.dateInsert),
              showcaseImageUrls: post.postsFilesUrls,
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 1,
            color: Colors.pinkAccent,
          ),
        );
      }
    });
  }
}

class PostController extends GetxController {

  var posts = <Post>[].obs;
  int userId = Get.find<UserController>().userId;
  int index = 1;
  int postsPerFetch = 7; // Number of posts to fetch per API request

  @override
  void onInit() {
    super.onInit();
    fetchPosts(userId, index);
  }

  void fetchPosts(int userId, int index) async {
    try {
      var apiUrl = 'https://www.tulipm.net/api/Posts/GetByUserId/$userId/$index';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final postJson = data['data'] as List<dynamic>;
        final postsData = postJson.map((json) => Post.fromJson(json)).toList();

        if (postsData.isNotEmpty) {
          // Check for duplicate posts before adding them to the list
          final uniquePosts = postsData.where((newPost) => !posts.any((existingPost) => existingPost.postsId == newPost.postsId)).toList();
          posts.addAll(uniquePosts);

          if (postsData.length >= postsPerFetch) {
            // If fetched posts count is greater than or equal to the desired number per fetch,
            // increment the index
            this.index += 1;
            fetchPosts(userId, this.index);
          }
        }
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}


