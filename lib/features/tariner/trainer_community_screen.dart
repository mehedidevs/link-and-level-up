import 'package:flutter/material.dart';

import '../../../config/routes/app_routes.dart';
import '../athlete/community/components/post_widget.dart';

class TrainerCommunityScreen extends StatelessWidget {
  const TrainerCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          PostWidget(
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
          PostWidget(
            profileImage: 'images/profile_holder2.png',
            username: 'Devon Lane',
            postTime: '1 hour ago',
            contentText:
                'Lorem ipsum dolor sit amet consectetur. Aenean commodo euismod sapien tempor. Vel vitae odio in tempor amet et dignissim ullamcorper.',
            hashtags: ['#training', '#game'],
            likes: 1210,
            comments: 35,
            images: [
              'images/preview1.png',
              'images/preview1.png',
              'images/preview1.png',
            ],
          ),
          PostWidget(
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
          PostWidget(
            profileImage: 'images/profile_holder2.png',
            username: 'Devon Lane',
            postTime: '1 hour ago',
            contentText:
                'Lorem ipsum dolor sit amet consectetur. Aenean commodo euismod sapien tempor. Vel vitae odio in tempor amet et dignissim ullamcorper.',
            hashtags: ['#training', '#game'],
            likes: 1210,
            comments: 35,
            images: [
              'images/preview1.png',
              'images/preview1.png',
              'images/preview1.png',
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.AthleteCommunityCreatePost);
        },
        backgroundColor: const Color(0xffB79654),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
