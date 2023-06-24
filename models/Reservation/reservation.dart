import 'dart:convert';
import 'package:http/http.dart' as http;

class Reservation {
  int reservationId;
  int userId;
  int centerId;
  DateTime time;
  String notes;
  bool isCancel;
  bool isApprove;
  bool isDone;
  String centerName;
  String userName;
  List<String> serviceName;

  Reservation({
    required this.reservationId,
    required this.userId,
    required this.centerId,
    required this.time,
    required this.notes,
    required this.isCancel,
    required this.isApprove,
    required this.isDone,
    required this.centerName,
    required this.userName,
    required this.serviceName,
  });

  Map<String, dynamic> toJson() {
    return {
      "reservationId": reservationId,
      "userId": userId,
      "centerId": centerId,
      "time": time.toIso8601String(),
      "notes": notes,
      "isCancel": isCancel,
      "isApprove": isApprove,
      "isDone": isDone,
      "centerName": centerName,
      "userName": userName,
      "serviceName": serviceName,
    };
  }
}

class ReservationApi {
  static Future<void> makeReservation(Reservation reservation) async {
    final url = Uri.parse('https://www.tulipm.net/api/Reservation');
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };

    try {
      final body = json.encode(reservation.toJson());
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Reservation successful!');
      } else {
        print('Failed to make reservation: ${response.statusCode}');
        print('Request Body:');
        print(body);
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      print('Error occurred while sending request: $error');
    }
  }
}

