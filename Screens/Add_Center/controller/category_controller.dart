import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../models/category.dart';

import 'package:get/get.dart';


class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var isLoading = true.obs;
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final fetchedCategories = await CategroyService().fetchCategory();
      categories.value = fetchedCategories;
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading(false);
    }
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
  }

  int getSelectedCategoryIndex() {
    final selectedCategoryName = selectedCategory.value;
    final index = categories.indexWhere(
            (category) => category.categoriesName == selectedCategoryName);
    return index;
  }
}
