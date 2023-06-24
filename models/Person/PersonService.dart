import 'dart:convert';
import 'package:http/http.dart' as http;

import 'PersonModel.dart';

Future<Person?> fetchPersonById(int id) async {
  try {
    final apiUrl = 'https://www.tulipm.net/api/Persons/GetPersonById/$id';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final personData = data['data'] as Map<String, dynamic>;

      return Person.fromJson(personData);
    } else {
      throw Exception('Failed to fetch person');
    }
  } catch (e) {
    throw Exception('Failed to fetch person: $e');
  }
}
