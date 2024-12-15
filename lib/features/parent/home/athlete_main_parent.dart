import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../config/app_colors.dart';
import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';
import '../../athlete/home/Athlete_explore.dart';
import '../../athlete/home/athelete_favorite.dart';
import '../../athlete/home/athlete_home.dart';
import '../../facilitator/facilitator_main.dart';
import '../../tariner/trainer_community_screen.dart';
import 'athlete_profile_parent.dart';

class AthleteMainPageParent extends StatefulWidget {
  const AthleteMainPageParent({super.key});

  @override
  State<AthleteMainPageParent> createState() => _AthleteMainPageState();
}

class _AthleteMainPageState extends State<AthleteMainPageParent> {
  var currentIndex = 0;
  List<BottomBarData> listOfIcons = [
    BottomBarData(iconData: 'icons/ic_home.svg', title: 'Home'),
    BottomBarData(iconData: 'icons/ic_favorite.svg', title: 'Favorite'),
    BottomBarData(iconData: 'icons/ic_menu_community.svg', title: 'Community'),
    BottomBarData(iconData: 'icons/ic_explore.svg', title: 'Explore'),
    BottomBarData(iconData: 'icons/ic_profile.svg', title: 'Profile'),
  ];

  List<Widget> pages = [
    const AthleteHomePage(),
    const AthleteFavorite(),
    const TrainerCommunityScreen(),
    const AthleteExplore(),
    const AthleteProfileParent()
  ];

  List<String> appTitles = [
    'Home',
    'Favorite',
    'Community',
    'Explore',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //icons/menu_icon.svg
          leading: Builder(
            builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset("icons/menu_icon.svg")),
                )),
          ),

          backgroundColor: AppColors.scaffoldBackground,
          title: Row(
            children: [
              SvgPicture.asset('icons/ic_location.svg'),
              Text(
                "Ny, Usa",
                style: AppDefaults.bodyTextStyle,
              )
            ],
          ),
          actions: [
            const SizedBox(
              width: 4,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.NotificationsScreen);
              },
              child: SvgPicture.asset('icons/ic_notification.svg'),
            ),
            const SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.AthleteMessage);
              },
              child: const MessageIconWithBadge(badgeCount: 5),
            ),
          ],
        ),
        body: pages[currentIndex],
        drawer: const CustomDrawer(),
        bottomNavigationBar: _bottomBar(size),
      ),
    );
  }

  _bottomBar(Size size) {
    return Container(
      width: size.width, // Full width of the screen
      height: size.width * .180, // Adjust height as needed
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackground,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
        // Adjust padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(listOfIcons.length, (index) {
            return Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      margin: EdgeInsets.only(
                        bottom: index == currentIndex ? 0 : size.width * .02,
                      ),
                      width: size.width * .05,
                      height: index == currentIndex ? size.width * .015 : 0,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? AppColors.primary200
                            : Colors.transparent,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      listOfIcons[index].iconData,
                      height: 24, // Set a fixed height for icons
                      colorFilter: ColorFilter.mode(
                          index == currentIndex
                              ? AppColors.primary100
                              : AppColors.text600,
                          BlendMode.srcIn),
                    ),
                    const SizedBox(height: 4), // Add a small spacing
                    Text(
                      listOfIcons[index].title,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: index == currentIndex
                            ? AppColors.primary200
                            : AppColors.text600,
                      ),
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class BottomBarData {
  final String iconData;
  final String title;

  BottomBarData({required this.iconData, required this.title});
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.background500, // Dark background color
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  ClipOval(
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
                      // Replace with your image URL
                      width: 70, // Set the width of the image
                      height: 70, // Set the height of the image
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire circle
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Mickael W.',
                    style: AppDefaults.titleHeadlineStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppDefaults.space * 2,
            ),
            DrawerItem(
              icon: 'icons/menu_profile.svg',
              text: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.AthleteProfileDetails);
              },
            ),
            DrawerItem(
              icon: 'icons/menu_appointment.svg',
              text: 'My Appointment',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.MyAppointmentPage);
              },
            ),
          /*  DrawerItem(
              icon: 'icons/menu_workout.svg',
              text: 'My Workout',
              onTap: () {},
            ),*/
            DrawerItem(
              icon: 'icons/menu_payment.svg',
              text: 'Payment Method',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.PaymentMethod);
              },
            ),
            DrawerItem(
              icon: 'icons/menu_settings.svg',
              text: 'Setting',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.SettingsPage);
              },
            ),
            DrawerItem(
              icon: 'icons/menu_help_center.svg',
              text: 'Help Center',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.AthleteHelpCenter);
              },
            ),
            DrawerItem(
              icon: 'icons/menu_privacy.svg',
              text: 'Privacy Policy',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.PrivacyPolicyScreen);
              },
            ),
            DrawerItem(
              icon: 'icons/ic_briefcase.svg',
              text: 'Logout',
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.login,
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;

  const DrawerItem(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: Text(text, style: AppDefaults.menuTextStyle),
      onTap: onTap,
    );
  }
}
