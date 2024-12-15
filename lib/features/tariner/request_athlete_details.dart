import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';

class RequestAthleteDetails extends StatelessWidget {
  const RequestAthleteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          title: const Text('Athlete Details'),

        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(),
              AboutSection(),
              AddressSection(),
              AthleteButtonsSection(),
              ContactSection()
            ],
          ),
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
// AthleteButtonsSection Component (Updated with Containers)
class AthleteButtonsSection extends StatelessWidget {
  const AthleteButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Single Athlete Container
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Handle Single Athlete tap action
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
                color: Colors.transparent, // Background color for "unselected" state
              ),
              child: const Center(
                child: Text(
                  'Single Athlete',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Multiple Athlete Container
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Handle Multiple Athlete tap action
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[850], // Background color for "selected" state
              ),
              child: const Center(
                child: Text(
                  'Multiple Athlete (04)',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// ContactSection Component
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.email, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'athleteemail145@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.phone, color: Colors.white),
            SizedBox(width: 8),
            Text(
              '+9985-4512-45123',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
