import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuliptest/Screens/mainScreens/landingPage.dart';
import 'package:tuliptest/Screens/mapScreen.dart';
import 'package:video_player/video_player.dart';

import '../Screens/Market/View/marketsScreen.dart';
import '../googleMap.dart';
import '../notification/norificationsScreen.dart';
import '../Screens/productScreen.dart';
import '../auth/userController/userController.dart';
import '../models/Reels.dart';
import '../models/category.dart';
import '../models/shops.dart';
import 'package:http/http.dart' as http;

import '../Screens/ProfileScreenUser.dart';


class AuthController extends GetxController {

  final authID = 0.obs;

  @override
  void onInit() async {
    super.onInit();

    await getID();
  }

  Future<void> getID() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    authID.value = userId ?? 0;
  }




  bool get isLoggedIn => authID.value != 0 ;

}
int userId = Get.find<UserController>().userId;

class InitialScreenController extends GetxController {


  var currentIndex = 0.obs;
  final PCC pcc = Get.put(PCC());


  var screens = [
    landingPage(),
    MapSample(),
    ProfileScreenTesting(personId: userId),
    MarketScreen(),
  ].obs;

  void changeIndex(int index) {
    currentIndex.value = index;
    print(index);
  }
}



class LandingPageController extends GetxController {
  var isLoading = false.obs;


  Future<void> refresh() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }
}

class ReelsController extends GetxController {
  final ReelsServices _reelsServices = ReelsServices();

  RxList<Reel> reels = RxList<Reel>([]);

  @override
  void onInit() {
    super.onInit();
    fetchReels();
  }

  Future<void> fetchReels() async {
    try {
      final response = await _reelsServices.fetchReels();
      reels.value = response;
    } catch (error) {
      print(error);
    }
  }
}

class PCC extends GetxController {
  int _api = 0;
  List<VideoPlayerController?> videoPlayerControllers = [];
  List<int> initializedIndexes = [];
  bool autoplay = true;
  final RxBool isReelAdded = false.obs;
  int get api => _api;
  RxString image = RxString('');
  RxString centerName = RxString('');
  RxList<Map<String, dynamic>> allVideosData = RxList<Map<String, dynamic>>([]);


  RxBool isURLsFetched = false.obs; // RxBool to observe changes in isURLsFetched

  void updateAPI(int i) {
    if (videoPlayerControllers[_api] != null) {
      videoPlayerControllers[_api]!.pause();
    }
    _api = i;
    update();
  }



  Future<void> fetchVideoURLs() async {
    final url = 'https://www.tulipm.net/api/Reels/GetAll';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['success'] == true) {
          final data = jsonResponse['data'];

          final List<String> urls = [];
          List<Map<String, dynamic>> videosData = [];

          for (var reel in data) {
            final url = reel['url'];
            urls.add(url);

            // Extract and store other data
            final videoData = {
              'image': reel['image'],
              'centerName': reel['centerName'],
              'likesCount': reel['likesCount'],
              'commentCount': reel['commentCount'],
              'videoUrl': reel['url'],
            };
            videosData.add(videoData);
          }

          videoURLs.clear();
          videoURLs.addAll(urls);

          // Store all videos' data
          allVideosData.assignAll(videosData);

          isURLsFetched.value = true; // Set flag to true after fetching URLs

          update();
        }
      } else {
        // Handle API error (response.statusCode is not 200)
      }
    } catch (e) {
      // Handle network error
    }
  }

  Future<void> initializePlayer(int i) async {
    print('initializing $i');

    if (!isURLsFetched.value) {
      return; // Don't initialize player if URLs are not fetched yet
    }

    late VideoPlayerController singleVideoController;
    singleVideoController = VideoPlayerController.network(videoURLs[i]);
    videoPlayerControllers.add(singleVideoController);
    initializedIndexes.add(i);
    await videoPlayerControllers[i]!.initialize();

    update();
  }

  Future<void> initializeIndexedController(int index) async {
    if (!isURLsFetched.value) {
      return; // Don't initialize player if URLs are not fetched yet
    }

    late VideoPlayerController singleVideoController;
    singleVideoController = VideoPlayerController.network(videoURLs[index]);
    videoPlayerControllers[index] = singleVideoController;
    await videoPlayerControllers[index]!.initialize();

    update();
  }

  String getVideoUrl(int index) {
    // Retrieve the video URL based on the given index
    if (index >= 0 && index < allVideosData.length) {
      final videoData = allVideosData[index];
      return videoData['videoUrl'] ?? '';
    } else {
      return '';
    }
  }

  void addNewReel(String videoUrl) async {
    videoURLs.add(videoUrl);

    // Add your asynchronous logic here, such as posting the reel or any other operations

    // After the asynchronous operation is complete, set isURLsFetched to true
    await Future.delayed(Duration(seconds: 2)); // Placeholder delay for illustration
    isURLsFetched.value = true;
    allVideosData.refresh();

  }

  void up()

  {
    allVideosData.refresh();
  }


  Future<void> disposeController(int i) async {
    if (videoPlayerControllers[i] != null) {
      await videoPlayerControllers[i]!.dispose();
      videoPlayerControllers[i] = null;
    }
  }

  final List<String> videoURLs = [];

  @override
  void onInit() {
    super.onInit();
    fetchVideoURLs();
  }
}



class SectionController extends GetxController {
  var categories = <Category>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<List<Category>> fetchCategories() async {
    var apiUrl = 'https://www.tulipm.net/api/Sections/GetAll';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final categoryJson = data['data'] as List<dynamic>;
      final List<Category> fetchedCategories =
      categoryJson.map((json) => Category.fromJson(json)).toList();
      categories.value = fetchedCategories;
      return fetchedCategories;
    } else {
      throw Exception('Failed to load services');
    }
  }
}




