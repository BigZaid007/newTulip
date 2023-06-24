import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkingHoursApi {
  static Future<void> addWorkingHours(int centerId, DateTime timeStart, DateTime timeEnd, int dayId) async {
    final url = Uri.parse('https://www.tulipm.net/api/WorkingHours');
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };

    final body = {
      'workingHoursId': 0,
      'centerId': centerId,
      'timeStart': timeStart.toIso8601String(),
      'timeEnd': timeEnd.toIso8601String(),
      'dayId': dayId,
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print('Working hours added successfully!');
      } else {
        print('Failed to add working hours: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      print('Error occurred while sending request: $error');
    }
  }
}
