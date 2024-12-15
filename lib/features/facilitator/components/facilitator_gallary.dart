import 'package:flutter/material.dart';

import '../../../config/app_defaults.dart';


class FacilitatorGallary extends StatefulWidget {
  const FacilitatorGallary({super.key});

  @override
  State<FacilitatorGallary> createState() => _FacilitatorGallaryState();
}

class _FacilitatorGallaryState extends State<FacilitatorGallary> {
  final List<String> imageUrls = [
    'https://www.ncaa.com/_flysystem/public-s3/styles/original/public-s3/images/2018/10/31/penn-state-rec-hall.png?itok=3kAJ-ite',
    'https://cdnb.artstation.com/p/assets/images/images/020/178/643/large/aurelien-vaillant-screenshot00048.jpg?1566727011',
    'https://c8.alamy.com/comp/2HTA6DF/a-general-view-inside-the-arena-during-the-volley-serie-a-women-202122-volleyball-match-between-uyba-unet-e-work-busto-arsizio-and-volley-bergamo-1991-at-e-work-arena-busto-arsizio-italy-on-february-27-2022-2HTA6DF.jpg',
    'https://c8.alamy.com/comp/2M7619J/uyba-unet-e-work-busto-arsizio-celebrate-the-victory-at-the-end-of-the-match-players-during-volley-serie-a-women-202223-volleyball-match-between-uyba-unet-e-work-busto-arsizio-and-il-bisonte-firenze-at-e-work-arena-busto-arsizio-italy-on-january-07-2023-2M7619J.jpg',
    'https://www.trentinovolley.it/images/pagine-interne/palazzetto1.jpg',
    'https://img.freepik.com/premium-photo/futuristic-sports-arena-with-dramatic-lighting-volleyball-court-background-dark-stadium-setting-best-adobe-stock-shutterstock_561855-2256.jpg?w=360',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8, // Horizontal spacing between grid items
            mainAxisSpacing: 8, // Vertical spacing between grid items
            childAspectRatio: 1 / 1.2),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(AppDefaults.radius),
            child: Image.network(
              imageUrls[index],
              // Replace with your image URL
              // Set the width of the image
              height: 120, // Set the height of the image
              fit: BoxFit.cover, // Ensure the image covers the entire circle
            ),
          );
        },
      ),
    );
  }
}
