import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> onCommentPost(int postId, int userID,String name,String comment) async {
  final url = Uri.parse('https://www.tulipm.net/api/Comments');
  final headers = {'Content-Type': 'application/json', 'accept': '*/*'};
  final now = DateTime.now().toUtc();
  final commentsDate = now.toIso8601String();
  final body = json.encode({
    'commentsId': 0,
    'txtComments': comment,
    'userId': userID,
    'postId': postId,
    'reelsId': 0,
    'commentsDate': commentsDate,
    'userName': name,
  });

  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    // like created successfully
    print('comment created successfully');
  } else {
    // handle error
    print('Error creating comment: ${response.statusCode}');
  }
}




Future<List<dynamic>> getCommentsforPost(int postId) async {
  final response = await http.get(Uri.parse('https://www.tulipm.net/api/Comments/GetByPostId/$postId'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse['data'];
  } else {
    throw Exception('Failed to load comments');
  }
}


