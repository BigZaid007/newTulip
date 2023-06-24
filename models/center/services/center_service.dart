import 'dart:convert';

import '../model/centerModel.dart';
import 'package:http/http.dart' as http;

class centerService {

  void postCenter(centerModel center) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://www.tulipm.net/api/Persons/RegisterCenter'),
    );

    request.files.add(await http.MultipartFile.fromPath(
      'FileChooseBakground',
      center.backgroundFile!.path,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'FileChooseLogo',
      center.logoFile!.path,
    ));
    request.fields.addAll(center.toMap().map((key, value) => MapEntry(key, value.toString())));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Shop added successfully!');
      } else {
        print('Failed to add center: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred while sending request: $error');
    }
  }

  Future<List<Map<String, dynamic>>> fetchCenterById(int userId, int sectionId) async {
    final response = await http.get(Uri.parse('https://www.tulipm.net/api/Persons/GetCenterByUserIdAndSectionsId/$userId,$sectionId'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['data'];
      return List<Map<String, dynamic>>.from(responseData);
    } else {
      throw Exception('Failed to fetch center by ID');
    }
  }


  // Future<centerModel> getCategoryScreen(int id) async {
  //   final url = Uri.parse('https://www.tulipm.net/api/Persons/GetCenterByPersonId/$id');
  //   final response = await http.get(url);
  //   final data = jsonDecode(response.body)['data'];
  //
  //   return centerModel.fromJson(data);
  // }

  Future<Map<String, dynamic>> getCategoryProfile(int id) async {
    final url = Uri.parse('https://www.tulipm.net/api/Persons/GetCenterByPersonId/$id');
    final response = await http.get(url);
    final data = jsonDecode(response.body)['data'];
    print(data);

    return data;
  }


}
