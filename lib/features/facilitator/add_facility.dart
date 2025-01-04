import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_level_up/network/network_client.dart';

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
                onUploadComplete: (response) {
                  print('Upload complete: ${response.success}');
                },
                onUploadProgress: (progress) {
                  print('Upload progress: ${progress * 100}%');
                },
              ),
              const GallerySection(),
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

class BasicInfoSection extends StatelessWidget {
  BasicInfoSection({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabeledTextField(label: 'Facility Name*'),
        const SizedBox(height: 16),
        CurrencyInput(
          controller: currencyController,
          onChanged: (value) {
            print('Amount: $value');
          },
          onCurrencyChanged: (currency) {
            print('Selected currency: $currency');
          },
        ),
        const SizedBox(height: 16),
        const LabeledTextField(label: 'Established in*'),
        const SizedBox(height: 16),
        const LabeledTextField(label: 'Professionals Resources*'),
      ],
    );
  }
}

/*class LabeledTextField extends StatelessWidget {
  final String label;

  const LabeledTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.background600,
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary500),
        ),
      ),
    );
  }
}*/

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
                horizontal: 20.0,
                vertical: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
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

class CurrencyInput extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCurrencyChanged;

  const CurrencyInput({
    super.key,
    this.controller,
    this.onChanged,
    this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputFiledBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Currency Dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: 'USD',
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.gray,
              ),
              style: AppDefaults.titleStyleReview,
              dropdownColor: const Color(0xFF1C1C1E),
              items: ['USD', 'EUR', 'GBP', 'JPY'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null && onCurrencyChanged != null) {
                  onCurrencyChanged!(newValue);
                }
              },
            ),
          ),
          // Vertical Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '|',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 24.0,
              ),
            ),
          ),
          // Amount Input
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
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
                prefixText: '\$ ',
                prefixStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 20.0,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20.0,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;

  const CustomDropdown({super.key, required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      dropdownColor: Colors.grey[900],
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }
}*/

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

/*
class FacilitiesSelector extends StatefulWidget {
  final List<String> availableFacilities;
  final Function(List<String>) onFacilitiesChanged;

  const FacilitiesSelector({
    super.key,
    required this.availableFacilities,
    required this.onFacilitiesChanged,
  });

  @override
  _FacilitiesSelectorState createState() => _FacilitiesSelectorState();
}

class _FacilitiesSelectorState extends State<FacilitiesSelector> {
  List<String> selectedFacilities = [];

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
            color: AppColors.inputFiledBackground,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Enter your facilities here',
                  style: AppDefaults.hintStyle,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                ),
              ),
              dropdownColor: AppColors.inputFiledBackground,
              items: widget.availableFacilities
                  .where((facility) => !selectedFacilities.contains(facility))
                  .map((String facility) {
                return DropdownMenuItem<String>(
                  value: facility,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      facility,
                      style:AppDefaults.hintStyle,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedFacilities.add(newValue);
                  });
                  widget.onFacilitiesChanged(selectedFacilities);
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
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.inputFiledBackground,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: AppColors.selectedBorderColor,  // Border color
                  width: 1.0,          // Border width
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    facility,
                    style: AppDefaults.textWhite500,
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
}*/
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
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
              child: Text('Map Placeholder',
                  style: TextStyle(color: Colors.white))),
        ),
      ],
    );
  }
}
