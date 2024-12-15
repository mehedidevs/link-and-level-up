import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Notifications', style: TextStyle(color: Colors.white)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text('2 New', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSection('TODAY', [
            _buildNotificationItem('Trainee appointment booked', '1h'),
            _buildNotificationItem('Reschedule Request', '1h'),
            _buildNotificationItem('Cancelation Request', '1h'),
          ]),
          _buildSection('YESTERDAY', [
            _buildNotificationItem('Feedback Expected', '1h'),
            _buildNotificationItem('Trainee Requested', '1h'),
            _buildNotificationItem('Confirmation Request', '1h'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const Text('Mark all as read',
                  style: TextStyle(color: Colors.orange, fontSize: 14)),
            ],
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildNotificationItem(String title, String time) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[800],
        child: SvgPicture.asset('icons/ic_briefcase.svg'),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: const Text(
        'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form...',
        style: TextStyle(color: Colors.grey),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(time, style: const TextStyle(color: Colors.grey)),
    );
  }
}
