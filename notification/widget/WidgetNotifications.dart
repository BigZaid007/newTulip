import 'package:flutter/material.dart';


class detailsNotification
{
  void _showNotificationDetails(BuildContext context, String details) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notification Details'),
          content: Text(details),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

}

