import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';

class FacilitatorProfilePage extends StatelessWidget {
  const FacilitatorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(),
              ProfileCompletionSection(),
              AboutSection(),
              FacilityListSection(),
              TrainerSection(),
              ReviewsSection(),
              GallerySection()
            ],
          ),
        ),
      ),
    );
  }
}

class TrainerSection extends StatelessWidget {
  const TrainerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add/ Sync Trainer', style: AppDefaults.bodyTitleTextStyle),
          const SizedBox(height: 10),
          Trainer(),
        ],
      ),
    );
  }
}

class Trainer extends StatelessWidget {
  final TrainerRepository repository = TrainerRepository();

  Trainer({super.key});

  @override
  Widget build(BuildContext context) {
    final trainers = repository.getTrainers();
    return SizedBox(
      height: 145,
      width: double.infinity, // Set a fixed height for the horizontal list
      child: ListView.builder(
        itemCount: trainers.length, // Number of trainer cards
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        itemBuilder: (context, index) {
          return FavoriteTrainerCard(trainer: trainers[index]);
        },
      ),
    );
  }
}

class FavoriteTrainerCard extends StatelessWidget {
  final TrainerModel trainer;

  const FavoriteTrainerCard({
    super.key,
    required this.trainer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.TrainerDetailsPageForUser);
        },
        child: SizedBox(
          width: 300, // Set a fixed width for each card
          child: Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
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
          ),
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
        imagePath,
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

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://www.ibexwealth.com/files/85483/Denise%20Anderson.jpg',
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
                'Denish Anderson',
                style: AppDefaults.buttonTextStyle,
              ),
              Text(
                'Stadium Owner',
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

class ProfileCompletionSection extends StatefulWidget {
  const ProfileCompletionSection({super.key});

  @override
  State<ProfileCompletionSection> createState() =>
      _ProfileCompletionSectionState();
}

class _ProfileCompletionSectionState extends State<ProfileCompletionSection> {
  @override
  Widget build(BuildContext context) {
    int progress = 80;

    return Card(
      color: AppColors.background500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profile Completion', style: AppDefaults.otpTextStyle),
                  Text('80%', style: AppDefaults.otpTextStyle),
                ],
              ),
            ),
            Slider(
              inactiveColor: AppColors.secondary100,
              thumbColor: AppColors.secondary400,
              activeColor: AppColors.secondary400,
              value: progress.toDouble(),
              onChanged: (value) {
                setState(() {
                  progress = value.toInt();
                });
              },
              min: 0,
              max: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cardTexts = [
      'Established in 2004',
      'ISO Certified',
      '23+ Professionals',
      'Eco Friendly Sports Hub',
    ];

    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cards per row, adjust to 4 for smaller screens
          childAspectRatio: 1.8, // Adjust card size ratio
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 4,
        // Total number of cards (4 in this case)
        itemBuilder: (context, index) {
          return AboutCardItem(
            text: cardTexts[index],
          );
        },
      ),
    );
  }
}

class FacilityListSection extends StatelessWidget {
  const FacilityListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cardTexts = [
      'Ark Indoor Stadium',
      'Sports Club',
      'Sports Club'
    ];

    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cardTexts.length,
        // Total number of cards (4 in this case)
        itemBuilder: (context, index) {
          return FacilityListCardItem(
            text: cardTexts[index],
          );
        },
      ),
    );
  }
}

class AboutCardItem extends StatelessWidget {
  final String text; // Accepting dynamic text as a parameter

  const AboutCardItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset('icons/ic_faci_about.svg')),
            const SizedBox(height: 4),
            Text(
              text,
              style: AppDefaults.textWhite12_400,
            ),
          ],
        ),
      ),
    );
  }
}

class FacilityListCardItem extends StatelessWidget {
  final String text; // Accepting dynamic text as a parameter

  const FacilityListCardItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.FacilityDetails);
      },
      child: Card(
        color: AppColors.background500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: AppDefaults.textWhite12_400,
              ),
              const SizedBox(height: 4),
              const Icon(
                Icons.navigate_next,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddressSection extends StatefulWidget {
  const AddressSection({super.key});

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarker();
  }

  void _createMarker() async {
    const markerIcon = BitmapDescriptor.defaultMarker;
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('customMarker'),
          position: _center,
          icon: markerIcon,
        ),
      );
    });
  }

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
              Text('Address', style: AppDefaults.bodyTitleTextStyle),
              TextButton(
                onPressed: () {},
                child:
                    const Text('View on map', style: TextStyle(color: Colors.amber)),
              ),
            ],
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
          const SizedBox(height: AppDefaults.space / 2),
          Container(
            height: 200,
            color: Colors.grey,
            child: GoogleMap(
              mapType: MapType.normal,
              style: AppDefaults.aubergineMapStyle,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingSessions extends StatelessWidget {
  const UpcomingSessions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Session (2)', style: AppDefaults.bodyTitleTextStyle),
          const EventCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),
          const SizedBox(height: 8), // Add some spacing between cards
          const EventCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String time;

  const EventCard({
    super.key,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '$date  $time',
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                        borderRadius: AppDefaults.borderRadius,
                        color: AppColors.placeholder),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDefaults.padding / 2),
                        child: Text(
                          'More Details',
                          style: AppDefaults.buttonTextStyleSmall,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reviews (1)', style: AppDefaults.bodyTitleTextStyle),
          const ReviewItem(),
          const ReviewItem(),
          const ReviewItem(),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background500,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
                        // Replace with your image URL
                        width: 32, // Set the width of the image
                        height: 32, // Set the height of the image
                        fit: BoxFit
                            .cover, // Ensure the image covers the entire circle
                      ),
                    ),
                    const SizedBox(
                      width: AppDefaults.space / 2,
                    ),
                    Text(
                      'Jhony Deep',
                      style: AppDefaults.titleStyleReview,
                    ),
                  ],
                ),
                Text(
                  '2 month ago',
                  style: AppDefaults.titleStyleReview,
                ),
              ],
            ),
            const SizedBox(
              height: AppDefaults.space,
            ),
            Text(
              'There are many variations of passages of Lorem Ipsum available, '
              'but the majority have suffered alteration in some form, by injected humour.',
              style: AppDefaults.titleStyleSmall,
            ),
            const SizedBox(
              height: AppDefaults.space,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: List.generate(
                      5, (index) => const Icon(Icons.star, color: Colors.amber)),
                ),
                const SizedBox(
                  width: AppDefaults.space / 2,
                ),
                Text(
                  '5.00',
                  style: AppDefaults.buttonTextStyleSmall,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gallery (2)', style: AppDefaults.bodyTitleTextStyle),
          const Gallery(),
        ],
      ),
    );
  }
}

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background500,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppDefaults.radius)),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1611812695617-76998c1898af?q=80&w=3987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      // Replace with your image URL
                      width: 200, // Set the width of the image
                      height: 250, // Set the height of the image
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire circle
                    ),
                  ),
                  const SizedBox(
                    width: AppDefaults.space,
                  ),
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppDefaults.radius)),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1520642375575-d21ff7b96d49?q=80&w=3432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      // Replace with your image URL
                      width: 200, // Set the width of the image
                      height: 250, // Set the height of the image
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire circle
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppDefaults.space,
            ),
          ],
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
          name: "Jenny ",
          imagePath:
              "https://media.istockphoto.com/id/1361355221/photo/happy-asian-athletic-woman-exercising-with-hand-weights-in-a-gym-and-looking-at-camera.jpg?s=612x612&w=0&k=20&c=bDUvRf25Ua6iEIbdbWDjRxSEG63Mpz2QkwhZjMuvE3c=",
          rating: 4.8,
          reviewCount: 100),
      TrainerModel(
          name: "Jhony Jim",
          imagePath:
              "https://nationalpti.org/wp-content/uploads/2014/02/Personal-Trainer.jpg",
          rating: 4.8,
          reviewCount: 100),

      TrainerModel(
          name: "Chen Deep",
          imagePath:
              "https://hips.hearstapps.com/hmg-prod/images/mh-trainer-2-1533576998.png?resize=640:*",
          rating: 4.8,
          reviewCount: 100),

      TrainerModel(
          name: "Albert Deep",
          imagePath:
              "https://bryanuniversity.edu/wp-content/uploads/personal-train-undergrad-cert@2x-scaled.jpg",
          rating: 4.8,
          reviewCount: 100),
      // Add more trainers...
    ];
  }
}
