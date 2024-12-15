import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/app_defaults.dart';
import 'components/comment_list.dart';
import 'components/post_widget.dart';
import 'data/comment.dart';

class CommunityPostCommentScreen extends StatelessWidget {
  final List<Comment> comments = [
    Comment(
      username: 'Mickael W.',
      avatarUrl: 'images/profile_holder2.png',
      content: 'Lorem ipsum dolor sit amet consectetur...',
      timeAgo: '50 minutes ago',
      likes: 1210,
      replies: 53,
    ),

    Comment(
      username: 'Mickael W.',
      avatarUrl: 'images/profile_holder2.png',
      content: 'Lorem ipsum dolor sit amet consectetur...',
      timeAgo: '50 minutes ago',
      likes: 1210,
      replies: 53,
    ),


    Comment(
      username: 'Mickael W.',
      avatarUrl: 'images/profile_holder2.png',
      content: 'Lorem ipsum dolor sit amet consectetur...',
      timeAgo: '50 minutes ago',
      likes: 1210,
      replies: 53,
    ),

    Comment(
      username: 'Mickael W.',
      avatarUrl: 'images/profile_holder2.png',
      content: 'Lorem ipsum dolor sit amet consectetur...',
      timeAgo: '50 minutes ago',
      likes: 1210,
      replies: 53,
    ),

    Comment(
      username: 'Mickael W.',
      avatarUrl: 'images/profile_holder2.png',
      content: 'Lorem ipsum dolor sit amet consectetur...',
      timeAgo: '50 minutes ago',
      likes: 1210,
      replies: 53,
    ),

    Comment(
      username: 'Mickael W.',
      avatarUrl: 'images/profile_holder2.png',
      content: 'Lorem ipsum dolor sit amet consectetur...',
      timeAgo: '50 minutes ago',
      likes: 1210,
      replies: 53,
    ),


    Comment(
      username: 'Mickael W.',
      avatarUrl: 'images/profile_holder2.png',
      content: 'Lorem ipsum dolor sit amet consectetur...',
      timeAgo: '50 minutes ago',
      likes: 1210,
      replies: 53,
    ),

    Comment(
      username: 'Mickael W.',
      avatarUrl: 'images/profile_holder2.png',
      content: 'Lorem ipsum dolor sit amet consectetur...',
      timeAgo: '50 minutes ago',
      likes: 1210,
      replies: 53,
    ),

  ];

   CommunityPostCommentScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Mickael W. Comment',style: AppDefaults.titleHeadlineStyle,),
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context,true),
            child: const Icon(Icons.arrow_back_outlined,color: Colors.white,size: 25,),
          )
      ),
      body: Column(
        children: [
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
          const SizedBox(height: 16),
          Expanded(child: CommentList(comments: comments)),
          const InputCommentSection(),
        ],
      ),
    );
  }
}

class InputCommentSection extends StatelessWidget {
  const InputCommentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 4.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('images/profile_holder2.png'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Leave your thoughts...',
                    fillColor:const Color(0xff282828),
                    hintStyle: AppDefaults.buttonTextStyle,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
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
                onPressed: () {
                },
                backgroundColor: const Color(0xffB79654),
                child: SvgPicture.asset('icons/ic_navigation.svg',height: 20,width: 20,),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

