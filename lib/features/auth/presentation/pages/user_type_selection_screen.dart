import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';


class UserTypeSelectionScreen extends StatelessWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: UserTypeSelectionBody()),
    );
  }
}

class UserTypeSelectionBody extends StatefulWidget {
  const UserTypeSelectionBody({super.key});

  @override
  _UserTypeSelectionBodyState createState() => _UserTypeSelectionBodyState();
}

class _UserTypeSelectionBodyState extends State<UserTypeSelectionBody> {
  UserType? _selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Select User Type',
          textAlign: TextAlign.center,
          style: AppDefaults.bodyTitleTextStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'To give you a better experience we need to know your type',
            style: AppDefaults.bodyTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        UserTypeGrid(
          selectedUserType: _selectedUserType,
          onUserTypeSelected: (UserType? userType) {
            setState(() {
              _selectedUserType = userType;
            });
          },
        ),
        const SizedBox(height: AppDefaults.space),
        Container(
          padding: const EdgeInsets.all(AppDefaults.padding),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedUserType == null
                ? null
                : () {
                    if (_selectedUserType == UserType.Trainer) {
                      Navigator.pushNamed(
                          context, AppRoutes.AddTrainerWorkingHourPage);
                    } else if (_selectedUserType == UserType.Parent) {
                      Navigator.pushNamed(
                          context, AppRoutes.ChildrenSelectionPage);
                    } else if (_selectedUserType == UserType.Athlete) {
                      Navigator.pushNamed(
                          context, AppRoutes.GenderSelectionPage);
                    }
                  },
            child: const Text('Next'),
          ),
        )
      ],
    );
  }
}

class UserTypeGrid extends StatelessWidget {
  final UserType? selectedUserType;
  final Function(UserType?) onUserTypeSelected;

  const UserTypeGrid({
    super.key,
    required this.selectedUserType,
    required this.onUserTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: UserType.values.map((userType) {
          return UserTypeCard(
            userType: userType,
            isSelected: selectedUserType == userType,
            onTap: () => onUserTypeSelected(userType),
          );
        }).toList(),
      ),
    );
  }
}

class UserTypeCard extends StatelessWidget {
  final UserType userType;
  final bool isSelected;
  final VoidCallback onTap;

  const UserTypeCard({
    super.key,
    required this.userType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    color: isSelected
                        ? AppColors.secondary500
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppDefaults.padding,
                          right: AppDefaults.padding,
                          top: AppDefaults.padding,
                          bottom: 0),
                      child: Image.asset(
                        userType.assetPath,
                        // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4), // Space for the overlapping icon
                Text(
                  userType.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 45, // Adjust this value to control the overlap
            child: isSelected
                ? const CircleAvatar(
                    backgroundColor: AppColors.secondary500,
                    radius: 15,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 25,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

enum UserType {
  Athlete,
  Trainer,
  Parent,
  Facilitator,
}

extension UserTypeExtension on UserType {
  String get label {
    switch (this) {
      case UserType.Athlete:
        return 'Athlete';
      case UserType.Trainer:
        return 'Trainer';
      case UserType.Parent:
        return 'Parent';
      case UserType.Facilitator:
        return 'Facilitator';
    }
  }

  String get assetPath {
    switch (this) {
      case UserType.Athlete:
        return 'icons/ic_athlete.png';
      case UserType.Trainer:
        return 'icons/ic_trainer.png';
      case UserType.Parent:
        return 'icons/ic_parent.png';
      case UserType.Facilitator:
        return 'icons/ic_facilitator.png';
    }
  }
}
