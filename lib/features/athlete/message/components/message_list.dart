import 'package:flutter/material.dart';

import 'message_item.dart';

class MessageList extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const MessageList({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Column(
          children: [
            MessageItem(
              avatar: message['avatar'],
              name: message['name'],
              message: message['message'],
              time: message['time'],
              isActive: message['isActive'],
              unreadCount: message['unreadCount'],
              isTyping: message['isTyping'],
              isMuted: message['isMuted'],
            ),
            Divider(color: Colors.grey.shade700), // Divider between items
          ],
        );
      },
    );
  }
}
