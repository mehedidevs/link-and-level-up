import 'package:flutter/material.dart';




class BadgeWidget extends StatelessWidget {
  final String imageUrl;
  final int level;
  final double size; // Dynamic size input

  const BadgeWidget({super.key, 
    required this.imageUrl,
    required this.level,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    double borderWidth = size * 0.05; // Border width is 5% of the total size
    double iconSize = size * 0.12; // Icon size is 12% of the total size
    double textSize = size * 0.14; // Text size is 14% of the total size
    double bannerHeight = size * 0.2; // Banner height is 20% of the total size

    return Stack(
      alignment: Alignment.center,
      children: [
        // Circular Image with border
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.teal, // Border color
              width: borderWidth, // Dynamic border width
            ),
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl, // Use the dynamic URL here
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red);
              },
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
          ),
        ),

        // Positioned Level banner
        Positioned(
          bottom: -10,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size * 0.15, // Padding is 20% of the size
                  vertical: size * 0.03, // Padding vertically 5% of the size
                ),
                decoration: BoxDecoration(
                  color: Colors.teal, // Background color of the banner
                  borderRadius: BorderRadius.circular(size * 0.1), // Rounded corners are 10% of the size
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.security,
                      color: Colors.white,
                      size: iconSize, // Dynamic icon size
                    ),
                    SizedBox(width: size * 0.02), // Spacing between icon and text
                    Text(
                      'LVL $level', // Dynamic Level
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textSize, // Dynamic text size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Ribbon part
              Container(
                height: size * 0.1, // Height of the ribbon
                width: size * 0.66, // Width of the ribbon is 66% of the total size
                color: Colors.teal,
                child: CustomPaint(
                  painter: RibbonPainter(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom painter for the ribbon
class RibbonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.teal;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 4, size.height)
      ..lineTo(size.width * 3 / 4, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

