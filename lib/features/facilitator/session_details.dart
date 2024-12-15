import 'package:flutter/material.dart';

import '../../config/app_colors.dart';


class SessionDetailsPage extends StatelessWidget {
  const SessionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Session Details', style: TextStyle(color: Colors.white)),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SessionHeader(),
              SizedBox(height: 24),
              SessionBookedBy(),
              SizedBox(height: 24),
              SessionDetails(),
              SizedBox(height: 24),
              SessionTrainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SessionHeader extends StatelessWidget {
  const SessionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.background500,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            children: [
              Text('20',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              Text('May', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Football Goal Keeping Session',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(
                  'There are many variations of passages of Lorem Ipsum available, but the majority...',
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text('Session Ends In: 49:25 minute',
                  style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}

class SessionBookedBy extends StatelessWidget {
  const SessionBookedBy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Session Book By',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 12),
        Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
                // Replace with your image URL
                width: 70, // Set the width of the image
                height: 70, // Set the height of the image
                fit: BoxFit.cover, // Ensure the image covers the entire circle
              ),
            ),
            const SizedBox(width: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Athlete', style: TextStyle(color: Colors.grey)),
                Text('Mickael whisper',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.message),
                label: const Text('Message'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background900,
                  foregroundColor: AppColors.primary300,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.call),
                label: const Text('Call'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background900,
                  foregroundColor: AppColors.primary300,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SessionDetails extends StatelessWidget {
  const SessionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Details', style: TextStyle(color: Colors.white, fontSize: 18)),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.calendar_today, color: AppColors.primary500),
            SizedBox(width: 8),
            Text('20th May, 2024 | 05:00 PM - 06:00 PM',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, color: AppColors.primary500),
            SizedBox(width: 8),
            Expanded(
              child: Text('Ark Sports Club, Herison Road, NY, 71005363',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}

class SessionTrainer extends StatelessWidget {
  const SessionTrainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Session Trainer',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 12),
        Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
                // Replace with your image URL
                width: 70, // Set the width of the image
                height: 70, // Set the height of the image
                fit: BoxFit
                    .cover, // Ensure the image covers the entire circle
              ),
            ),
            const SizedBox(width: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trainer', style: TextStyle(color: Colors.grey)),
                Text('Jhony Dep',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.message),
                label: const Text('Message'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background900,
                  foregroundColor: AppColors.primary300,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.call),
                label: const Text('Call'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background900,
                  foregroundColor: AppColors.primary300,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
