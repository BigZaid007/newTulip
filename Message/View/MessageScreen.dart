import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tuliptest/constantAPi/constant.dart';

import '../../models/Person/PersonModel.dart';
import '../../models/Person/PersonService.dart';
import '../Model/MessageModel.dart';

class MessageScreen extends StatefulWidget {
  final int senderId;
  final int receiverId;
  final String? name;
  final String? logo;

  const MessageScreen({
    Key? key,
    required this.senderId,
    required this.receiverId,
    this.name,
    this.logo,
  }) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Map<String, dynamic>> _messages = [];
  TextEditingController msgController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late Timer _timer;
  Person? receiver;

  @override
  void initState() {
    super.initState();
    _getMessages();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _getMessages());
    _fetchReceiverData();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _scrollController.dispose();
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    final isSent = message['userSenderId'] == widget.senderId;
    final isReceived = message['userSenderId'] == widget.receiverId;
    // print(widget.receiverId);
    // print(message['userSenderId']);
    // print(isReceived);
    final color = isReceived ? Colors.purple : Colors.pinkAccent;
    final alignment = isReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    String dateString = message['messageDate'];
    DateTime messageDate = DateTime.parse(dateString);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message['messageTxt'],
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('kk:mm').format(messageDate),
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(width: 3,),
                    Icon(Icons.check_sharp,color: Colors.grey[100],size: 15,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        elevation: 0,
        backgroundColor: Color(0xffFCE3EE),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: (){

                  fetchPersonById(widget.senderId);
                  print(widget.receiverId);
                  print(widget.senderId);
                  print(receiver?.name);
                },
                child: Text(widget.name??receiver?.name ?? 'Chat')),
            SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.logo??
                  receiver?.logo ??
                      'https://i.pinimg.com/564x/d4/4c/8d/d44c8de927dc54c25f82a19320553a03.jpg'),
              radius: 25,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: AlignmentDirectional.bottomEnd,
              image: AssetImage('images/2.png')),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageItem(message);
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: msgController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () async {
                    final text = msgController.text.trim();
                    if (text.isEmpty) {
                      return; // Don't send empty message
                    }

                    final message = Message(
                      id: 0,
                      messageTxt: msgController.text,
                      messageDate: DateTime.now(),
                      userSenderId: widget.senderId,
                      userReciverId: widget.receiverId,
                      seen: false,
                      personNameSender: '',
                    );

                    await _sendMessage(message);
                    msgController.clear();
                  },
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getMessages() async {
    final response = await http.get(Uri.parse(
        '$apiConstant/Message/GetMessageChat/${widget.receiverId},${widget.senderId}'));
    final responseBody = json.decode(response.body);

    if (responseBody['success'] == true) {
      setState(() {
        _messages = List<Map<String, dynamic>>.from(responseBody['data']);
      });
      // Scroll to the end of the list
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      // Handle error
    }
  }


  Future<void> _fetchReceiverData() async {
    try {
      final fetchedReceiver = await fetchPersonById(widget.senderId);
      setState(() {
        receiver = fetchedReceiver;
      });
    } catch (e) {
      // Handle error
    }
  }
  Future<void> _sendMessage(Message message) async {
    final text = msgController.text.trim();
    if (text.isEmpty) {
      return; // Don't send empty message
    }

    final url = Uri.parse('https://www.tulipm.net/api/Message');
    final headers = {'Content-Type': 'application/json', 'accept': '*/*'};
    final body = jsonEncode({
      'id': message.id,
      'messageTxt': message.messageTxt,
      'messageDate': message.messageDate.toIso8601String(),
      'userSenderId': message.userSenderId,
      'userReciverId': message.userReciverId,
      'seen': message.seen,
      'personNameSender': message.personNameSender,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Message sent successfully
    } else {
      // Handle error
    }
  }
}


