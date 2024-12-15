import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';

class EditTrainerExperienceList extends StatefulWidget {
  const EditTrainerExperienceList({super.key});

  @override
  State<EditTrainerExperienceList> createState() => _EditTrainerProfileState();
}

class _EditTrainerProfileState extends State<EditTrainerExperienceList> {
  @override
  Widget build(BuildContext context) {
    return const EditTrainerDetailsScreen();
  }
}

class EditTrainerDetailsScreen extends StatefulWidget {
  const EditTrainerDetailsScreen({super.key});

  @override
  _EditTrainerDetailsScreenState createState() =>
      _EditTrainerDetailsScreenState();
}

class _EditTrainerDetailsScreenState extends State<EditTrainerDetailsScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController roadController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  void updateProfile() {
    // Collecting all data
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String hourlyRate = hourlyRateController.text;
    String about = aboutController.text;
    String road = roadController.text;
    String zipCode = zipCodeController.text;

    // Debugging output for data (You can replace this with API calls or database save logic)
    print('First Name: $firstName');
    print('Last Name: $lastName');
    print('Hourly Rate: $hourlyRate');

    print('Road: $road');
    print('Zip Code: $zipCode');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          title: const Text('Edit Experience'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button action
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          // Disable inner scrolling to avoid conflict
          padding: const EdgeInsets.all(16),
          children: [
            InfoSection(
              infoList: [
                InfoItem(
                  title: 'Head Coach',
                  institution: 'Prime Sports Academy',
                  period: 'Mar 2022 - Present',
                ),
                InfoItem(
                  title: 'Assistant Coach',
                  institution: 'Elite Sports Club',
                  period: 'Jan 2019 - Feb 2022',
                ),
              ],
              onEdit: () {
                Navigator.pushNamed(context, AppRoutes.EditTrainerExperience);
                print('Edit Experience button clicked');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Generic class to hold info data (works for both education and experience)
class InfoItem {
  final String title;
  final String institution;
  final String period;

  InfoItem({
    required this.title,
    required this.institution,
    required this.period,
  });
}

// Generic InfoSection for both Education and Experience
class InfoSection extends StatelessWidget {
  final List<InfoItem>
      infoList; // List of info data (e.g., education or experience)

  final Function onEdit; // Dynamic edit button function

  const InfoSection({
    super.key,
    required this.infoList,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row with dynamic add and edit icons

          // Dynamic list of info entries (education/experience)
          ...infoList.map((info) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Render title only if it's not empty
                  if (info.title.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          info.title,
                          style: AppDefaults.textWhite600,
                        ),
                        GestureDetector(
                          onTap: () {
                            onEdit();
                          },
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  SvgPicture.asset('icons/ic_edit_circle.svg')),
                        )
                      ],
                    ),

                  // Render institution only if it's not empty
                  if (info.institution.isNotEmpty)
                    Text(
                      info.institution,
                      style: AppDefaults.textWhite12_400,
                    ),

                  // Render period only if it's not empty
                  if (info.period.isNotEmpty)
                    Text(
                      info.period,
                      style: AppDefaults.titleStyleSmall,
                    ),
                  if (infoList.last != info) const Divider()
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
