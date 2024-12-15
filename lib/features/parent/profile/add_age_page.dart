import 'package:flutter/material.dart';

import '../../../config/app_defaults.dart';
import '../../../config/routes/app_routes.dart';
import 'components/app_bar.dart';

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
              Expanded(
                child: Stack(
                  children: [
                    ListWheelScrollView.useDelegate(
                      controller: _controller,
                      itemExtent: 60,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedAge = 100 - index;
                        });
                      },
                      perspective: 0.003,
                      physics: const FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          final age = 100 - index;
                          final color = getColorForAge(age);
                          final isSelected = age == selectedAge;
                          return Center(
                            child: GestureDetector(
                              onTap: isSelected ? onSelectedAgeTap : null,
                              child: Text(
                                age.toString(),
                                style: TextStyle(
                                  color: color,
                                  fontSize: 32,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: 100,
                      ),
                    ),
                    Positioned(
                      top: 170,
                      left: halfScreenWidth / 2,
                      right: halfScreenWidth / 2,
                      child: Container(
                        height: 2,
                        color: Colors.amber,
                      ),
                    ),
                    Positioned(
                      top: 220,
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
                padding: const EdgeInsets.all(AppDefaults.padding),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle age selection
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
