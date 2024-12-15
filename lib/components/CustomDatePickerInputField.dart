import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../config/app_defaults.dart';


class CustomDatePickerField extends StatelessWidget {
  final String label;
  final Color color;
  final TextEditingController controller;

  const CustomDatePickerField({super.key, 
    required this.label,
    required this.controller,
    required this.color,
  });

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Format the selected date
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      // Fill the TextFormField with the selected date
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: AppDefaults.bodyTextStyle,
            children: <TextSpan>[
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF14141F), // dark background color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Pick a date',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SvgPicture.asset(
                      'icons/ic_calendar.svg',
                      color: Colors.grey,
                    ),
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8), // Reduce height
              ),
              readOnly: true, // Disable text input, user can only pick a date
            ),
          ),
        ),
      ],
    );
  }
}
