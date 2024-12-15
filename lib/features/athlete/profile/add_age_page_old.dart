import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/keys.dart';
import '../../../db/secure_storage_service.dart';
import '../../parent/profile/components/app_bar.dart';

class AgeSelectionPage extends StatefulWidget {
  const AgeSelectionPage({super.key});

  @override
  _AgeSelectionPageState createState() => _AgeSelectionPageState();
}

class _AgeSelectionPageState extends State<AgeSelectionPage> {
  int selectedAge = 30; // Middle value for the 1-100 range
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(
        initialItem: selectedAge - 1); // Adjusting for 0 index
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSelectedAgeTap() {
    // Handle tap on selected age
    print('Selected age: $selectedAge');
  }

  Color getColorForAge(int age) {
    final distance = (age - selectedAge).abs();
    if (distance == 0) {
      return Colors.amber;
    } else if (distance == 1) {
      return Colors.amberAccent.withOpacity(0.7);
    } else if (distance == 2) {
      return Colors.white.withOpacity(0.5);
    } else if (distance == 3) {
      return Colors.white.withOpacity(0.3);
    } else {
      return Colors.white.withOpacity(0.15);
    }
  }

  double pageNumber = 2;

  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width / 2;

    return SafeArea(
      child: Scaffold(
        appBar: ProgressiveAppBar(pageNumber: pageNumber),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            children: [
              Text(
                'How Old Are You?',
                style: AppDefaults.titleHeadlineStyle,
              ),
              const SizedBox(height: AppDefaults.space),
              Text(
                'This helps us create your personalized preference',
                style: AppDefaults.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              const Expanded(
                child: Stack(
                  children: [AgePicker()],
                ),
              ),
              const SizedBox(height: AppDefaults.space),
              Container(
                padding: const EdgeInsets.all(AppDefaults.padding),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle age selection
                    var storage = SecureStorageService();
                    storage.saveInt(ageInt, selectedAge);

                    Navigator.pushNamed(context, AppRoutes.WeightSelectionPage);
                  },
                  child: Text(
                    'Add Age',
                    style: AppDefaults.buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddAgeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddAgeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary500,
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: onPressed,
        child: const Text('Add Age'),
      ),
    );
  }
}

class AgePicker extends StatefulWidget {
  const AgePicker({super.key});

  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  int selectedAge = 55; // Default middle value
  final int minAge = 10;
  final int maxAge = 100;

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen size and adapt the UI accordingly
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text size and padding based on screen width, reduced padding for compact design

        SizedBox(height: screenHeight * 0.02),
        // Reduced height
        Stack(
          alignment: Alignment.center,
          children: [
            // ListWheelScrollView for the age selection
            SizedBox(
              height: screenHeight * 0.25, // Reduced height for compact view
              child: ListWheelScrollView.useDelegate(
                itemExtent: screenHeight * 0.06,
                // Compact item height
                physics: const FixedExtentScrollPhysics(),
                diameterRatio: 1.2,
                controller: FixedExtentScrollController(
                  initialItem: selectedAge - minAge, // Set initial selected age
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedAge =
                        index + minAge; // Updates selected age dynamically
                  });
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    if (index < 0 || index > (maxAge - minAge)) {
                      return null;
                    }
                    int age = index + minAge;
                    return Center(
                      child: Text(
                        age.toString(),
                        style: TextStyle(
                          color:
                              selectedAge == age ? Colors.amber : Colors.grey,
                          fontSize: selectedAge == age
                              ? screenWidth *
                                  0.06 // Smaller size for selected text
                              : screenWidth * 0.045,
                          // More compact size for non-selected
                          fontWeight: selectedAge == age
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  childCount: maxAge - minAge + 1, // Number of ages in the list
                ),
              ),
            ),
            // Top and Bottom lines for selected age, half of the screen width
            Positioned(
              top: screenHeight * 0.1, // Reduced vertical space for lines
              left: screenWidth * 0.25, // Half the screen width
              right: screenWidth * 0.25, // Half the screen width
              child: Container(
                height: 2,
                color: Colors.amber,
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.1, // Reduced vertical space for lines
              left: screenWidth * 0.25, // Half the screen width
              right: screenWidth * 0.25, // Half the screen width
              child: Container(
                height: 2,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
