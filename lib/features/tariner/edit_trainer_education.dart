import 'package:flutter/material.dart';


import '../../components/CheckBoxWithText.dart';
import '../../components/CustomDatePickerInputField.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';
import 'components/CustomEditField.dart';

class EditTrainerEducation extends StatefulWidget {
  const EditTrainerEducation({super.key});

  @override
  _ScrollableFormPageState createState() => _ScrollableFormPageState();
}

class _ScrollableFormPageState extends State<EditTrainerEducation> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process data or submit the form
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submitted Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Education'),
        ),
        body: Stack(
          children: [
            // Scrollable Form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomDesignationField(
                    label: 'Course Name',
                    hintText: 'Head Trainer',
                    controller: nameController,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppDefaults.space),
                  CustomDesignationField(
                    label: 'Organization Name',
                    hintText: 'Abc.com',
                    controller: nameController,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppDefaults.space),
                  CustomCheckboxWithText(
                    text: 'Current Student',
                    initialValue: false,
                    onChanged: (bool value) {
                      // Perform action when the checkbox is checked or unchecked
                    },
                  ),
                  const SizedBox(height: AppDefaults.space),
                  CustomDatePickerField(
                    label: 'Start Date*',
                    controller: dateController,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppDefaults.space),
                  CustomDatePickerField(
                    label: 'End Date*',
                    controller: dateController,
                    color: Colors.white,
                  ),
                  const SizedBox(height: AppDefaults.space),
                ],
              ),
            ),
            // Floating Submit Button
            Positioned(
              bottom: 16.0,
              right: 16.0,
              left: 16.0,
              child: ElevatedButton(
                onPressed: () {
                  print('Designation: ${nameController.text}');
                  print('Position: ${nameController.text}');
                  Navigator.popAndPushNamed(context, AppRoutes.TrainerMain);
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
