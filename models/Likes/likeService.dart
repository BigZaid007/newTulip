import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> onLikePost(int postId, int userID) async {
  final url = Uri.parse('https://www.tulipm.net/api/Likes');
  final headers = {'Content-Type': 'application/json', 'accept': '*/*'};
  final body = json.encode({
    'likesId': 0,
    'userId': userID,
    'postId': postId,
    'reelsId': 0,
    'productsId': 0,
    'shopId': 0,
    'userName': '',
  });
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    // like created successfully
    print('Like created successfully');
  } else {
    // handle error
    print('Error creating like: ${response.statusCode}');
  }
}

Future<void> onLikeReel(int reelId, int userID) async {
  final url = Uri.parse('https://www.tulipm.net/api/Likes');
  final headers = {'Content-Type': 'application/json', 'accept': '*/*'};
  final body = json.encode({
    'likesId': 0,
    'userId': userID,
    'postId': 0,
    'reelsId': reelId,
    'productsId': 0,
    'shopId': 0,
    'userName': '',
  });
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    // like created successfully
    print('Like created successfully');
  } else {
    // handle error
    print('Error creating like: ${response.statusCode}');
  }
}

Future<void> onLikeProduct(int productId, int userID) async {
  final url = Uri.parse('https://www.tulipm.net/api/Likes');
  final headers = {'Content-Type': 'application/json', 'accept': '*/*'};
  final body = json.encode({
    'likesId': 0,
    'userId': userID,
    'postId': 0,
    'reelsId': 0,
    'productsId':productId ,
    'shopId': 0,
    'userName': '',
  });
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    // like created successfully
    print('Like created successfully');
  } else {
    // handle error
    print('Error creating like: ${response.statusCode}');
  }
}


