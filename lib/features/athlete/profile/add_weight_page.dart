import 'package:flutter/material.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/keys.dart';
import '../../../db/secure_storage_service.dart';
import 'components/app_bar.dart';

class WeightSelectionPage extends StatefulWidget {
  const WeightSelectionPage({super.key});

  @override
  _WeightSelectionPageState createState() => _WeightSelectionPageState();
}

class _WeightSelectionPageState extends State<WeightSelectionPage> {
  double selectedWeight = 10.0; // Default weight
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(
        initialItem: 20); // Adjust for starting weight
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSelectedWeight(dynamic val) {
    setState(() {
      selectedWeight = val as double; // Cast dynamic to double
      print('Selected weight: $selectedWeight');
    });
  }

  double pageNumber = 3;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: ProgressiveAppBar(pageNumber: pageNumber),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    'What’s your Weight',
                    style: AppDefaults.titleHeadlineStyle,
                  ),
                  const SizedBox(height: AppDefaults.space),
                  Text(
                    'This helps us create your personal preferable plan',
                    style: AppDefaults.titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight / 6),
                  Center(
                    // Center the entire Column vertically and horizontally
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Added some extra space between the text and the slider
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedWeight.toStringAsFixed(1),
                              style: AppDefaults.primaryHeadline,
                            ),
                            Text(
                              ' kg',
                              style: AppDefaults.titleSeeAll,
                            )
                          ],
                        ),
                        const SizedBox(height: AppDefaults.space),
                        WheelSlider(
                          pointerColor: Colors.amberAccent,
                          lineColor: Colors.amber,
                          interval: 0.5,
                          totalCount: 500,
                          initValue: selectedWeight,
                          onValueChanged: onSelectedWeight,
                          // This will now accept dynamic
                          hapticFeedbackType: HapticFeedbackType.vibrate,
                          pointerHeight: 300,
                        ),
                      ],
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
                    // Handle weight selection confirmation
                    var storage = SecureStorageService();
                    storage.saveDouble(weightDouble, selectedWeight);

                    Navigator.pushNamed(context, AppRoutes.HeightSelectionPage);
                  },
                  child: Text(
                    'Add Weight',
                    style: AppDefaults.buttonTextStyle,
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
