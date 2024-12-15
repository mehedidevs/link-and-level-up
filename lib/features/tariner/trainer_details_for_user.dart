import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';


class TrainerDetailsPageForUser extends StatelessWidget {
  const TrainerDetailsPageForUser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background500,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Trainer Details'),
          actions: [
            IconButton(icon: const Icon(Icons.share), onPressed: () {}),
            IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TrainerHeader(),
              const TrainerStats(),
              const SizedBox(
                height: AppDefaults.space,
              ),
              const TrainerAbout(),
              TrainerWorkingHours(),
              const SuggestedFacilitator(),
              const TrainerReviews(),
              const TrainerGallary(),
              const BookAppointmentButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TrainerHeader extends StatelessWidget {
  const TrainerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
              // Replace with your image URL
              width: 80, // Set the width of the image
              height: 80, // Set the height of the image
              fit: BoxFit.cover, // Ensure the image covers the entire circle
            ),
          ),
          const SizedBox(width: AppDefaults.space),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mickael whisper',
                style: AppDefaults.buttonTextStyle,
              ),
              Text(
                'Athlete',
                style:
                    AppDefaults.titleStyle.copyWith(color: AppColors.textDark9),
              ),
              const SizedBox(
                height: AppDefaults.space / 2,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 20,
                    color: AppColors.textSmall,
                  ),
                  Text(
                    'Green Valley, Hill road, NY',
                    style: AppDefaults.titleStyleSmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TrainerStats extends StatelessWidget {
  const TrainerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStat('icons/ic_trainees.svg', '5000+', 'Trainees'),
        _buildStat('icons/ic_experience.svg', '10+', 'Experience'),
        _buildStat('icons/ic_rating_white.svg', '4.9+', 'Rating'),
        _buildStat('icons/ic_reviews.svg', '3,456', 'Reviews'),
      ],
    );
  }

  Widget _buildStat(String icon, String value, String label) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(
          height: AppDefaults.space / 3,
        ),
        Text(value, style: AppDefaults.bodyTitleTextStyle),
        const SizedBox(
          height: AppDefaults.space / 3,
        ),
        Text(label, style: AppDefaults.titleStyleReview),
      ],
    );
  }
}


class TrainerGallary extends StatelessWidget {
  const TrainerGallary({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 214,
            width: 165,
            child: Image.network(
                fit: BoxFit.cover,
                'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/facilator%2Fd98b924b1a1565c14ea24bc735a0f109.jpeg?alt=media&token=600dd3a1-2e47-465c-a0a9-134132caf608'),
          ),
        );
      }),
    );
  }
}

class TrainerAbout extends StatelessWidget {
  const TrainerAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About', style: AppDefaults.bodyTitleTextStyle),
          const SizedBox(height: 8),
          Text(
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.',
              style: AppDefaults.bodyTextStyle),
        ],
      ),
    );
  }
}

class TrainerWorkingHours extends StatelessWidget {
  final List<Map<String, String>> workingHours = [
    {'day': 'Monday', 'hours': '10:00 - 12:00'},
    {'day': 'Tuesday', 'hours': '10:00 - 12:00'},
    {'day': 'Wednesday', 'hours': '10:00 - 12:00'},
    {'day': 'Thursday', 'hours': '10:00 - 12:00'},
    {'day': 'Friday', 'hours': '10:00 - 12:00'},
    {'day': 'Saturday', 'hours': '10:00 - 12:00'},
    {'day': 'Sunday', 'hours': '10:00 - 12:00'},
  ];

  TrainerWorkingHours({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Working Hours', style: AppDefaults.bodyTitleTextStyle),
          const SizedBox(height: 8),
          ...workingHours.map((day) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(day['day']!, style: AppDefaults.bodyTextStyle),
                    Text(day['hours']!, style: AppDefaults.bodyTextStyle),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class SuggestedFacilitator extends StatefulWidget {
  const SuggestedFacilitator({super.key});

  @override
  _SuggestedFacilitatorState createState() => _SuggestedFacilitatorState();
}

class _SuggestedFacilitatorState extends State<SuggestedFacilitator> {
  List<bool> selectedStates = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Suggested Facilitator',
                  style: AppDefaults.titleHeadlineStyle),
              TextButton(
                onPressed: () {},
                child: Text('See all', style: AppDefaults.titleSeeAll),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return FacilitatorCard(
                title: 'Pulse Football Center ${index + 1}',
                location: 'New York, USA',
                price: '\$150.00 /month',
                isSelected: selectedStates[index],
                onTap: () {
                  setState(() {
                    selectedStates[index] = !selectedStates[index];
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class FacilitatorCard extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const FacilitatorCard({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDefaults.space),
        child: Card(
          color: AppColors.scaffoldBackground,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/facilator%2F776c9fff5d992fdb318728d4227634f8.jpeg?alt=media&token=1ab35219-c557-468c-a64d-d93c55209144',
                      // Replace with your image URL
                      width: 124,
                      height: 132,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary500,
                                  borderRadius: BorderRadius.circular(
                                      AppDefaults.radius * 2),
                                ),
                                child: const Text(
                                  'Open Field',
                                  style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SvgPicture.asset('icons/ic_star.svg'),
                              const Text(
                                '4.6',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Pulse Football Center',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.grey,
                                size: 15,
                              ),
                              Text(
                                'New York, USA',
                                style: GoogleFonts.inter(
                                  color: AppColors.textDark9,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                '\$150.00',
                                style: GoogleFonts.inter(
                                  color: AppColors.primary500,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' /month',
                                style: GoogleFonts.inter(
                                  color: AppColors.text800,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (isSelected)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    child: Center(
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: onTap,
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset('icons/ic_selected.svg'),
                              Text(
                                'Selected',
                                style: AppDefaults.buttonTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}



class TrainerReviews extends StatelessWidget {
  const TrainerReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          // Add more ReviewCard widgets as needed
        ],
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

class BookAppointmentButton extends StatelessWidget {
  const BookAppointmentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.PaymentMethod);

        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          'Book an appointment',
          style: AppDefaults.buttonTextStyle,
        ),
      ),
    );
  }
}
