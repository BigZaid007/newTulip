import 'package:http/http.dart' as http;
import 'dart:convert';

class Reel {
  int id;
  String centerName;
  String image;
  String url;
  String title;
  String details;
  int likesCount;
  int commentCount;
  int seenCount;

  Reel({
    required this.id,
    required this.centerName,
    required this.image,
    required this.url,
    required this.title,
    required this.details,
    required this.likesCount,
    required this.commentCount,
    required this.seenCount,
  });

  factory Reel.fromJson(Map<String, dynamic> json) {
    return Reel(
      id: json['reelsId'],
      centerName: json['centerName'] ?? '',
      image: json['image'],
      url: json['url'],
      title: json['title'] ?? '',
      details: json['details'] ?? '',
      likesCount: json['likesCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      seenCount: json['seenCount'] ?? 0,
    );
  }
}



class ReelsServices {
  Future<List<Reel>> fetchReels() async {
    var apiUrl = 'https://www.tulipm.net/api/Reels/GetAll';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final reelJson = data['data'] as List<dynamic>;
      final reels = reelJson.map((json) => Reel.fromJson(json)).toList();
      return reels;
    } else {
      throw Exception('Failed to load services');
    }
  }
}


