import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tuliptest/constantAPi/constant.dart';

import 'blogger_model.dart';

class BloggerService
{

  Future<void> registerModel(RegisterModelRequest request) async {
    final url = Uri.parse('$apiConstant/Persons/RegisterModel');

    final requestFields = request.toFieldsMap();

    final requestMultipart = http.MultipartRequest('POST', url);

    for (var field in requestFields.entries) {
      if (field.key == 'FileChoose') {
        requestMultipart.files.add(
          await http.MultipartFile.fromPath('FileChoose', field.value),
        );
      } else {
        requestMultipart.fields[field.key] = field.value.toString();
      }
    }

    final response = await http.Response.fromStream(await requestMultipart.send());

    if (response.statusCode == 200) {
      print('Success');
    } else {
      throw Exception('Failed to register model: ${response.body}');
    }
  }

  // void registerModel(RegisterModelRequest request) async {
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('https://www.tulipm.net/api/Persons/RegisterCenter'),
  //   );
  //
  //   request.files.add(await http.MultipartFile.fromPath(
  //     'FileChooseBakground',
  //     center.backgroundFile!.path,
  //   ));
  //   request.files.add(await http.MultipartFile.fromPath(
  //     'FileChooseLogo',
  //     center.logoFile!.path,
  //   ));
  //   request.fields.addAll(center.toMap().map((key, value) => MapEntry(key, value.toString())));
  //
  //   try {
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       print('Shop added successfully!');
  //     } else {
  //       print('Failed to add center: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error occurred while sending request: $error');
  //   }
  // }



  Future<List<RegisterModelRequest>> getAllModels() async {
    final response = await http.get(Uri.parse('https://www.tulipm.net/api/Persons/GetModelAll/%20'));

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
      final dataList = jsonMap['data'] as List<dynamic>;
      return dataList.map((json) => RegisterModelRequest.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load models');
    }
  }



  Future<List<dynamic>> getModelAll(String name, bool isModel, bool isBlogger) async {
    var url = 'https://www.tulipm.net/api/Persons/GetModelAll/$name,$isModel,$isBlogger';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['data']);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load data from API');
    }
  }


  Future<Map<String, dynamic>> fetchModelByPersonId(int personId) async {
    final response = await http.get(Uri.parse('https://www.tulipm.net/api/Persons/GetModelByPersonId/$personId'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse['data']);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }



}

