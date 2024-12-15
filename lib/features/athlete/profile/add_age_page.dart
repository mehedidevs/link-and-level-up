import 'package:flutter/material.dart';


class AgePickerApp extends StatelessWidget {
  const AgePickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: AgePicker(),
        ),
      ),
    );
  }
}

class AgePicker extends StatefulWidget {
  const AgePicker({super.key});

  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  int selectedAge = 55; // Default middle value
  final int minAge = 10;
  final int maxAge = 100;

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen size and adapt the UI accordingly
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text size and padding based on screen width, reduced padding for compact design
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
          child: Text(
            "How Old Are You?",
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.06, // Slightly smaller text
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Text(
            "This helps us create your personalized preference",
            style: TextStyle(
              color: Colors.grey,
              fontSize: screenWidth * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: screenHeight * 0.02), // Reduced height
        Stack(
          alignment: Alignment.center,
          children: [
            // ListWheelScrollView for the age selection
            SizedBox(
              height: screenHeight * 0.25, // Reduced height for compact view
              child: ListWheelScrollView.useDelegate(
                itemExtent: screenHeight * 0.06, // Compact item height
                physics: const FixedExtentScrollPhysics(),
                diameterRatio: 1.2,
                controller: FixedExtentScrollController(
                  initialItem: selectedAge - minAge, // Set initial selected age
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedAge = index + minAge; // Updates selected age dynamically
                  });
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    if (index < 0 || index > (maxAge - minAge)) {
                      return null;
                    }
                    int age = index + minAge;
                    return Center(
                      child: Text(
                        age.toString(),
                        style: TextStyle(
                          color: selectedAge == age ? Colors.amber : Colors.grey,
                          fontSize: selectedAge == age
                              ? screenWidth * 0.06 // Smaller size for selected text
                              : screenWidth * 0.045, // More compact size for non-selected
                          fontWeight: selectedAge == age
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  childCount: maxAge - minAge + 1, // Number of ages in the list
                ),
              ),
            ),
            // Top and Bottom lines for selected age, half of the screen width
            Positioned(
              top: screenHeight * 0.1, // Reduced vertical space for lines
              left: screenWidth * 0.25, // Half the screen width
              right: screenWidth * 0.25, // Half the screen width
              child: Container(
                height: 2,
                color: Colors.amber,
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.1, // Reduced vertical space for lines
              left: screenWidth * 0.25, // Half the screen width
              right: screenWidth * 0.25, // Half the screen width
              child: Container(
                height: 2,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
