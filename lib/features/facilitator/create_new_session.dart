import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';

class CreateNewSessionPage extends StatelessWidget {
  const CreateNewSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Create new session',
            style: TextStyle(color: Colors.white)),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicInfoSection(),
              SizedBox(height: 24),
              WorkingHoursSection(),
              SizedBox(height: 24),
              AddressSection(),
              SizedBox(height: 24),
              ConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Basic Info',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Session Name*',
            hintText: 'Write your session name here',
            hintStyle: const TextStyle(color: Colors.grey),
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[800]!),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary500),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Description',
            hintText: 'Write your description here...',
            hintStyle: const TextStyle(color: Colors.grey),
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary300),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary300),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
        ),
      ],
    );
  }
}

class WorkingHoursSection extends StatelessWidget {
  const WorkingHoursSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Working Hours',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        WorkingHourItem(day: 'Mon'),
        WorkingHourItem(day: 'Tue'),
        WorkingHourItem(day: 'Wed'),
        WorkingHourItem(day: 'Thu'),
        WorkingHourItem(day: 'Fri'),
        WorkingHourItem(day: 'Sat', isAvailable: false),
        WorkingHourItem(day: 'Sun', isAvailable: false),
      ],
    );
  }
}

class WorkingHourItem extends StatefulWidget {
  final String day;
  final bool isAvailable;

  const WorkingHourItem(
      {super.key, required this.day, this.isAvailable = true});

  @override
  _WorkingHourItemState createState() => _WorkingHourItemState();
}

class _WorkingHourItemState extends State<WorkingHourItem> {
  bool isAvailable = true;
  String? fromTime;
  String? toTime;

  @override
  void initState() {
    super.initState();
    isAvailable = widget.isAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Switch(
            value: isAvailable,
            onChanged: (value) {
              setState(() {
                isAvailable = value;
              });
            },
            activeColor: Colors.tealAccent,
          ),
          const SizedBox(width: 8),
          Text(widget.day, style: const TextStyle(color: Colors.white)),
          if (isAvailable) ...[
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'From',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                items: getTimeDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    fromTime = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'To',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                items: getTimeDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    toTime = value;
                  });
                },
              ),
            ),
          ] else
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child:
                    Text('Not Available', style: TextStyle(color: Colors.grey)),
              ),
            ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getTimeDropdownItems() {
    List<String> times = [
      '06:00 AM',
      '07:00 AM',
      '08:00 AM',
      '09:00 AM',
      '10:00 AM',
      '11:00 AM',
      '12:00 PM',
      '01:00 PM',
      '02:00 PM',
      '03:00 PM',
      '04:00 PM',
      '05:00 PM',
      '06:00 PM',
      '07:00 PM',
      '08:00 PM'
    ];
    return times.map((time) {
      return DropdownMenuItem<String>(
        value: time,
        child: Text(time),
      );
    }).toList();
  }
}

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Address',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {},
              child: const Text('View on map',
                  style: TextStyle(color: AppColors.primary500)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.location_on, color: Colors.grey),
            SizedBox(width: 8),
            Text('Green Valley, Hill road, NY',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[900],
          ),
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(40.7128, -74.0060),
              zoom: 12,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('session_location'),
                position: const LatLng(40.7128, -74.0060),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure),
              ),
            },
          ),
        ),
      ],
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary500,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Confirm',
          style: AppDefaults.buttonTextStyle,
        ),
      ),
    );
  }
}
