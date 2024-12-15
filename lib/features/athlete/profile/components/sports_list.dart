import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/keys.dart';
import '../../../../db/secure_storage_service.dart';

class SportsList extends StatefulWidget {
  const SportsList({super.key});

  @override
  _SportsListState createState() => _SportsListState();
}

class _SportsListState extends State<SportsList> {
  List<SportsSelection> sports = [
    SportsSelection(
      'Soccer',
      'icons/ic_soccer.png',
    ),
    SportsSelection(
      'Rugby Sevens',
      'icons/ic_rugby.png',
    ),
    SportsSelection(
      'Basketball',
      'icons/ic_basketball.png',
    ),
    SportsSelection(
      'Badminton',
      'icons/ic_badminton.png',
    ),
    SportsSelection(
      'Tennis',
      'icons/ic_tennis.png',
    ),
    SportsSelection(
      'Cricket',
      'icons/ic_cricket.png',
    )
  ];

  String? selectedSport;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: sports.length,
          itemBuilder: (context, index) {
            return Card(
              shape: selectedSport == sports[index].title
                  ? RoundedRectangleBorder(
                      side: const BorderSide(
                          color: AppColors.primary50, width: 1),
                      borderRadius: BorderRadius.circular(AppDefaults.radius))
                  : null,
              color: AppColors.background700,
              child: ListTile(
                leading: selectedSport == sports[index].title
                    ? SvgPicture.asset('icons/ic_check_circle.svg')
                    : const Icon(Icons.circle_outlined,
                        color: AppColors.placeholder),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      sports[index].imageIcon,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: AppDefaults.padding,
                    ),
                    Text(
                      sports[index].title,
                      style: AppDefaults.bodyTextStyle,
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    selectedSport = sports[index].title;
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
                var storage = SecureStorageService();
                storage.saveString(sportInterestString, selectedSport.toString());

                Navigator.pushNamed(context, AppRoutes.LevelSelectionPage);
              },
              child: Text(
                'Choose',
                style: AppDefaults.buttonTextStyle,
              ),
            ))
      ],
    );
  }
}

class SportsSelection {
  String title;
  String imageIcon;

  SportsSelection(this.title, this.imageIcon);
}
