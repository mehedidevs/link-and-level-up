import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_defaults.dart';

class FacilitatorReview extends StatelessWidget {
  const FacilitatorReview({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reviews (210)', style: AppDefaults.titleHeadlineStyle),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      SvgPicture.asset('icons/ic_edit_review.svg'),
                      Text(
                        'Write a review',
                        style: AppDefaults.titleSeeAll,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const ReviewCard(
              name: 'Jhony Deep',
              date: '2 month ago',
              rating: 5.0,
              comment:
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.',
            ),
            const SizedBox(height: 8),
            const ReviewCard(
              name: 'Jhony Deep',
              date: '2 month ago',
              rating: 5.0,
              comment:
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.',
            ),
            const SizedBox(height: 8),
            const ReviewCard(
              name: 'Jhony Deep',
              date: '2 month ago',
              rating: 5.0,
              comment:
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.',
            ), const SizedBox(height: 8),
            const ReviewCard(
              name: 'Jhony Deep',
              date: '2 month ago',
              rating: 5.0,
              comment:
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.',
            ), const SizedBox(height: 8),
            const ReviewCard(
              name: 'Jhony Deep',
              date: '2 month ago',
              rating: 5.0,
              comment:
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.',
            ), const SizedBox(height: 8),
            const ReviewCard(
              name: 'Jhony Deep',
              date: '2 month ago',
              rating: 5.0,
              comment:
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.',
            ),
            // Add more ReviewCard widgets as needed
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final double rating;
  final String comment;

  const ReviewCard({
    super.key,
    required this.name,
    required this.date,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.scaffoldBackground,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('icons/ic_trainer.png'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppDefaults.bodyTextStyle),
                    Text(date, style: AppDefaults.bodyTextStyle),
                  ],
                ),
                const Spacer(),
                Row(
                  children: List.generate(
                      5,
                          (index) => Icon(Icons.star,
                          color: index < rating ? Colors.amber : Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(comment, style: AppDefaults.bodyTextStyle),
          ],
        ),
      ),
    );
  }
}