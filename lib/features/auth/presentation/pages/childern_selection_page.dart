import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/app_icons.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../athlete/profile/components/app_bar.dart';

class ChildrenSelectionPage extends StatefulWidget {
  const ChildrenSelectionPage({super.key});

  @override
  State<ChildrenSelectionPage> createState() => _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<ChildrenSelectionPage> {
  String? selectedGender;
  String male = 'Male';
  String female = 'Female';
  final _userChildrenController = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: AppDefaults.space * 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GenderButton(
                        svgIcon: 'icons/ic_male.svg',
                        gender: male,
                        isSelected: selectedGender == male,
                        onPressed: () => setState(() => selectedGender = male),
                      ),
                      GenderButton(
                        svgIcon: 'icons/ic_female.svg',
                        gender: female,
                        isSelected: selectedGender == female,
                        onPressed: () =>
                            setState(() => selectedGender = female),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDefaults.space*2),
                  const Text(
                    "Children Name",
                    style: TextStyle(
                        color: AppColors.text100,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  TextFormField(
                    controller: _userChildrenController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background700,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDefaults.radius),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter Children Name',
                      hintStyle: const TextStyle(color: AppColors.text700),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: AppDefaults.space),
                          Image.asset(
                            AppIcons.person,
                            color: AppColors.secondary500,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: AppDefaults.space),
                          Container(
                            width: 1,
                            height: AppDefaults.space,
                            color: AppColors.secondary500,
                          ),
                          const SizedBox(width: AppDefaults.space),
                        ],
                      ),
                    ),
                  ),
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
  final String svgIcon;

  const GenderButton({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onPressed,
    required this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(AppDefaults.padding * 2),
        backgroundColor:
            isSelected ? AppColors.childSelect : AppColors.childUnselect,
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          SvgPicture.asset(svgIcon),
          Text(
            gender,
            style: AppDefaults.bodyTextStyle,
          ),
        ],
      ),
    );
  }
}
