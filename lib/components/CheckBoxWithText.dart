
import 'package:flutter/material.dart';

class CustomCheckboxWithText extends StatefulWidget {
  final String text;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomCheckboxWithText({
    super.key,
    required this.text,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  _CustomCheckboxWithTextState createState() => _CustomCheckboxWithTextState();
}

class _CustomCheckboxWithTextState extends State<CustomCheckboxWithText> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    // Initialize the checkbox state based on the initial value provided
    isChecked = widget.initialValue;
  }

  // Function to programmatically check the checkbox
  void check() {
    setState(() {
      isChecked = true;
    });
    widget.onChanged(isChecked);
  }

  // Function to programmatically uncheck the checkbox
  void uncheck() {
    setState(() {
      isChecked = false;
    });
    widget.onChanged(isChecked);
  }

  // Function to toggle the checkbox state
  void toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onChanged(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
            widget.onChanged(isChecked);
          },
        ),
        GestureDetector(
          onTap: () {
            toggleCheckbox(); // Toggle checkbox when the text is tapped
          },
          child: Text(widget.text),
        ),
      ],
    );
  }
}
