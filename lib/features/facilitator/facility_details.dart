import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../tariner/components/available_hours.dart';
import 'components/facilitator_gallary.dart';

class FacilityDetails extends StatelessWidget {
  const FacilityDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ark Indoor Stadium'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button action
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(
                    'icons/ic_share_circle.svg',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset('icons/ic_edit_circle.svg')),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvailableHours(),
              const RateLayout(),
              const AddressSection(),
              Text('Gallery', style: AppDefaults.bodyTitleTextStyle),
              const SizedBox(height: 700, child: FacilitatorGallary()),
              const ReviewsSection(),
              const GallerySection()
            ],
          ),
        ),
      ),
    );
  }
}

class RateLayout extends StatelessWidget {
  const RateLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.attach_money, // Placeholder for the top icon
                size: 14,
                color: AppColors
                    .primary500, // Using a similar color tone from the image
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Hourly Rate - \$20.00",
                  style: AppDefaults.titleSeeAll,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.groups, // Placeholder for the bottom icon
                size: 14,
                color: AppColors
                    .primary500, // Using a similar color tone from the image
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Capacity: 26 Person",
                  style: AppDefaults.titleSeeAll,
                ),
              )
            ],
          ),
        ],
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

class FacilityListCardItem extends StatelessWidget {
  final String text; // Accepting dynamic text as a parameter

  const FacilityListCardItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gallery(),
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
