import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';


class TrainerInfoSection extends StatelessWidget {
  const TrainerInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Using InfoSection for Education
        InfoSection(
          title: 'Education',
          infoList: [
            InfoItem(
              title: 'Diploma In Athlete',
              institution: 'Sports Institute Toronto',
              period: '2015 - 2019',
            ),
            InfoItem(
              title: 'Assistant Trainer',
              institution: 'Ark Sports Club - Full Time',
              period: 'Jan 2020 - Mar 2022',
            ),
          ],
          onAdd: () {
            Navigator.pushNamed(context, AppRoutes.EditTrainerEducationList);
            print('Add Education button clicked');
          },
          onEdit: () {
            Navigator.pushNamed(context, AppRoutes.EditTrainerEducationList);
            print('Edit Education button clicked');
          },
        ),
        // Divider to separate sections
        const Divider(
          color: Colors.white,
          height: 1.0,
        ),
        // Using InfoSection for Experience
        InfoSection(
          title: 'Experience',
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
          onAdd: () {
            Navigator.pushNamed(context, AppRoutes.EditTrainerExperienceList);
            print('Add Experience button clicked');
          },
          onEdit: () {
            Navigator.pushNamed(context, AppRoutes.EditTrainerExperienceList);
            print('Edit Experience button clicked');
          },
        ),
      ],
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
  final String title; // Section title (e.g., Education, Experience)
  final List<InfoItem>
      infoList; // List of info data (e.g., education or experience)
  final Function onAdd; // Dynamic add button function
  final Function onEdit; // Dynamic edit button function

  const InfoSection({
    super.key,
    required this.title,
    required this.infoList,
    required this.onAdd,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppDefaults.sectionTitleTextStyle,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      onAdd();
                    },
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset('icons/ic_add_circle.svg')),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      onEdit();
                    },
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset('icons/ic_edit_circle.svg')),
                  ),
                ],
              ),
            ],
          ),
          // Dynamic list of info entries (education/experience)
          ...infoList.map((info) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Render title only if it's not empty
                  if (info.title.isNotEmpty)
                    Text(
                      info.title,
                      style: AppDefaults.textWhite600,
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
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
