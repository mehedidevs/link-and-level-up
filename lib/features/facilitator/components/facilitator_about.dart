
import 'package:flutter/material.dart';

class FacilitatorAbout extends StatelessWidget {
  const FacilitatorAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'There are many variations of passages of Lorem Ipsum available, '
                  'but the majority have suffered alteration in some form, by injected humour,',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Playground Owner',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Replace with actual image URL
                  radius: 30,
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jhony Deep',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Owner',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.message, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Facilities',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                FacilityIcon(label: 'Car park', icon: Icons.directions_car),
                FacilityIcon(label: 'Washroom', icon: Icons.chat_bubble),
                FacilityIcon(label: 'Shower', icon: Icons.chat_bubble),
                FacilityIcon(label: 'Locker', icon: Icons.chat_bubble),
                FacilityIcon(label: 'Wi-Fi', icon: Icons.chat_bubble),
                FacilityIcon(label: 'Washroom', icon: Icons.chat_bubble),
                FacilityIcon(label: 'Shower', icon: Icons.chat_bubble),
                FacilityIcon(label: 'Locker', icon: Icons.chat_bubble),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Address',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.place, color: Colors.white),
                const SizedBox(width: 8),
                const Text(
                  'Green Valley, Hill road, NY',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View on map',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://via.placeholder.com/400'), // Replace with actual map image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FacilityIcon extends StatelessWidget {
  final String label;
  final IconData icon;

  const FacilityIcon({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[800],
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}