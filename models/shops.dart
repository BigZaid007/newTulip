import 'dart:convert';

import 'package:http/http.dart' as http;

class Shops {
  String ShopName;
  String ShopImages;
  int categoriesId;

  Shops(
      {required this.ShopName,
      required this.ShopImages,
      required this.categoriesId});

  factory Shops.fromJson(Map<String, dynamic> json) {
    return Shops(
        ShopName: json['categoriesName'],
        ShopImages: json['categoriesImages'],
        categoriesId: json['categoriesId']);
  }
}

class shopService {
  Future<List<Map<String, dynamic>>> fetchShopById(
      int userId, int categoryId) async {
    final response = await http.get(Uri.parse(
        'https://www.tulipm.net/api/Persons/GetShopByUserIdAndCategoriesId/$userId,$categoryId'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['data'];
      return List<Map<String, dynamic>>.from(responseData);
    } else {
      throw Exception('Failed to fetch center by ID');
    }
  }
}

Future<List<Shops>> fetchShops() async {
  var apiUrl = 'https://www.tulipm.net/api/Categories/GetAll';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final shopsJson = data['data'] as List<dynamic>;
    final shopsList = shopsJson.map((json) => Shops.fromJson(json)).toList();
    return shopsList;
  } else {
    throw Exception('Failed to load services');
  }
}
