class NotificationModel {
  int notificationId;
  String details;
  String title;
  DateTime dateInsert;
  int userId;
  int shopId;
  int centerId;

  NotificationModel({
    required this.notificationId,
    required this.details,
    required this.title,
    required this.dateInsert,
    required this.userId,
    required this.shopId,
    required this.centerId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'],
      details: json['details'],
      title: json['title'],
      dateInsert: DateTime.parse(json['dateInsert']),
      userId: json['userId'],
      shopId: json['shopId'],
      centerId: json['centerId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationId'] = this.notificationId;
    data['details'] = this.details;
    data['title'] = this.title;
    data['dateInsert'] = this.dateInsert.toIso8601String();
    data['userId'] = this.userId;
    data['shopId'] = this.shopId;
    data['centerId'] = this.centerId;
    return data;
  }
}
