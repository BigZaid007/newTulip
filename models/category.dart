import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../Screens/Sections/View/categoryPage.dart';
import '../Widgets/catWidgets.dart';

class Category {
  int sectionsId;
  String categoriesName;
  String categoriesImages;

  Category({required this.sectionsId,required this.categoriesName, required this.categoriesImages});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoriesName: json['sectionsName'],
      categoriesImages: json['sectionsImages'], sectionsId: json['sectionsId'],

    );
  }
}

class CategroyService
{
  Future<List<Category>> fetchCategory() async {
    var apiUrl = 'https://www.tulipm.net/api/Sections/GetAll';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final categoryJson = data['data'] as List<dynamic>;
      final categories =
      categoryJson.map((json) => Category.fromJson(json)).toList();
      return categories;
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future<List<Category>> fetchCategoryById() async {
    var apiUrl = 'https://www.tulipm.net/api/Sections/GetAll';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final categoryJson = data['data'] as List<dynamic>;
      final categories =
      categoryJson.map((json) => Category.fromJson(json)).toList();
      return categories;
    } else {
      throw Exception('Failed to load services');
    }
  }


}






