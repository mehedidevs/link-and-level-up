import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';


class AthleteSearchBar extends StatelessWidget {
  const AthleteSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: SizedBox(
        height: 48, // Adjust height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 18,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.background22, // Dark gray background
                  borderRadius: BorderRadius.circular(
                      10), // Slightly curved corners
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 16),
                    // Spacing for left margin
                    Icon(Icons.search, color: Colors.white),
                    // Magnifying glass icon
                    SizedBox(width: 8),
                    // Spacing between icon and text
                    Text(
                      'Search trainer, facilitator',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            // Push menu button to the right
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                height: 48,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background22, // Dark gray background
                  borderRadius: BorderRadius.circular(
                      10), // Slightly curved corners
                ),
                child: SvgPicture.asset(
                  'icons/menu_icon.svg',
                ),
              ),
            ),
            const SizedBox(width: 4),
            // Spacing for right margin
          ],
        ),
      ),
    );
  }
}
