import 'dart:convert';
import 'package:http/http.dart' as http;

class Carsouel {

  final String imageUrl;

  Carsouel({required this.imageUrl});

  factory Carsouel.fromJson(Map<String, dynamic> json) {
    return Carsouel(
      imageUrl: json['image'],
    );
  }
}

Future<List<String>> fetchData() async {
  final response = await http.get(Uri.parse('https://www.tulipm.net/api/Carousel/GetAllApp'));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body)['data'] as List;
    final imageUrls = jsonData.map((json) => json['image'] as String).toList();
    return imageUrls;
  } else {
    throw Exception('Failed to fetch data');
  }
}
