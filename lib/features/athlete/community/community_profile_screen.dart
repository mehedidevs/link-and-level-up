import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/app_defaults.dart';
import 'components/post_widget.dart';

class CommunityProfileScreen extends StatelessWidget {
  const CommunityProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Profile',
            style: AppDefaults.titleHeadlineStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 25,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const ProfileHeader(),
            const SizedBox(height: 20),
            Divider(
              color: Colors.white.withOpacity(0.1),
              thickness: 2,
            ),
            const SizedBox(
              height: 8,
            ),
            const FollowerFollowingSection(),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.white.withOpacity(0.1),
              thickness: 2,
            ),
            const SizedBox(height: 20),
            const ActionButtons(),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.white.withOpacity(0.1),
              thickness: 2,
            ),
            const ActivitySection(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center, // Center the children within the Stack
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xff217D83),
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                AssetImage('images/profile_holder.png'), // Replace with actual image
              ),
            ),
            Positioned(
              bottom: -3, // Align the icon at the bottom of the Stack
              child: SvgPicture.asset(
                'icons/ic_level.svg',
                width: 24, // Set appropriate width/height if needed
                height: 24,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Tammy Gauthier',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const Text(
          'Parent',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

class FollowerFollowingSection extends StatelessWidget {
  const FollowerFollowingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Column(
          children: [
            Text(
              '1565',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Followers',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Container(
          height: 40,
          width: 2,
          color: Colors.white.withOpacity(.1),
        ),
        const Column(
          children: [
            Text(
              '2564',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Following',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1B1A22),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // See Full Profile Action
              },
              child: Text(
                'See Full Profile',
                style: AppDefaults.buttonTextStyle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffB79654),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // Follow Action
              },
              child: Text(
                'Follow',
                style: AppDefaults.buttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivitySection extends StatelessWidget {
  const ActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Activity',
              style: AppDefaults.bodyTitleTextStyle,
            ),
          ),
          const SizedBox(height: 10),
          // Here you would iterate over a list of posts
          const PostWidget(
            profileImage: 'images/profile_holder.png',
            username: 'Tammy Gauthier',
            postTime: '50 minutes ago',
            contentText:
                'Lorem ipsum dolor sit amet consectetur. Aenean commodo euismod sapien tempor. Vel vitae odio in tempor amet et dignissim ullamcorper.',
            hashtags: ['#training', '#game'],
            likes: 1210,
            comments: 35,
            images: [],
          ),
          const PostWidget(
            profileImage: 'images/profile_holder.png',
            username: 'Tammy Gauthier',
            postTime: '1 hour ago',
            contentText:
                'Lorem ipsum dolor sit amet consectetur. Aenean commodo euismod sapien tempor. Vel vitae odio in tempor amet et dignissim ullamcorper.',
            hashtags: ['#training', '#game'],
            likes: 1210,
            comments: 35,
            images: [],
          ),
        ],
      ),
    );
  }
}

// // Reuse the PostWidget class from the previous example
// class PostWidget extends StatelessWidget {
//   final String profileImage;
//   final String username;
//   final String postTime;
//   final String contentText;
//   final List<String> hashtags;
//   final int likes;
//   final int comments;
//   final List<String> images;
//
//   PostWidget({
//     required this.profileImage,
//     required this.username,
//     required this.postTime,
//     required this.contentText,
//     required this.hashtags,
//     required this.likes,
//     required this.comments,
//     required this.images,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Card(
//         color: Color(0xff282828),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               UserProfile(profileImage: profileImage, username: username, postTime: postTime),
//               SizedBox(height: 8.0),
//               PostContent(contentText: contentText, images: images),
//               SizedBox(height: 8.0),
//               HashtagWidget(hashtags: hashtags),
//               SizedBox(height: 4.0),
//               Divider(color: Colors.white.withOpacity(0.1),thickness: 2,),
//               SizedBox(height: 4.0),
//               PostActions(likes: likes, comments: comments),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class UserProfile extends StatelessWidget {
//   final String profileImage;
//   final String username;
//   final String postTime;
//
//   UserProfile({
//     required this.profileImage,
//     required this.username,
//     required this.postTime,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CircleAvatar(
//           backgroundImage: AssetImage(profileImage),
//         ),
//         SizedBox(width: 8.0),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(username, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(Icons.access_time_filled, color: Colors.white, size: 16),
//                 SizedBox(width: 4.0),
//                 Text(postTime, style: TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class PostContent extends StatelessWidget {
//   final String contentText;
//   final List<String> images;
//
//   PostContent({required this.contentText, required this.images});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(contentText, style: TextStyle(color: Colors.white)),
//         if (images.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               children: images.map((image) => Expanded(child: Image.asset(image))).toList(),
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// class HashtagWidget extends StatelessWidget {
//   final List<String> hashtags;
//
//   HashtagWidget({required this.hashtags});
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: hashtags.map((tag) => Padding(
//         padding: const EdgeInsets.only(right: 8.0),
//         child: Text(tag, style: TextStyle(color: Color(0xff54B1B7))),
//       )).toList(),
//     );
//   }
// }
//
// class PostActions extends StatelessWidget {
//   final int likes;
//   final int comments;
//
//   PostActions({required this.likes, required this.comments});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             SvgPicture.asset('icons/ic_like_color.svg',height: 20,width: 20,),
//             SizedBox(width: 4),
//             Text('$likes', style: TextStyle(color: Colors.white)),
//             SizedBox(width: 16),
//             SvgPicture.asset('icons/ic_messages.svg',height: 20,width: 20,),
//             SizedBox(width: 4),
//             Text('$comments', style: TextStyle(color: Colors.white)),
//           ],
//         ),
//         SvgPicture.asset('icons/ic_share.svg',height: 20,width: 20,)
//       ],
//     );
//   }
// }
