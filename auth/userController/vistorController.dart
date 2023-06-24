import 'package:get/get.dart';

class VistorController extends GetxController {
  int userId = 0;
  @override
  void onInit() {
    userId = -1;
    super.onInit();
  }

  setUser(int id) {
    userId = id;
    update();
  }


}
