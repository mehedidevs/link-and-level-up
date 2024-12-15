import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_defaults.dart';


// Class to hold date and time
class WorkingHour {
  final String day;
  final String time;

  WorkingHour({required this.day, required this.time});
}

class WorkingHourSection extends StatelessWidget {
  final List<WorkingHour> workingHoursList = [
    WorkingHour(day: 'Monday', time: '10:00 - 12:00'),
    WorkingHour(day: 'Tuesday', time: '10:00 - 12:00'),
    WorkingHour(day: 'Wednesday', time: '10:00 - 12:00'),
    WorkingHour(day: 'Thursday', time: '10:00 - 12:00'),
    WorkingHour(day: 'Friday', time: '10:00 - 12:00'),
    WorkingHour(day: 'Saturday', time: '10:00 - 12:00'),
    WorkingHour(day: 'Sunday', time: '10:00 - 12:00'),
  ];

   WorkingHourSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text('Working Hours', style: AppDefaults.bodyTitleTextStyle),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Divider(),
        ),
        const SizedBox(height: AppDefaults.space / 2),
        Container(
          padding: const EdgeInsets.all(16.0),
          color: AppColors.background500,
          child: ListView.builder(
            shrinkWrap: true,  // Fixes the layout issue by constraining the ListView height
            physics: const NeverScrollableScrollPhysics(), // Prevents ListView from being scrollable within another scrollable widget
            itemCount: workingHoursList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      workingHoursList[index].day,
                      style: AppDefaults.bodyTextStyle,
                    ),
                    Text(
                      workingHoursList[index].time,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

