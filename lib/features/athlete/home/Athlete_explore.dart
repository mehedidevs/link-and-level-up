import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_defaults.dart';


class AthleteExplore extends StatefulWidget {
  const AthleteExplore({super.key});

  @override
  State<AthleteExplore> createState() => _AthleteExploreState();
}

class _AthleteExploreState extends State<AthleteExplore> {
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

  final List<VenueData> venues = [
    VenueData(
        'Kingdom stadium',
        'Green Valley, Hill road, NY',
        4.8,
        100,
        2.1,
        40,
        'https://images.icc-cricket.com/image/upload/t_ratio21_9-size60/prd/qmdrmzcrewwuovh73h1d'),
    VenueData('Playground', 'Green Valley, NY', 4.6, 100, 2.5, 45,
        'https://images.icc-cricket.com/image/upload/t_ratio21_9-size60/prd/qmdrmzcrewwuovh73h1d'),
    VenueData('Playground', 'Green Valley, NY', 4.6, 100, 2.5, 45,
        'https://images.icc-cricket.com/image/upload/t_ratio21_9-size60/prd/qmdrmzcrewwuovh73h1d'),
    VenueData('Playground', 'Green Valley, NY', 4.6, 100, 2.5, 45,
        'https://images.icc-cricket.com/image/upload/t_ratio21_9-size60/prd/qmdrmzcrewwuovh73h1d'),
    VenueData('Playground', 'Green Valley, NY', 4.6, 100, 2.5, 45,
        'https://images.icc-cricket.com/image/upload/t_ratio21_9-size60/prd/qmdrmzcrewwuovh73h1d'),
    VenueData('Playground', 'Green Valley, NY', 4.6, 100, 2.5, 45,
        'https://images.icc-cricket.com/image/upload/t_ratio21_9-size60/prd/qmdrmzcrewwuovh73h1d'),
    // Add more venues as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
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

          // Search bar
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.circular(AppDefaults.space),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search trainer, facilitator',
                  hintStyle: AppDefaults.bodyTextStyle,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const FilterBottomSheet(),
                      );
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            // Adjust this value to position above the bottom navigation
            height: 220,
            // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: venues.length,
              itemBuilder: (context, index) {
                return _buildVenueCard(venues[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildVenueCard(VenueData venue) {
  return Container(
    width: 300, // Adjust the width as needed
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Card(
      color: AppColors.scaffoldBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                venue.imagePath,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.favorite_border, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(venue.title, style: AppDefaults.bodyTitleTextStyle),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(venue.location, style: const TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('icons/ic_star.svg'),
                        const SizedBox(width: 5),
                        Text(
                          '${venue.rating} (${venue.reviews} Reviews)',
                          style: AppDefaults.bodyTextStyle,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_walk,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${venue.distance} km/${venue.duration} min',
                          style: AppDefaults.bodyTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class VenueData {
  final String title;
  final String location;
  final double rating;
  final int reviews;
  final double distance;
  final int duration;
  final String imagePath;

  VenueData(this.title, this.location, this.rating, this.reviews, this.distance,
      this.duration, this.imagePath);
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet>
    with SingleTickerProviderStateMixin {
  RangeValues _priceRangeValues = const RangeValues(100, 5000);
  double _selectedRating = 4.5;
  List<String> _selectedCategories = ['All'];
  List<String> _selectedFacilities = ['All'];
  String _selectedGender = 'Both';

  void _resetFilters() {
    setState(() {
      _priceRangeValues = const RangeValues(100, 5000);
      _selectedRating = 4.5;
      _selectedCategories = ['All'];
      _selectedFacilities = ['All'];
      _selectedGender = 'Both';
    });
  }

  late AnimationController _controller;
  late Animation<double> _animation;

  final FilterData _filterData = FilterData();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    setState(() {
      _filterData.reset();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _applyFilters() {
    // Here you can handle the applied filter data, e.g., send it to an API or update the UI
    print("Applied Filters: ${_filterData.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'All',
      'Football',
      'Basketball',
      'Cricket',
      'Badminton'
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text('Filter',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 48), // for alignment
              ],
            ),
            const SizedBox(height: 20),
            Text('Category',
                style: AppDefaults.titleHeadlineStyle
                    .copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: categories.map((category) {
                bool isSelected = _selectedCategories.contains(category);
                return FilterChip(
                  label: Text(category),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  selectedColor: Colors.black,
                  backgroundColor: Colors.white,
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedCategories.add(category);
                      } else {
                        _selectedCategories.remove(category);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text('Price Range',
                style: AppDefaults.titleHeadlineStyle
                    .copyWith(fontWeight: FontWeight.w700)),
            RangeSlider(
              activeColor: AppColors.primary600,
              inactiveColor: AppColors.text900,
              values: _priceRangeValues,
              min: 100,
              max: 5000,
              labels: RangeLabels(
                '\$${_priceRangeValues.start.round()}',
                '\$${_priceRangeValues.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRangeValues = values;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                '\$100',
                '\$500',
                '\$1000',
                '\$1500',
                '\$3000',
                '\$5000'
              ]
                  .map((label) =>
                      Text(label, style: const TextStyle(color: Colors.white)))
                  .toList(),
            ),
            const SizedBox(height: AppDefaults.space),
            Text('Rating',
                style: AppDefaults.titleHeadlineStyle
                    .copyWith(fontWeight: FontWeight.w700)),
            ...[
              '4.5 and above',
              '4.0 - 4.5',
              '3.5 - 4.0',
              '3.0 - 3.5',
              '2.5 - 3.0'
            ].map((rating) => ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        5, (index) => SvgPicture.asset('icons/ic_star.svg')),
                  ),
                  title: Text(rating, style: AppDefaults.bodyTextStyle),
                  trailing: Radio<double>(
                    value: double.parse(rating.split(' ').first),
                    groupValue: _selectedRating,
                    onChanged: (value) {
                      setState(() {
                        _selectedRating = value!;
                      });
                    },
                  ),
                )),
            const SizedBox(height: 20),
            Text('Facilities', style: AppDefaults.bodyTitleTextStyle),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children:
                  ['All', 'Outdoor field', 'Locker', 'Shower', 'Equipment']
                      .map((facility) => ChoiceChip(
                            selectedColor: AppColors.secondary500,
                            label: Text(facility),
                            selected: _selectedFacilities.contains(facility),
                            onSelected: (selected) {
                              setState(() {
                                if (facility == 'All') {
                                  _selectedFacilities = ['All'];
                                } else {
                                  _selectedFacilities.remove('All');
                                  if (selected) {
                                    _selectedFacilities.add(facility);
                                  } else {
                                    _selectedFacilities.remove(facility);
                                  }
                                  if (_selectedFacilities.isEmpty) {
                                    _selectedFacilities = ['All'];
                                  }
                                }
                              });
                            },
                          ))
                      .toList(),
            ),
            const SizedBox(height: 20),
            Text('Gender', style: AppDefaults.bodyTitleTextStyle),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: ['Both', 'Male', 'Female']
                  .map((gender) => ChoiceChip(
                        selectedColor: AppColors.secondary500,
                        label: Text(gender),
                        selected: _selectedGender == gender,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedGender = gender;
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: Text(
                      'Reset Filter',
                      style: AppDefaults.buttonTextStyle,
                    ),
                    onPressed: () {
                      // Reset logic here
                      setState(() {
                        _resetFilters;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: Text('Apply', style: AppDefaults.buttonTextStyle),
                    onPressed: () {
                      // Apply filter logic here
                      Navigator.pop(context);
                    },
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

class FilterData {
  Set<String> selectedCategories = {};
  double priceRange = 3000;
  double selectedRating = 4.5;
  bool outdoorField = false;
  bool locker = false;
  bool shower = false;
  bool equipment = false;
  String gender = 'Both';

  void reset() {
    selectedCategories.clear();
    priceRange = 3000;
    selectedRating = 4.5;
    outdoorField = false;
    locker = false;
    shower = false;
    equipment = false;
    gender = 'Both';
  }

  @override
  String toString() {
    return 'Categories: $selectedCategories, Price Range: \$${priceRange.round()}, Rating: $selectedRating and above, Facilities: Outdoor Field: $outdoorField, Locker: $locker, Shower: $shower, Equipment: $equipment, Gender: $gender';
  }
}
