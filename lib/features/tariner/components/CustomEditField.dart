import 'package:flutter/material.dart';

import '../../../config/app_defaults.dart';


class CustomDesignationField extends StatelessWidget {
  final String label;
  final String hintText;
  final Color color;

  final TextEditingController controller;

  const CustomDesignationField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller,
      required this.color});

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
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
