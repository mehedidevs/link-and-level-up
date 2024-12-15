import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';


class CompleteProfileSection extends StatelessWidget {
  const CompleteProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background500,
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/banner%2FGroup%20625957.png?alt=media&token=c69ecd4f-f149-46cb-9cee-d716e29776c0',
                  // Replace with your image URL
                  width: 120, // Adjust the width as needed
                  height: 150, // Adjust the height as needed
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                // Match the image width
                height: 177,
                // Match the image height
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Text(
                  'Complete Athlete profile Creation',
                  style: AppDefaults.titleHeadlineStyle,
                ),
              ),
              Positioned(
                left: AppDefaults.padding,
                bottom: AppDefaults.padding * 2,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3CC4C4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Text(
                      'Start now',
                      style: AppDefaults.buttonTextStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
