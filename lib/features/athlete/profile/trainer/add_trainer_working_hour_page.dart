import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../dummy.dart';
import '../../../../test_app.dart';
import '../../../parent/profile/components/app_bar.dart';

class AddTrainerWorkingHourPage extends StatefulWidget {
  const AddTrainerWorkingHourPage({super.key});

  @override
  _AgeSelectionPageState createState() => _AgeSelectionPageState();
}

class _AgeSelectionPageState extends State<AddTrainerWorkingHourPage> {
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

  double pageNumber = 1;
  List<TimeSlot> apiTimeSlots = [
    TimeSlot(day: 'Monday'),
    TimeSlot(day: 'Tuesday'),
    TimeSlot(day: 'Wednesday'),
    TimeSlot(day: 'Thursday'),
    TimeSlot(day: 'Friday'),
    TimeSlot(day: 'Saturday'),
    TimeSlot(day: 'Sunday'),
  ];
  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width / 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: ProgressiveAppBar(
          pageNumber: pageNumber,
          totalProgressivePage: 4,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical:  AppDefaults.space, horizontal: AppDefaults.space),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 65,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Fixed your working \n hour & hourly rate',
                        style: AppDefaults.titleHeadlineStyle,
                      ),
                      const SizedBox(height: AppDefaults.space),
                      Text(
                        'To give you a better experience we need to know your hourly rate & working hour',
                        style: AppDefaults.titleStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppDefaults.space),
                      HourlyRatePicker(
                        initialCurrency: 'USD',
                        initialRate: '20.00',
                        onChanged: (String selectedCurrency, String rate) {
                          // Callback when currency or rate changes
                          print(
                              'Selected Currency: $selectedCurrency, Rate: $rate');
                        },
                      ),
                      const SizedBox(height: AppDefaults.space),
                      TimeSlotSelector(
                        initialTimeSlots: apiTimeSlots,
                        onTimeSlotChanged: (updatedTimeSlots) {
                          print('Time slots updated: $updatedTimeSlots');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle age selection
                        Navigator.pushNamed(
                            context, AppRoutes.AddTrainerExperiencePage);
                      },
                      child: Text(
                        'Next',
                        style: AppDefaults.buttonTextStyle,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


