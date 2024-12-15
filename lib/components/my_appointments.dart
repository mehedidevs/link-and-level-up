import 'package:flutter/material.dart';

import '../config/app_colors.dart';


class MyAppointmentPage extends StatelessWidget {
  const MyAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('My Appointment', style: TextStyle(color: Colors.white)),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            // The color of the indicator
            indicatorSize: TabBarIndicatorSize.label,
            // Matches the indicator size to the label
            indicatorWeight: 0,
            // Removes the underline (set weight to 0)
            indicator: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(
                    color: Colors.white, width: 3), // Custom indicator
              ),
            ),
            labelColor: Colors.white,
            // Selected tab text color
            unselectedLabelColor: AppColors.textDark9,
            // Unselected tab text color

            tabs: [
              Tab(text: 'All(10)'),
              Tab(text: 'In Progress(4)'),
              Tab(text: 'Pending(6)'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AppointmentList(),
            AppointmentList(inProgressOnly: true),
            AppointmentList(pendingOnly: true),
          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class AppointmentList extends StatelessWidget {
  final bool inProgressOnly;
  final bool pendingOnly;

  const AppointmentList(
      {super.key, this.inProgressOnly = false, this.pendingOnly = false});

  @override
  Widget build(BuildContext context) {
    // Mock data
    List<Map<String, String>> appointments = [
      {
        'name': 'Mickael Whisper',
        'status': 'In Progress',
        'price': '150.00',
        'rating': '4.6'
      },
      {
        'name': 'Cameron Williamson',
        'status': 'Pending',
        'price': '150.00',
        'rating': '4.6'
      },
      {
        'name': 'Robert Fox',
        'status': 'In Progress',
        'price': '150.00',
        'rating': '4.6'
      },
      {
        'name': 'Leslie Alexander',
        'status': 'Pending',
        'price': '150.00',
        'rating': '4.6'
      },
    ];

    List<Map<String, String>> filteredAppointments =
        appointments.where((appointment) {
      if (inProgressOnly) {
        return appointment['status'] == 'In Progress';
      } else if (pendingOnly) {
        return appointment['status'] == 'Pending';
      }
      return true;
    }).toList();

    return ListView.builder(
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        return AppointmentCard(
          name: filteredAppointments[index]['name']!,
          status: filteredAppointments[index]['status']!,
          price: filteredAppointments[index]['price']!,
          rating: filteredAppointments[index]['rating']!,
        );
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String name;
  final String status;
  final String price;
  final String rating;

  const AppointmentCard({super.key, 
    required this.name,
    required this.status,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'In Progress' ? Colors.blue : Colors.orange;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background500,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
                  // Replace with your image URL
                  width: 40, // Set the width of the image
                  height: 40, // Set the height of the image
                  fit:
                      BoxFit.cover, // Ensure the image covers the entire circle
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  const Text('Trainer', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                      color: statusColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Pulse Football Center', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey),
              SizedBox(width: 8),
              Text('New York, USA', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('\$$price /month', style: const TextStyle(color: Colors.amber)),
              const Spacer(),
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 4),
              Text(rating, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
