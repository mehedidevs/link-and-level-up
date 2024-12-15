import 'package:flutter/material.dart';

import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';


class MessageItem extends StatelessWidget {
  final String avatar;
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final bool isTyping;
  final bool isMuted;
  final bool isActive;

  const MessageItem({super.key,
    required this.avatar,
    required this.name,
    required this.message,
    required this.time,
    required this.isActive,
    this.unreadCount = 0,
    this.isTyping = false,
    this.isMuted = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.AthleteChat);
      },
      leading: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(avatar),
            radius: 25,
          ),

          Positioned(
            right: 0,
            bottom: 2,
              child: isActive ? Icon(Icons.circle,color: Colors.green.shade700,size: 15,) :
              Icon(Icons.circle,color: Colors.grey.shade500,size: 15,)
                ),
        ],
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: isTyping
          ? const Text(
              "Typing...",
              style: TextStyle(color: Colors.greenAccent),
            )
          : Text(
              message,
              style: const TextStyle(color: Colors.grey),
            ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            time,
            style: const TextStyle(color: Colors.grey),
          ),
          const Spacer(),

          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (isMuted)
                Icon(Icons.mic_off,size: 25,color: Colors.grey.shade500,),

              if(unreadCount>0)
                CircleAvatar(
                  radius: 10,
                  backgroundColor: const Color(0xffB79654),
                  child: Text(
                    unreadCount.toString(),
                    style:AppDefaults.buttonTextStyleSmall,
                  ),
                ),
            ],
          ),
        ],
      )
    );
  }
}
