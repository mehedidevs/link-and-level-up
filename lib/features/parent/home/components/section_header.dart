
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';


class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppDefaults.titleHeadlineStyle,
          ),
          TextButton(
            onPressed: () {},
            child: Text('See all' , style: GoogleFonts.inter(
              color: AppColors.primary500
            ),),
          ),
        ],
      ),
    );
  }
}