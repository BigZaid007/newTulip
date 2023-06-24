import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ListSelectionController extends GetxController {
  final selectedItems = <String>[].obs;

  void selectItem(String item) {
    if (selectedItems.length < 4) {
      selectedItems.add(item);
    } else {
      // show an error message if the limit is exceeded
      Get.dialog(
        AlertDialog(
          title: Text('Limit Exceeded'),
          content: Text('You can only select up to 4 items.'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void deselectItem(String item) {
    selectedItems.remove(item);
  }
}
