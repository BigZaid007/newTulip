import 'dart:convert';
import 'package:http/http.dart' as http;

class Order {
  DateTime orderDate;
  int shopId;
  int userId;
  double total;
  double totalDiscount;
  double netAmount;
  List<OrderDetail> orderDetails;
  String? userName;
  String? phone;
  String? shopName;

  Order({
    required this.orderDate,
    required this.shopId,
    required this.userId,
    required this.total,
    required this.totalDiscount,
    required this.netAmount,
    required this.orderDetails,
    this.userName,
    this.phone,
    this.shopName,
  });

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> orderDetailsJson =
    orderDetails.map((detail) => detail.toJson()).toList();

    final Map<String, dynamic> data = {
      "orderDate": orderDate.toIso8601String(),
      "shopId": shopId,
      "userId": userId,
      "total": total,
      "totalDiscount": totalDiscount,
      "netAmount": netAmount,
      "orderDetails": orderDetailsJson,
    };

    if (userName != null) {
      data['userName'] = userName;
    }

    if (phone != null) {
      data['phone'] = phone;
    }

    if (shopName != null) {
      data['shopName'] = shopName;
    }

    return data;
  }
}

class  OrderDetail {
  int productsId;
  int discountPercentage;
  double price;
  int count;

  OrderDetail({
    required this.productsId,
    required this.discountPercentage,
    required this.price,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    return {
      "productsId": productsId,
      "discountPercentage": discountPercentage,
      "price": price,
      "count": count,
    };
  }
}

class OrderApi {
  static Future<void> addOrder(Order order) async {
    final url = Uri.parse('https://www.tulipm.net/api/Orders');
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };

    try {
      final body = json.encode(order.toJson());
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Order added successfully!');
      } else {
        print('Failed to add order: ${response.statusCode}');
        print('Request Body:');
        print(body.split(',').join('\n'));
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      print('Error occurred while sending request: $error');
    }
  }
}


