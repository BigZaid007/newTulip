import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/shop_model.dart';

class ShopService {
  void postShop(Shop shop) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://www.tulipm.net/api/Persons/RegisterShop'),
    );

    request.files.add(await http.MultipartFile.fromPath(
      'FileChooseBakground',
      shop.backgroundFile!.path,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'FileChooseLogo',
      shop.logoFile!.path,
    ));
    request.fields.addAll(shop.toMap().map((key, value) => MapEntry(key, value.toString())));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Shop added successfully!');
      } else {
        print('Failed to add shop: ${response.statusCode}');
        String responseBody = await response.stream.bytesToString();
        print('Error response body: $responseBody');

      }
    } catch (error) {
      print('Error occurred while sending request: $error');
    }
  }



}
