import 'package:flutter/material.dart';
import 'package:link_level_up/features/tariner/trainer_home.dart';

import '../../config/app_defaults.dart';

class TrainerSession extends StatelessWidget {
  const TrainerSession({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Upcoming Session', style: AppDefaults.otpTextStyle),
              ],
            ),
          ),
          const SessionCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),
          const SessionCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),
          const SessionCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),

          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Upcoming Session', style: AppDefaults.otpTextStyle),
              ],
            ),
          ),
          const SessionCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),
          const SessionCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),
          const SessionCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),
          const SessionCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),
          const SessionCard(
            title: 'Basketball Workout Training',
            location: 'Green Valley, Hill road, NY',
            date: '14th Apr',
            time: '04pm-05pm',
          ),
          // Add more SessionCard widgets as needed
        ],
      ),
    );
  }
}
