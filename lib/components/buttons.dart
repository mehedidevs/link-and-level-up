import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_colors.dart';
import '../config/app_defaults.dart';


class MoreDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double borderRadius;

  const MoreDetailsButton({
    super.key,
    required this.onPressed,
    this.width = 85,
    this.height = 30,
    this.borderRadius = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.background400,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: Text(
              'More Details',
              style: AppDefaults.buttonTextStyleSmall,
            ),
          ),
        ),
      ),
    );
  }
}

class RejectButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double borderRadius;

  const RejectButton({
    super.key,
    required this.onPressed,
    this.width = 150,
    this.height = 50,
    this.borderRadius = 25,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.red,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AcceptButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double width;
  final double height;
  final double borderRadius;

  const AcceptButton({
    super.key,
    required this.onPressed,
    this.width = 150,
    this.height = 50,
    this.borderRadius = 25,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddEventButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double width;
  final double height;
  final double borderRadius;

  const AddEventButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.width,
      required this.height,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding, vertical: AppDefaults.padding / 2),
        // Padding inside button
        decoration: BoxDecoration(
          color: const Color(0xFF4EC5C1), // Button color
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // To keep the button compact
          children: [
            SvgPicture.asset('icons/ic_plus_circle.svg'), // Icon
            const SizedBox(width: 4), // Space between icon and text
            Text(
              'Add Event',
              style: AppDefaults.buttonTextStyleSmall, // Text style
            ),
          ],
        ),
      ),
    );
  }
}
