import 'package:flutter/material.dart';


import '../../../../components/CheckBoxWithText.dart';
import '../../../../components/CustomDatePickerInputField.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../parent/profile/components/app_bar.dart';
import '../../../tariner/components/CustomEditField.dart';

class AddTrainerExperiencePage extends StatefulWidget {
  const AddTrainerExperiencePage({super.key});

  @override
  _AgeSelectionPageState createState() => _AgeSelectionPageState();
}

class _AgeSelectionPageState extends State<AddTrainerExperiencePage> {
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

  double pageNumber = 2;

  // Controllers for the form fields
  final TextEditingController designationController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProgressiveAppBar(
          pageNumber: pageNumber,
          totalProgressivePage: 4,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppDefaults.space, horizontal: AppDefaults.space),
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
                        'Add your experience',
                        style: AppDefaults.titleHeadlineStyle,
                      ),
                      const SizedBox(height: AppDefaults.space),
                      Text(
                        'This helps others to know you better',
                        style: AppDefaults.titleStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppDefaults.space),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CustomDesignationField(
                              label: 'Designation',
                              hintText: 'Head Trainer',
                              controller: designationController,
                              color: Colors.white,
                            ),
                            const SizedBox(height: AppDefaults.space),
                            CustomDesignationField(
                              label: 'Company Name',
                              hintText: 'Abc.com',
                              controller: companyController,
                              color: Colors.white,
                            ),
                            const SizedBox(height: AppDefaults.space),
                            CustomCheckboxWithText(
                              text: 'I am Currently Working Here',
                              initialValue: false,
                              onChanged: (bool value) {
                                // Perform action when the checkbox is checked or unchecked
                              },
                            ),
                            const SizedBox(height: AppDefaults.space),
                            CustomDatePickerField(
                              label: 'Start Date*',
                              controller: startDateController,
                              color: Colors.red,
                            ),
                            const SizedBox(height: AppDefaults.space),
                            CustomDatePickerField(
                              label: 'End Date*',
                              controller: endDateController,
                              color: Colors.red,
                            ),
                            const SizedBox(height: AppDefaults.space),
                            CustomDesignationField(
                              label: 'Job Type',
                              hintText: 'Full Time',
                              controller: jobTypeController,
                              color: Colors.red,
                            ),
                          ],
                        ),
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
                            context, AppRoutes.AddTrainerCertificatePage);
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
