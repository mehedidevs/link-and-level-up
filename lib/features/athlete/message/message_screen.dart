import 'package:flutter/material.dart';

import '../../../config/app_defaults.dart';
import 'components/message_list.dart';
import 'components/search_bar_section.dart';

class MessagesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> messages = [
    {
      'avatar': 'images/profile_holder.png',
      'name': 'Jane Cooper',
      'message': 'Lorem ipsum dolor sit amet consectetur...',
      'time': '7:11 PM',
      'isActive': true,
      'unreadCount': 2,
      'isTyping': false,
      'isMuted': false,
    },
    {
      'avatar': 'images/profile_holder.png',
      'name': 'Guy Hawkins',
      'message': 'Lorem ipsum dolor sit amet consectetur...',
      'time': '7:11 PM',
      'isActive': false,
      'unreadCount': 1,
      'isTyping': false,
      'isMuted': true,
    },
    // Add more messages here
  ];

  MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Messages',
            style: AppDefaults.titleHeadlineStyle,
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
        body: Column(
          children: [
            const SearchBarSection(),
            Expanded(child: MessageList(messages: messages)),
          ],
        ),
      ),
    );
  }
}
