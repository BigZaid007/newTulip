import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tuliptest/Message/View/MessageScreen.dart';

import '../../auth/userController/userController.dart';
import '../../constantAPi/constant.dart';
import '../Model/MessageModel.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final int userID;

  const ChatScreen({Key? key, required this.userID}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<List<Map<String, dynamic>>> _messageListFuture;
  int userId = Get.find<UserController>().userId;


  @override
  void initState() {
    super.initState();
    _messageListFuture = _getMessageList();
  }

  Future<List<Map<String, dynamic>>> _getMessageList() async {
    final response = await http.get(Uri.parse('$apiConstant/Message/GetMessageList/${userId}'));
    final responseBody = json.decode(response.body);

    if (responseBody['success'] == true) {
      print(responseBody['data']);
      return List<Map<String, dynamic>>.from(responseBody['data']);

    } else {
      throw Exception('Failed to get message list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        title: Text(
          'المحادثات',
          style: GoogleFonts.almarai(
            fontSize: 20.sp,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _messageListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.purpleAccent,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to get message list'),
            );
          } else if (snapshot.hasData) {
            final List<Map<String, dynamic>> messageList = snapshot.data!;

            return ListView.builder(
              itemCount: messageList.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messageList[index];
                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                      radius: 24,
                    ),
                    title: Text(
                      message['personNameSender'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(message['messageTxt']),
                    trailing: Text(
                      DateFormat('kk:mm').format(DateTime.parse(message['messageDate'])),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                    ),
                    onTap: () {
                      print(message['userSenderId']);
                      print(userId);
                      Get.to(() => MessageScreen(
                          senderId: message['userSenderId'],
                          receiverId: widget.userID));
                    },
                  ),
                );
              },
            );

          } else {
            return Center(
              child: Text('لا توجد محادثات',style: GoogleFonts.almarai(
                fontSize: 22.sp,

              ),),
            );
          }
        },
      ),
    );
  }
}


