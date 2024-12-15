import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';

class TrainerSyncSection extends StatelessWidget {
  final TrainerRepository repository = TrainerRepository();

  TrainerSyncSection({super.key});

  @override
  Widget build(BuildContext context) {
    final trainers = repository.getTrainers();
    return Scaffold(
      body: SizedBox(
        width: 500,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: trainers.length,
          shrinkWrap: true,
          // To allow ListView to wrap its content
          physics: const NeverScrollableScrollPhysics(),
          // Prevent ListView from scrolling independently
          itemBuilder: (context, index) {
            return TrainerCard(trainer: trainers[index]);
          },
        ),
      ),
    );
  }
}

class TrainerModel {
  final String name;
  final String imagePath;
  final double rating;
  final int reviewCount;

  TrainerModel({
    required this.name,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
  });
}

class TrainerRepository {
  List<TrainerModel> getTrainers() {
    // Mock data
    return [
      TrainerModel(
          name: "Jhony Deep",
          imagePath: "images/placeholder.jpg",
          rating: 4.8,
          reviewCount: 100),
      TrainerModel(
          name: "Jhony Deep",
          imagePath: "images/placeholder.jpg",
          rating: 4.8,
          reviewCount: 100),
      TrainerModel(
          name: "Jhony Deep",
          imagePath: "images/placeholder.jpg",
          rating: 4.8,
          reviewCount: 100),
      TrainerModel(
          name: "Jhony Deep",
          imagePath: "images/placeholder.jpg",
          rating: 4.8,
          reviewCount: 100),
      // Add more trainers...
    ];
  }
}

class TrainerCard extends StatelessWidget {
  final TrainerModel trainer;

  const TrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ProfileImage(imagePath: trainer.imagePath),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('icons/ic_verify.svg'),
                              Text('Professional trainer',
                                  style: AppDefaults.titleStyleSmall),
                            ],
                          ),
                          SvgPicture.asset('icons/ic_love_fav.svg')
                        ],
                      ),
                      Text(
                        trainer.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Trainer',
                        style: TextStyle(color: Colors.grey),
                      ),
                      RatingDisplay(
                          rating: trainer.rating,
                          reviewCount: trainer.reviewCount),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String imagePath;

  const ProfileImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDefaults.radius),
      child: Image.network(
        'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
        // Replace with your image URL
        width: 100, // Set the width of the image
        height: 100, // Set the height of the image
        fit: BoxFit.cover, // Ensure the image covers the entire circle
      ),
    );
  }
}

class RatingDisplay extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const RatingDisplay(
      {super.key, required this.rating, required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('icons/ic_star.svg'),
        Text(
          ' $rating ($reviewCount Reviews)',
          style: AppDefaults.bodyTextStyle,
        ),
      ],
    );
  }
}

class AppointmentButton extends StatelessWidget {
  const AppointmentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppDefaults.padding / 3, horizontal: AppDefaults.padding),
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          // Text color
          side: const BorderSide(color: AppColors.primary500, width: 1),
          // Border color and width
          backgroundColor: Colors.transparent, // Background color
        ),
        onPressed: () {},
        child: Text(
          'Make an appointment',
          style: AppDefaults.buttonTextStyle,
        ),
      ),
    );
  }
}
