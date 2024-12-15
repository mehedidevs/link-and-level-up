import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../athlete/home/components/section_header.dart';


class FavoriteFacilitator extends StatelessWidget {
  const FavoriteFacilitator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Nearby Facilitator'),
        FacilitatorCard(
          location: 'Pulse Football Center',
          price: '\$150.00 /month',
          rating: 4.6,
        ),
        // Add more FacilitatorCard widgets as needed
      ],
    );
  }
}

class FacilitatorCard extends StatelessWidget {
  final String location;
  final String price;
  final double rating;

  const FacilitatorCard(
      {super.key, required this.location, required this.price, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                color: const Color(0xFF1E1E2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/facilator%2Fc7b0056e12a9f128b0f97619d5157b0e.jpeg?alt=media&token=51a76e84-e3f2-4aa7-9de6-9c207674a970',
                          // Replace with your image URL
                          width: 124,
                          height: 124,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height:AppDefaults.space/2),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary500,
                                      borderRadius: BorderRadius.circular(
                                          AppDefaults.radius * 2),
                                    ),
                                    child: const Text(
                                      'Open Field',
                                      style: TextStyle(
                                        color: AppColors.textDark,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset('icons/ic_love_fav.svg'),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Pulse Football Center',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                  Text(
                                    'New York, USA',
                                    style: GoogleFonts.inter(
                                      color: AppColors.textDark9,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                               Row(
                                children: [
                                  Text(
                                    '\$150.00',
                                    style:  GoogleFonts.inter(
                                      color: AppColors.primary500,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' /month',
                                    style: GoogleFonts.inter(
                                      color:AppColors.text800,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
