import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/getx_Controller.dart';

class UserController extends GetxController {
  int userId = 0;
  String name = '';
  String token = '';
  String userImage = '';
  final authController = Get.put(AuthController());




  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = int.tryParse(prefs.getString('userId') ?? '') ?? 0;
    name = prefs.getString('Name') ?? '';
    token = prefs.getString('token') ?? '';
    userImage = prefs.getString('userImage') ?? '';
    super.onInit();
  }

  setUser(int id, String name, String token) async {
    userId = id;
    this.name = name;
    this.token = token;
    this.userImage = userImage;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId.toString());
    prefs.setString('Name', name);
    prefs.setString('token', token);
    prefs.setString('userImage', userImage);
    update();
  }

  setImage(int id, String userImage) async {
    userId = id;
    this.userImage = userImage;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId.toString());
    prefs.setString('userImage', userImage);
    update();
  }

  clearUser() async {
    userId = 0;
    name = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', '');
    prefs.setString('token', '');
    prefs.setString('Name', '');
    prefs.setString('userImage', '');
    authController.authID.value=0;
    update();
  }


}
