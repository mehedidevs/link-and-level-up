import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';


class SportsLevelList extends StatefulWidget {
  const SportsLevelList({super.key});

  @override
  _SportsListState createState() => _SportsListState();
}

class _SportsListState extends State<SportsLevelList> {
  List<String> sports = ['Beginner', 'Intermediate', 'Advance'];

  String? selectedSport;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: sports.length,
          itemBuilder: (context, index) {
            return Card(
              shape: selectedSport == sports[index]
                  ? RoundedRectangleBorder(
                      side: const BorderSide(
                          color: AppColors.primary50, width: 1),
                      borderRadius: BorderRadius.circular(AppDefaults.radius))
                  : null,
              color: AppColors.background700,
              child: ListTile(
                leading: selectedSport == sports[index]
                    ? SvgPicture.asset('icons/ic_check_circle.svg')
                    : const Icon(Icons.circle_outlined,
                        color: AppColors.placeholder),
                title: Text(
                  sports[index],
                  style: AppDefaults.bodyTextStyle,
                ),
                onTap: () {
                  setState(() {
                    selectedSport = sports[index];
                  });
                },
              ),
            );
          },
        ),
        Positioned(
            bottom: AppDefaults.space,
            left: AppDefaults.space,
            right: AppDefaults.space,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.AddLocationPage);
              },
              child: Text(
                'Select',
                style: AppDefaults.buttonTextStyle,
              ),
            ))
      ],
    );
  }
}
