import 'package:flutter/material.dart';
import 'package:link_level_up/features/tariner/trainer_home.dart';

import '../../config/app_defaults.dart';

class TrainerRequest extends StatelessWidget {
  const TrainerRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Athlete Request', style: AppDefaults.otpTextStyle),
          ),
          const AthleteRequestCard(
            id: 'Jhony Dep',
            name: 'Jhony Dep',
            message:
                'There are many variations of passages of Lorem Ipsum available, but the majority...',
            location: 'Green Valley, Hill road, NY',
            isToday: true,
          ),
          const AthleteRequestCard(
            id: 'Jhony Dep',
            name: 'Jhon Doe',
            message:
                'There are many variations of passages of Lorem Ipsum available, but the majority...',
            location: 'Green Valley, Hill road, NY',
            isToday: false,
            date: '11th Mar',
          ),
      
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 32),
            child: Text('Facility Request', style: AppDefaults.otpTextStyle),
          ),
          const AthleteRequestCard(
            id: 'Jhony Dep',
            name: 'Jhony Dep',
            message:
            'There are many variations of passages of Lorem Ipsum available, but the majority...',
            location: 'Green Valley, Hill road, NY',
            isToday: true,
          ),
          const AthleteRequestCard(
            id: 'Jhony Dep',
            name: 'Jhon Doe',
            message:
            'There are many variations of passages of Lorem Ipsum available, but the majority...',
            location: 'Green Valley, Hill road, NY',
            isToday: false,
            date: '11th Mar',
          ),
          const AthleteRequestCard(
            id: 'Jhony Dep',
            name: 'Jhon Doe',
            message:
            'There are many variations of passages of Lorem Ipsum available, but the majority...',
            location: 'Green Valley, Hill road, NY',
            isToday: false,
            date: '11th Mar',
          ),
        ],
      ),
    );
  }
}
