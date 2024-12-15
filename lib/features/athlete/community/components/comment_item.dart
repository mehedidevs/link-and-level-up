import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../data/comment.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(comment.avatarUrl),
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(Icons.circle,size: 8,color: Colors.grey),
                    ),
                    Text(
                      comment.timeAgo,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('icons/ic_like.svg', height: 20, width: 20,),
                        const SizedBox(width: 4),
                        Text('${comment.likes}', style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        SvgPicture.asset('icons/ic_messages.svg', height: 20, width: 20,),
                        const SizedBox(width: 4),
                        const Text('Reply', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
