import 'package:flutter/material.dart';


import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../tariner/components/working_hour_section.dart';

class FacilitatorDetailsPage extends StatelessWidget {
  const FacilitatorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: const TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
      ),
      home: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const BackButton()),
          title: const Text('Edit Facilitator Details'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader('Basic Info'),
                const BasicInfoSection(),
                const SectionHeader('Facilities'),
                const FacilitiesSection(),
                const SectionHeader('Select Trainer'),
                const TrainerSection(),
                const SectionHeader('Working Hours'),
                WorkingHourSection(),
                const SectionHeader('Gallery'),
                const GallerySection(),
                const SectionHeader('Address'),
                const AddressSection(),
              ],
            ),
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
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledTextField(label: 'Facility Name*'),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomDropdown(
                label: 'Currency',
                items: ['USD', 'EUR', 'GBP', 'JPY', 'AUD'],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: LabeledTextField(label: 'Hourly Rate'),
            ),
          ],
        ),
        SizedBox(height: 16),
        LabeledTextField(label: 'Established in*'),
        SizedBox(height: 16),
        LabeledTextField(label: 'Professionals Resources*'),
      ],
    );
  }
}

class LabeledTextField extends StatelessWidget {
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
}

class CustomDropdown extends StatelessWidget {
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
}

class FacilitiesSection extends StatelessWidget {
  const FacilitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FacilityChip(label: 'Washroom'),
        FacilityChip(label: 'Car parking'),
        FacilityChip(label: 'Wifi'),
        FacilityChip(label: 'Locker'),
        FacilityChip(label: 'Shower'),
      ],
    );
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
