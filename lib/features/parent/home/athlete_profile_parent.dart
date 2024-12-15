import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';


class AthleteProfileParent extends StatelessWidget {
  const AthleteProfileParent({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(),
            AboutSection(),
            ChildrenSection(),
            AddressSection(),
            UpcomingSessions(),
            ReviewsSection(),
            GallerySection()
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

class ChildrenSection extends StatelessWidget {
  const ChildrenSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ChildCard(
              name: 'Child Name',
              age: 11,
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F89fcb09b641b376e567ad815cf03f40e.jpeg?alt=media&token=27f82185-d64a-43b4-97ad-bffc1e538beb',
              // Replace with actual image URL
              interestGame: 'Soccer',
              sessionComplete: '10+',
              goal: 'Playing Inter school',
              keyword: 'Attentive, Intelligent, Hardworking',
            ),
            ChildCard(
              name: 'Child Name',
              age: 9,
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F89fcb09b641b376e567ad815cf03f40e.jpeg?alt=media&token=27f82185-d64a-43b4-97ad-bffc1e538beb',
              // Replace with actual image URL
              interestGame: 'Soccer',
              sessionComplete: '10+',
              goal: 'Playing Inter school',
              keyword: 'Attentive, Intelligent, Hardworking',
            ),
            ChildCard(
              name: 'Child Name',
              age: 9,
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F89fcb09b641b376e567ad815cf03f40e.jpeg?alt=media&token=27f82185-d64a-43b4-97ad-bffc1e538beb',
              // Replace with actual image URL
              interestGame: 'Soccer',
              sessionComplete: '10+',
              goal: 'Playing Inter school',
              keyword: 'Attentive, Intelligent, Hardworking',
              isExpanded: true,
            ),
            AddChildrenButton()
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
      color: AppColors.background500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.SessionDetailsPage);
                  },
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

class ChildCard extends StatefulWidget {
  final String name;
  final int age;
  final String imageUrl;
  final String interestGame;
  final String sessionComplete;
  final String goal;
  final String keyword;
  final bool isExpanded;

  const ChildCard({
    super.key,
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.interestGame,
    required this.sessionComplete,
    required this.goal,
    required this.keyword,
    this.isExpanded = false,
  });

  @override
  _ChildCardState createState() => _ChildCardState();
}

class _ChildCardState extends State<ChildCard> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          onExpansionChanged: (bool expanded) {
            setState(() => _isExpanded = expanded);
          },
          title: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name,
                    style: AppDefaults.menuTextStyle
                        .copyWith(color: AppColors.primary600),
                  ),
                  Text(
                    'Age: ${widget.age} years old',
                    style: AppDefaults.bodyTextStyle,
                  ),
                ],
              ),
            ],
          ),
          trailing: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 8),
                  const Text(
                    'Details of children',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow('Interest game:', widget.interestGame),
                  _buildDetailRow('Session Complete:', widget.sessionComplete),
                  _buildDetailRow('Goal:', widget.goal),
                  _buildDetailRow('Keyword:', widget.keyword),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF424242), // Background color
                        foregroundColor: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Edit'),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class AddChildrenButton extends StatelessWidget {
  const AddChildrenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.AddChildrenPage);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.background500,
          // Set your background color here
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          minimumSize:
              const Size(double.infinity, 50), // Optional: adjust padding
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset('icons/ic_plus_circle.svg')),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Add Children',
              style: AppDefaults.buttonTextStyle,
            ),
          ],
        )),
      ),
    );
  }
}
