import 'package:flutter/material.dart';


import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../test_app.dart';

class EditTrainerProfile extends StatefulWidget {
  const EditTrainerProfile({super.key});

  @override
  State<EditTrainerProfile> createState() => _EditTrainerProfileState();
}

class _EditTrainerProfileState extends State<EditTrainerProfile> {
  @override
  Widget build(BuildContext context) {
    return const EditTrainerDetailsScreen();
  }
}

class EditTrainerDetailsScreen extends StatefulWidget {
  const EditTrainerDetailsScreen({super.key});

  @override
  _EditTrainerDetailsScreenState createState() =>
      _EditTrainerDetailsScreenState();
}

class _EditTrainerDetailsScreenState extends State<EditTrainerDetailsScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController roadController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  List<TimeSlot> apiTimeSlots = [
    TimeSlot(day: 'Monday'),
    TimeSlot(day: 'Tuesday'),
    TimeSlot(day: 'Wednesday'),
    TimeSlot(day: 'Thursday'),
    TimeSlot(day: 'Friday'),
    TimeSlot(day: 'Saturday'),
    TimeSlot(day: 'Sunday'),
  ];

  String selectedCity = 'Newyork';

  void updateProfile() {
    // Collecting all data
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String hourlyRate = hourlyRateController.text;
    String about = aboutController.text;
    String road = roadController.text;
    String zipCode = zipCodeController.text;

    // Debugging output for data (You can replace this with API calls or database save logic)
    print('First Name: $firstName');
    print('Last Name: $lastName');
    print('Hourly Rate: $hourlyRate');
    print('About: $about');
    print('City: $selectedCity');
    print('Road: $road');
    print('Zip Code: $zipCode');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          title: const Text('Edit Trainer Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button action
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          // Disable inner scrolling to avoid conflict
          padding: const EdgeInsets.all(16),
          children: [
            const ProfileSection(),
            const SizedBox(height: 20),
            BasicInfoSection(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              hourlyRateController: hourlyRateController,
              aboutController: aboutController,
            ),
            const SizedBox(height: 20),
            TimeSlotSelector(
              initialTimeSlots: apiTimeSlots,
              onTimeSlotChanged: (updatedTimeSlots) {
                print('Time slots updated: $updatedTimeSlots');
              },
            ),
            const SizedBox(height: 20),
            LocationSection(
              selectedCity: selectedCity,
              roadController: roadController,
              zipCodeController: zipCodeController,
              onCityChanged: (city) {
                setState(() {
                  selectedCity = city!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateProfile,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
            width: 80, // Set the width of the image
            height: 80, // Set the height of the image
            fit: BoxFit.cover, // Ensure the image covers the entire circle
          ),
        ),
        const SizedBox(width:8),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 4, right: 24, top: 24, bottom: 24),
            child: OutlinedButton(
              onPressed: () {
                // Handle photo change action
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                minimumSize: const Size(40, 36), // Small, compact size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: const BorderSide(color: Colors.grey), // Outline color
              ),
              child: Text(
                'Change photo',
                style: AppDefaults.buttonTextStyle.copyWith(fontSize: 12), // Smaller font size
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class BasicInfoSection extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController hourlyRateController;
  final TextEditingController aboutController;

  const BasicInfoSection({super.key, 
    required this.firstNameController,
    required this.lastNameController,
    required this.hourlyRateController,
    required this.aboutController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Usage example:
        CustomInputField(
          label: 'Full Name',
          hintText: 'Enter your first name',
          controller: firstNameController,
          labelStyle: AppDefaults.menuTextStyle,
          inputStyle: AppDefaults.bodyTextStyle,
        ),
        const SizedBox(height: 10),

        CustomInputField(
          label: 'Last Name',
          hintText: 'Enter your last name',
          controller: firstNameController,
          labelStyle: AppDefaults.menuTextStyle,
          inputStyle: AppDefaults.bodyTextStyle,
        ),
        const SizedBox(height: 10),
        CustomInputField(
          label: 'Hourly Rate',
          hintText: 'Enter your hourly rate',
          controller: firstNameController,
          labelStyle: AppDefaults.menuTextStyle,
          inputStyle: AppDefaults.bodyTextStyle,
        ),

        const SizedBox(height: 10),
        CustomInputField(
          label: 'About',
          hintText: 'Describe yourself',
          controller: firstNameController,
          labelStyle: AppDefaults.menuTextStyle,
          inputStyle: AppDefaults.bodyTextStyle,
        ),
      ],
    );
  }
}

class LocationSection extends StatelessWidget {
  final String selectedCity;
  final TextEditingController roadController;
  final TextEditingController zipCodeController;
  final Function(String?) onCityChanged; // Updated to handle String?

  const LocationSection({super.key, 
    required this.selectedCity,
    required this.roadController,
    required this.zipCodeController,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          dropdownColor: AppColors.background600,
          decoration: const InputDecoration(
            labelText: 'City',
          ),
          value: selectedCity,
          items: ['Newyork', 'Los Angeles', 'Chicago'].map((String city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(
                city,
                style: AppDefaults.titleSeeAll,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            onCityChanged(newValue); // Corrected: Accepts String? now
          },
        ),
        const SizedBox(height: 10),
        CustomInputField(
          label: 'Road',
          hintText: 'Downtown',
          controller: roadController,
          labelStyle: AppDefaults.menuTextStyle,
          inputStyle: AppDefaults.bodyTextStyle,
        ),
        const SizedBox(height: 10),
        CustomInputField(
          label: 'Zip Code',
          hintText: 'Enter Zip Code',
          controller: zipCodeController,
          labelStyle: AppDefaults.menuTextStyle,
          inputStyle: AppDefaults.bodyTextStyle,
        ),
      ],
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextStyle labelStyle;
  final TextStyle inputStyle;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.labelStyle = const TextStyle(),
    this.inputStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle,
        ),
        const SizedBox(height: 8), // Add some spacing between label and input
        TextFormField(
          controller: controller,
          style: inputStyle,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.background600,
            hintStyle: AppDefaults.buttonTextStyleSmall,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
