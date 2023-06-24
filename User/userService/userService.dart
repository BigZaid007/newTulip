import 'dart:convert';
import 'package:http/http.dart' as http;
import '../userModel/userModel.dart';

Future<User> getUser(int id) async {
  final url = 'https://www.tulipm.net/api/Persons/GetPersonById/$id';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final userJson = json['data'];
    print(userJson);
    final user = User.fromJson(userJson);
    return user;
  } else {
    throw Exception('Failed to load user');
  }
}
