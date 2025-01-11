import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:link_level_up/network/network_client.dart';

import '../../common/FullScreenMap.dart';
import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../core/file_uploader/image_upload_service.dart';
import '../../core/file_uploader/image_upload_widget.dart';
import '../tariner/components/working_hour_section.dart';
import 'components/BusinessHoursSelector.dart';
import 'components/MemberSelector.dart';

final TextEditingController currencyController = TextEditingController();

class AddFacilityPage extends StatefulWidget {
  const AddFacilityPage({super.key});

  @override
  State<AddFacilityPage> createState() => _AddFacilityPageState();
}

class _AddFacilityPageState extends State<AddFacilityPage> {
  NetworkClient networkClient = NetworkClient();

  @override
  Widget build(BuildContext context) {
    final List<String> facilities = [
      'Washroom',
      'Car parking',
      'Wifi',
      'Locker',
      'Shower',
    ];
    final List<Member> members = [
      const Member(
        name: 'Marvin McKinney',
        imageUrl:
            'https://images.squarespace-cdn.com/content/v1/5c5efdd601232cd65fe2086b/1617981399890-ZG98O5STN3C4SLB644E5/private%2Byoga%2Btherapy%2Bsmall.jpg',
      ),
      const Member(
        name: 'Albert Flores',
        imageUrl:
            'https://images.squarespace-cdn.com/content/v1/5c5efdd601232cd65fe2086b/1617981399890-ZG98O5STN3C4SLB644E5/private%2Byoga%2Btherapy%2Bsmall.jpg',
      ),
      const Member(
        name: 'Eleanor Pena',
        imageUrl:
            'https://images.squarespace-cdn.com/content/v1/5c5efdd601232cd65fe2086b/1617981399890-ZG98O5STN3C4SLB644E5/private%2Byoga%2Btherapy%2Bsmall.jpg',
      ),
      const Member(
        name: 'Leslie Alexander',
        imageUrl:
            'https://images.squarespace-cdn.com/content/v1/5c5efdd601232cd65fe2086b/1617981399890-ZG98O5STN3C4SLB644E5/private%2Byoga%2Btherapy%2Bsmall.jpg',
      ),
      const Member(
        name: 'Bessie Cooper',
        imageUrl:
            'https://images.squarespace-cdn.com/content/v1/5c5efdd601232cd65fe2086b/1617981399890-ZG98O5STN3C4SLB644E5/private%2Byoga%2Btherapy%2Bsmall.jpg',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const BackButton()),
        title: Text(
          'Edit Facilitator Details',
          style: AppDefaults.menuTextStyle,
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader('Basic Info'),
              BasicInfoSection(),
              // const SectionHeader('Facilities'),
              FacilitiesSelector(
                availableFacilities: facilities,
                onFacilitiesChanged: (selectedFacilities) {
                  print('Selected facilities: $selectedFacilities');
                },
              ),

              MemberSelector(
                availableMembers: members,
                onMembersChanged: (selectedMembers) {
                  print(
                      'Selected members: ${selectedMembers.map((m) => m.name).toList()}');
                },
              ),

              /*    const SectionHeader('Select Trainer'),
              const TrainerSection(),*/
              /*     const SectionHeader('Working Hours'),
              WorkingHourSection(),*/
              BusinessHoursSelector(
                onHoursChanged: (availableHours) {
                  print('Available Hours JSON:');
                  print({
                    "available_hours": availableHours,
                  });
                },
              ),

              const SectionHeader('Gallery'),
              ImageUploadWidget(
                uploadService: networkClient.service,
                endpoint: '/api/facilitator/add_img',
                additionalData: {'facility_id': '15'},
                onUploadComplete: (responses) {
                  for (var response in responses) {
                    print(
                        'Upload ${response.success ? 'succeeded' : 'failed'}: ${response.message}');
                  }
                },
                onUploadProgress: (progress) {
                  print(
                      'Overall upload progress: ${(progress * 100).toStringAsFixed(1)}%');
                },
              ),

              /*
              ImageUploadWidget(
                uploadService: networkClient.service,
                endpoint: '/api/facilitator/add_img',
                additionalData: {'facility_id': '15'},
                onUploadComplete: (response) {
                  print('Upload complete: ${response.success}');
                },
                onUploadProgress: (progress) {
                  print('Upload progress: ${progress * 100}%');
                },
              ),
              const GallerySection(),*/
              const SectionHeader('Address'),
              const AddressSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          title,
          style: AppDefaults.bodyTitleTextStyle,
        ));
  }
}

class BasicInfoSection extends StatefulWidget {
  BasicInfoSection({super.key});

  @override
  State<BasicInfoSection> createState() => _BasicInfoSectionState();
}

class _BasicInfoSectionState extends State<BasicInfoSection> {
  late Currency _selectedCurrency;

  @override
  void initState() {
    super.initState();
    _selectedCurrency = CurrencyData.currencies.first;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _facilityNamecontroller =
        TextEditingController();
    final TextEditingController _currencycontroller = TextEditingController();
    final TextEditingController _establishedController =
        TextEditingController();
    final TextEditingController _numberOfProfessionalController =
        TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledTextField(
          label: 'Facility Name',
          controller: _facilityNamecontroller,
        ),
        const SizedBox(height: 16),
        CurrencyInput(
          controller: _currencycontroller,
          selectedCurrencyCode: _selectedCurrency.code,
          onChanged: (value) {
            // Handle amount changes
            print('Amount changed: $value');
          },
          onCurrencyChanged: (currency) {
            setState(() {
              _selectedCurrency = currency;
            });
            print('Currency changed to: ${currency.code}');
          },
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Established in',
          controller: _establishedController,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Professionals Resources',
          controller: _numberOfProfessionalController,
        ),
      ],
    );
  }
}

class LabeledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String label;

  const LabeledTextField(
      {super.key, this.controller, this.onChanged, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with red asterisk
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: AppDefaults.bodyTextStyle,
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0), // Spacing between label and input field
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputFiledBackground,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: AppDefaults.bodyTextStyle,
            decoration: InputDecoration(
              hintText: 'Write facility name',
              hintStyle: AppDefaults.hintStyle,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}

// lib/models/currency.dart
class Currency {
  final String code;
  final String symbol;
  final String name;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
  });
}

// lib/data/currency_data.dart
class CurrencyData {
  static const List<Currency> currencies = [
    Currency(
      code: 'USD',
      symbol: '\$',
      name: 'US Dollar',
    ),
    Currency(
      code: 'EUR',
      symbol: '€',
      name: 'Euro',
    ),
    Currency(
      code: 'GBP',
      symbol: '£',
      name: 'British Pound',
    ),
    Currency(
      code: 'JPY',
      symbol: '¥',
      name: 'Japanese Yen',
    ),
    // Add more currencies as needed
  ];

  static Currency? findByCode(String code) {
    try {
      return currencies.firstWhere((currency) => currency.code == code);
    } catch (e) {
      return null;
    }
  }
}

// Updated CurrencyInput widget
class CurrencyInput extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<Currency>? onCurrencyChanged;
  final String selectedCurrencyCode;

  const CurrencyInput({
    super.key,
    this.controller,
    this.onChanged,
    this.onCurrencyChanged,
    required this.selectedCurrencyCode,
  });

  @override
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  late Currency _selectedCurrency;

  @override
  void initState() {
    super.initState();
    _selectedCurrency = CurrencyData.findByCode(widget.selectedCurrencyCode) ??
        CurrencyData.currencies.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputFiledBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCurrency.code,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.gray,
              ),
              style: AppDefaults.titleStyleReview,
              dropdownColor: const Color(0xFF1C1C1E),
              items: CurrencyData.currencies.map((Currency currency) {
                return DropdownMenuItem<String>(
                  value: currency.code,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(currency.code),
                      const SizedBox(width: 4),
                      Text(
                        currency.symbol,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  final newCurrency = CurrencyData.findByCode(newValue);
                  if (newCurrency != null) {
                    setState(() {
                      _selectedCurrency = newCurrency;
                    });
                    if (widget.onCurrencyChanged != null) {
                      widget.onCurrencyChanged!(newCurrency);
                    }
                  }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              '|',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 24.0,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 20.0,
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                hintText: '00.00',
                prefixText: '${_selectedCurrency.symbol} ',
                prefixStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 20.0,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20.0,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FacilitiesSelector extends StatefulWidget {
  final List<String> availableFacilities;
  final Function(List<String>) onFacilitiesChanged;

  const FacilitiesSelector({
    super.key,
    required this.availableFacilities,
    required this.onFacilitiesChanged,
  });

  @override
  FacilitiesSelectorState createState() => FacilitiesSelectorState();
}

class FacilitiesSelectorState extends State<FacilitiesSelector> {
  List<String> selectedFacilities = [];
  List<String> allFacilities = [];
  final TextEditingController customFacilityController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    allFacilities = List.from(widget.availableFacilities);
  }

  void showAddFacilityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1E),
          title: const Text(
            'Add New Facility',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: customFacilityController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter facility name',
              hintStyle: TextStyle(color: Colors.grey[600]),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey[600]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newFacility = customFacilityController.text.trim();
                if (newFacility.isNotEmpty) {
                  setState(() {
                    allFacilities.add(newFacility);
                    selectedFacilities.add(newFacility);
                  });
                  widget.onFacilitiesChanged(selectedFacilities);
                  customFacilityController.clear();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with red asterisk
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Facilities',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        // Dropdown container
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Enter your facilities here',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20.0,
                  ),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                ),
              ),
              dropdownColor: const Color(0xFF1C1C1E),
              items: [
                ...allFacilities
                    .where((facility) => !selectedFacilities.contains(facility))
                    .map((String facility) {
                  return DropdownMenuItem<String>(
                    value: facility,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        facility,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                // Add "Other" option
                DropdownMenuItem<String>(
                  value: 'other',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Other (Add new facility)',
                      style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  if (newValue == 'other') {
                    showAddFacilityDialog();
                  } else {
                    setState(() {
                      selectedFacilities.add(newValue);
                    });
                    widget.onFacilitiesChanged(selectedFacilities);
                  }
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        // Selected facilities chips
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: selectedFacilities.map((facility) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    facility,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFacilities.remove(facility);
                      });
                      widget.onFacilitiesChanged(selectedFacilities);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey[600],
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    customFacilityController.dispose();
    super.dispose();
  }
}


class FacilityChip extends StatelessWidget {
  final String label;

  const FacilityChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: AppDefaults.bodyTextStyle),
      backgroundColor: Colors.grey[800],
      deleteIcon: const Icon(Icons.close, size: 18, color: Colors.white),
      onDeleted: () {},
    );
  }
}

class TrainerSection extends StatelessWidget {
  const TrainerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        TrainerChip(name: 'Marvin McKinney'),
        TrainerChip(name: 'Albert Flores'),
        TrainerChip(name: 'Eleanor Pena'),
        TrainerChip(name: 'Leslie Alexander'),
        TrainerChip(name: 'Bessie Cooper'),
      ],
    );
  }
}

class TrainerChip extends StatelessWidget {
  final String name;

  const TrainerChip({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: ClipRRect(
        borderRadius: BorderRadius.circular(AppDefaults.radius),
        child: Image.network(
          "https://www.thimble.com/wp-content/uploads/2022/05/Personal-Trainer-Salary-Guide-1200x800.jpg",
          // Replace with your image URL
          width: 18, // Set the width of the image
          height: 18, // Set the height of the image
          fit: BoxFit.cover, // Ensure the image covers the entire circle
        ),
      ),
      label: Text(name, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.grey[800],
      deleteIcon: const Icon(Icons.close, size: 18, color: Colors.white),
      onDeleted: () {},
    );
  }
}

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_photo_alternate, size: 40, color: Colors.white),
          Text(
            'Click to upload\nmax. 800x400px',
            style:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Text('Green Valley, Hill road, NY',
                style: TextStyle(color: Colors.white)),
            Spacer(),
            Text('View on map', style: TextStyle(color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 16),
        LocationPicker(
          onLocationSelected: (LatLng, String) {

          },
        ),
      ],
    );
  }
}

class LocationPicker extends StatefulWidget {
  final Function(LatLng, String) onLocationSelected;

  const LocationPicker({
    Key? key,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController? mapController;
  LatLng _selectedLocation = const LatLng(-6.2088, 106.8456);
  String _address = 'Fetching address...';
  BitmapDescriptor? customMarker;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeMarker();
    // Get initial address after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAddress(_selectedLocation);
    });
  }

  Future<void> _initializeMarker() async {
    customMarker = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    setState(() {});
  }

  Future<void> _fetchAddress(LatLng position) async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _selectedLocation = position;
      _address = 'Fetching address...';
    });

    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: 'en', // Force English locale
      );

      if (!mounted) return;

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final List<String?> addressParts = [
          place.name,
          place.street,
          place.subLocality,
          place.locality,
          place.postalCode,
          place.country,
        ].where((part) => part != null && part.isNotEmpty).toList();

        final String formattedAddress = addressParts.join(', ');

        setState(() {
          _address = formattedAddress;
          _isLoading = false;
        });

        widget.onLocationSelected(_selectedLocation, formattedAddress);

        // Debug print
        print('Successfully fetched address: $formattedAddress');
        print('Raw placemark data: $place');
      } else {
        throw Exception('No address found');
      }
    } catch (e) {
      print('Error fetching address: $e'); // Debug print
      if (mounted) {
        setState(() {
          _address = 'Address not found. Coordinates: (${position.latitude.toStringAsFixed(4)}, '
              '${position.longitude.toStringAsFixed(4)})';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (customMarker == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('selected_location'),
                      position: _selectedLocation,
                      icon: customMarker!,
                      draggable: true,
                      onDragEnd: (newPosition) {
                        _fetchAddress(newPosition);
                      },
                    ),
                  },
                  onTap: _fetchAddress,
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.1),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenMap(
                            initialLocation: _selectedLocation,
                            customMarker: customMarker!,
                            onLocationSelected: (newPosition) {
                              _fetchAddress(newPosition);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('View on Map'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Location Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  if (_isLoading) ...[
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade600),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Coordinates:\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    TextSpan(
                      text: 'Lat: ${_selectedLocation.latitude.toStringAsFixed(6)}\n'
                          'Lng: ${_selectedLocation.longitude.toStringAsFixed(6)}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Address:\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    TextSpan(
                      text: _address,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


