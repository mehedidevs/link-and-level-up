import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../../config/app_colors.dart';
import '../../../../config/routes/app_routes.dart';

class PostWidget extends StatelessWidget {
  final String profileImage;
  final String username;
  final String postTime;
  final String contentText;
  final List<String> hashtags;
  final int likes;
  final int comments;
  final List<String> images;

  const PostWidget({super.key, 
    required this.profileImage,
    required this.username,
    required this.postTime,
    required this.contentText,
    required this.hashtags,
    required this.likes,
    required this.comments,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.AthleteCommunityPostComment);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: AppColors.background500,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfile(profileImage: profileImage,
                    username: username,
                    postTime: postTime),
                const SizedBox(height: 8.0),
                PostContent(contentText: contentText, images: images),
                const SizedBox(height: 8.0),
                HashtagWidget(hashtags: hashtags),
                const SizedBox(height: 8.0),
                Divider(color: Colors.white.withOpacity(0.1), thickness: 2,),
                const SizedBox(height: 4.0),
                PostActions(likes: likes, comments: comments),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final String profileImage;
  final String username;
  final String postTime;

  const UserProfile({super.key, 
    required this.profileImage,
    required this.username,
    required this.postTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.AthleteCommunityProfile);
          },
          child: CircleAvatar(
            backgroundImage: AssetImage(profileImage),
          ),
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username, style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.access_time_filled, color: Colors.white, size: 16),
                const SizedBox(width: 4.0),
                Text(postTime, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class PostContent extends StatelessWidget {
  final String contentText;
  final List<String> images;

  const PostContent({super.key, required this.contentText, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(contentText, style: const TextStyle(color: Colors.white)),
        if (images.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: images.map((image) =>
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 4),
                    child: Image.asset(image),
                  ))).toList(),
            ),
          ),
      ],
    );
  }
}

class HashtagWidget extends StatelessWidget {
  final List<String> hashtags;

  const HashtagWidget({super.key, required this.hashtags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: hashtags.map((tag) =>
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(tag, style: const TextStyle(color: Color(0xff54B1B7))),
          )).toList(),
    );
  }
}

class PostActions extends StatelessWidget {
  final int likes;
  final int comments;

  const PostActions({super.key, required this.likes, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset('icons/ic_like_color.svg', height: 20, width: 20,),
            const SizedBox(width: 4.0),
            Text(likes.toString(), style: const TextStyle(color: Colors.white)),
            const SizedBox(width: 16.0),
            SvgPicture.asset('icons/ic_messages.svg', height: 20, width: 20,),
            const SizedBox(width: 4.0),
            Text(comments.toString(), style: const TextStyle(color: Colors.white)),
          ],
        ),


        //Icon(Icons.share, color: Colors.grey),
      ],
    );
  }
}