import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';


class AddChildrenPage extends StatelessWidget {
  final Color iconColor =
      Colors.tealAccent;

  const AddChildrenPage({super.key}); // Change this to your preferred color

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Add Children', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildCustomTextFieldWithIcon(
                icon: Icons.person,
                hintText: 'Jacob Jones',
                labelText: 'Child Name',
                readOnly: true,
              ),
              const SizedBox(height: 24),
              const Text('Gender', style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 8),
              _buildCustomDropdownWithIcon(
                icon: Icons.male,
                value: 'Male',
                items: ['Male', 'Female'],
                onChanged: (value) {},
              ),
              const SizedBox(height: 24),
              const Text('Sports Interest',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 8),
              _buildCustomDropdownWithIcon(
                icon: Icons.sports_soccer,
                value: 'Soccer',
                items: ['Soccer', 'Basketball', 'Tennis'],
                onChanged: (value) {},
              ),
              const SizedBox(height: 24),
              const Text('Sports Levels',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 8),
              _buildCustomDropdownWithIcon(
                icon: Icons.bar_chart,
                value: 'Beginner',
                items: ['Beginner', 'Intermediate', 'Advanced'],
                onChanged: (value) {},
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle next action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary500,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: AppDefaults.buttonTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  // Custom TextField with Icon and Divider
  Widget _buildCustomTextFieldWithIcon({
    required IconData icon,
    required String hintText,
    required String labelText,
    bool readOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[800]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 8),
          Container(
            height: 24,
            width: 1,
            color: iconColor, // Vertical line color
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              readOnly: readOnly,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Custom Dropdown with Icon and Divider
  Widget _buildCustomDropdownWithIcon({
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[800]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 8),
          Container(
            height: 24,
            width: 1,
            color: iconColor, // Vertical line color
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                dropdownColor: Colors.grey[900],
                iconEnabledColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
