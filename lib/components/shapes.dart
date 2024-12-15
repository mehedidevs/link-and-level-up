import 'package:flutter/material.dart';

class Circular extends StatelessWidget {
  final Color color;

  const Circular({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15, // Set width
      height: 15, // Set height
      decoration: BoxDecoration(
        color: color, // Background color
        shape: BoxShape.circle, // Makes the container circular
        border: Border.all(color: color, width: 2), // Optional border
      ),
    );
  }
}
