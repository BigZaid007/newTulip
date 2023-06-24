import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'modelNotifications/modelNot.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  List<NotificationModel2> _notifications = [];

  @override
  void initState() {
    super.initState();
    _configureLocalNotifications();
  }

  void _configureLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<List<NotificationModel2>> _fetchNotifications() async {
    final response = await http.get(
      Uri.parse('https://www.tulipm.net/api/Notification/GetNotificationAll/3'),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        final List<dynamic> data = responseBody['data'];
        final List<NotificationModel2> notifications = data.map((item) {
          final notificationId = item['notificationId'] as int;
          final details = item['details'] as String;
          final title = item['title'] as String;
          final dateInsert = DateTime.parse(item['dateInsert']);
          return NotificationModel2(
            notificationId: notificationId,
            details: details,
            title: title,
            dateInsert: dateInsert,
          );
        }).toList();

        // Show local notifications for new notifications
        final List<NotificationModel2> newNotifications = notifications
            .where((notification) =>
        !_notifications.any((n) => n.notificationId == notification.notificationId))
            .toList();

        if (newNotifications.isNotEmpty) {
          _showLocalNotification(newNotifications);
        }

        // Update the notifications list
        _notifications = notifications;

        return notifications;
      }
    }

    // Return an empty list if fetching notifications failed or there are no notifications
    return [];
  }

  void _showLocalNotification(List<NotificationModel2> newNotifications) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.high,
      priority: Priority.high,
    );

    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    for (final notification in newNotifications) {
      await flutterLocalNotificationsPlugin.show(
        notification.notificationId,
        notification.title,
        notification.details,
        platformChannelSpecifics,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          'الاشعارات',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<NotificationModel2>>(
        future: _fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
                strokeWidth: 1,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load notifications.',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final notifications = snapshot.data!;
            return notifications.isEmpty
                ? Center(
              child: Text(
                'لا توجد اشعارات',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )
                : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final formattedDate =
                DateFormat('dd/MM/yyyy').format(notification.dateInsert);
                return GestureDetector(
                  onTap: () {
                    _showNotificationDetails(context, notification.details);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink[100],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black54),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    notification.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.deepPurple,
                                    size: 30,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No notifications found.',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _showNotificationDetails(BuildContext context, String details) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('الاشعارات'),
          content: Text(details),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('اغلاق'),
            ),
          ],
        );
      },
    );
  }
}
