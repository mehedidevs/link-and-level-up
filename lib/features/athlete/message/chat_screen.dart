import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/app_defaults.dart';
import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      'message': 'Hi, Jubaer Riyad! How are you?',
      'time': '11:08 PM',
      'isSender': 'false'
    },
    {'message': 'Ok great.', 'time': '11:12 PM', 'isSender': 'true'},
    // Add more messages as needed
  ];

   ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('images/profile_holder2.png'),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Jane Cooper',style: AppDefaults.titleStyle.copyWith(color: Colors.white),),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle,color: Colors.green.shade700,size: 15,),
                      const SizedBox(width: 4),
                      Text('Active Now',style: AppDefaults.titleStyleSmall.copyWith(color:Colors.green.shade700 ),),
                    ],
                  )
                ],
              )
            ],
          ),
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => _showPopupMenu(context),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.more_vert,color: Colors.white,size: 25,),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    message: messages[index]['message']!,
                    time: messages[index]['time']!,
                    isSender: messages[index]['isSender'] == 'true',
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.black12,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Write a message...',
                  fillColor: const Color(0xff282828),
                  hintStyle: AppDefaults.buttonTextStyle,
                  filled: true,
                  suffixIcon: Icon(
                    Icons.image_rounded,
                    color: Colors.white.withOpacity(.5),
                    size: 25,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {},
              backgroundColor: const Color(0xffB79654),
              child: SvgPicture.asset(
                'icons/ic_navigation.svg',
                height: 20,
                width: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      color: Colors.black,
      position: const RelativeRect.fromLTRB(100.0, 80.0, 0.0, 0.0), // Position the popup menu
      items: [
        PopupMenuItem<String>(
          value: 'Mute',
          child: Row(
            children: [
              const Icon(Icons.mic_off, color: Colors.white),
              const SizedBox(width: 8),
              Text('Mute',style: AppDefaults.buttonTextStyle.copyWith(color: Colors.white),),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Delete',
          child: Row(
            children: [
              const Icon(Icons.delete, color: Colors.white),
              const SizedBox(width: 8),
              Text('Delete',style:AppDefaults.buttonTextStyle.copyWith(color: Colors.white),),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        _handleMenuSelection(value);
      }
    });
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'Mute':
      // Implement Mute functionality
        break;
      case 'Delete':
      // Implement Delete functionality
        break;
    }
  }
}
