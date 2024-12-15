import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../../components/badge_widget.dart';
import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import 'components/info_list.dart';
import 'components/working_hour_section.dart';

class TrainerProfile extends StatelessWidget {
  const TrainerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(),
              ),
              const InfoCardSection(),
              const AboutSection(),
              WorkingHourSection(),
              const AddressSection(),
              const TrainerInfoSection(),
              const ReviewsSection(),
              const GallerySection()
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCardSection extends StatelessWidget {
  const InfoCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoCard(
              svgPath: 'icons/ic_users.svg', // Replace with your SVG path
              value: '5000+',
              label: 'Trainees',
            ),
            InfoCard(
              svgPath: 'icons/ic_experience.svg', // Replace with your SVG path
              value: '10+',
              label: 'Experience',
            ),
            InfoCard(
              svgPath: 'icons/ic_rating.svg', // Replace with your SVG path
              value: '4.9+',
              label: 'Rating',
            ),
            InfoCard(
              svgPath: 'icons/ic_reviews.svg', // Replace with your SVG path
              value: '3,456',
              label: 'Reviews',
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String svgPath;
  final String value;
  final String label;

  const InfoCard({super.key, 
    required this.svgPath,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.grayBlack,
          radius: 24,
          child: SvgPicture.asset(
            svgPath,
            color: Colors.white,
            width: 20,
            height: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
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
          const BadgeWidget(
              size: 100,
              level: 2,
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15'),
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

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About', style: AppDefaults.bodyTitleTextStyle),
          const SizedBox(height: AppDefaults.space / 2),
          Text(
            'There are many variations of passages of Lorem Ipsum available, '
            'but the majority have suffered alteration in some form, by injected humour.',
            style: AppDefaults.titleStyleSmall,
          ),
        ],
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
