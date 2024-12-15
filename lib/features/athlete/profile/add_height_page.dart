import 'package:flutter/material.dart';


import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/keys.dart';
import '../../../db/secure_storage_service.dart';
import 'components/app_bar.dart';

class HeightSelectionPage extends StatefulWidget {
  const HeightSelectionPage({super.key});

  @override
  _HeightSelectionPageState createState() => _HeightSelectionPageState();
}

class _HeightSelectionPageState extends State<HeightSelectionPage> {
  int selectedHeight = 100; // Middle value for the 1-100 range
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        FixedExtentScrollController(initialItem: 400); // Adjusting for 0 index
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSelectedAgeTap() {
    // Handle tap on selected age
    print('Selected weight: $selectedHeight');
  }

  Color getColorForAge(int age) {
    final distance = (age - selectedHeight).abs();
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

  double pageNumber = 4;

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
                'What’s your Height',
                style: AppDefaults.titleHeadlineStyle,
              ),
              const SizedBox(height: AppDefaults.space),
              Text(
                'This helps us create your personal preferable plan',
                style: AppDefaults.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Stack(
                  children: [
                    ListWheelScrollView.useDelegate(
                      controller: _controller,
                      itemExtent: 60,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedHeight = 500 - index;
                        });
                      },
                      perspective: 0.003,
                      physics: const FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          final age = 500 - index;
                          final color = getColorForAge(age);
                          final isSelected = age == selectedHeight;
                          return Center(
                            child: GestureDetector(
                              onTap: isSelected ? onSelectedAgeTap : null,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: age.toString(),
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 32,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    if (isSelected)
                                      TextSpan(
                                        text: " cm",
                                        style: TextStyle(
                                          color: color,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: 500,
                      ),
                    ),
                    Positioned(
                      top: 165,
                      left: halfScreenWidth / 2,
                      right: halfScreenWidth / 2,
                      child: Container(
                        height: 2,
                        color: Colors.amber,
                      ),
                    ),
                    Positioned(
                      top: 230,
                      left: halfScreenWidth / 2,
                      right: halfScreenWidth / 2,
                      child: Container(
                        height: 2,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDefaults.space),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDefaults.space),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle age selection
                    var storage = SecureStorageService();
                    storage.saveDouble(heightDouble, selectedHeight.toDouble());

                    Navigator.pushNamed(context, AppRoutes.SportsSelectionPage);
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
