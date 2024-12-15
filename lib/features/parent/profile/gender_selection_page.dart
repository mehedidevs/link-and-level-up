import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';
import '../../athlete/profile/components/app_bar.dart';

class GenderSelectionPage extends StatefulWidget {
  const GenderSelectionPage({super.key});

  @override
  State<GenderSelectionPage> createState() => _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<GenderSelectionPage> {
  String? selectedGender;
  String male = 'Male';
  String female = 'Female';

  @override
  Widget build(BuildContext context) {
    double pageNumber = 1;

    return SafeArea(
      child: Scaffold(
        appBar: ProgressiveAppBar(pageNumber: pageNumber),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDefaults.padding * 2,
                        vertical: AppDefaults.padding),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Tell us about yourself',
                            style: AppDefaults.titleHeadlineStyle,
                          ),
                        ),
                        const SizedBox(height: AppDefaults.space),
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'To give you a better experience we need to know your gender',
                            style: AppDefaults.titleStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDefaults.space),
                  GenderButton(
                    icon: Icons.male,
                    gender: male,
                    isSelected: selectedGender == male,
                    onPressed: () => setState(() => selectedGender = male),
                  ),
                  const SizedBox(
                    height: AppDefaults.space,
                  ),
                  GenderButton(
                    icon: Icons.female,
                    gender: female,
                    isSelected: selectedGender == female,
                    onPressed: () => setState(() => selectedGender = female),
                  ),
                  const SizedBox(height: AppDefaults.space),
                ],
              ),
              Positioned(
                  right: AppDefaults.space,
                  left: AppDefaults.space,
                  bottom: AppDefaults.space,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.AgeSelectionPage);
                    },
                    child: Text(
                      'Select Gender',
                      style: AppDefaults.buttonTextStyle,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String gender;
  final bool isSelected;
  final VoidCallback onPressed;
  final IconData icon;

  const GenderButton({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(AppDefaults.padding * 2),
        backgroundColor:
            isSelected ? AppColors.secondary500 : Colors.transparent,
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(icon, size: 48),
          Text(
            gender,
            style: AppDefaults.bodyTextStyle,
          ),
        ],
      ),
    );
  }
}
