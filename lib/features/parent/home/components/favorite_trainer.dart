import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../athlete/home/components/section_header.dart';


class FavoriteTrainer extends StatelessWidget {
  const FavoriteTrainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Nearby Facilitator'),
        FavoriteTrainerCard(
          location: 'Pulse Football Center',
          price: '\$150.00 /month',
          rating: 4.6,
        ),
        // Add more FacilitatorCard widgets as needed
      ],
    );
  }
}

class FavoriteTrainerCard extends StatelessWidget {
  final String location;
  final String price;
  final double rating;

  const FavoriteTrainerCard(
      {super.key,
      required this.location,
      required this.price,
      required this.rating});

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
                          'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F89fcb09b641b376e567ad815cf03f40e.jpeg?alt=media&token=27f82185-d64a-43b4-97ad-bffc1e538beb',
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
                              const SizedBox(height: AppDefaults.space / 2),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            color: AppColors.text700,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Text(
                                            'Football',
                                            style: TextStyle(
                                              color: AppColors.text00,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            color: AppColors.text700,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Text(
                                            'Beginner',
                                            style: TextStyle(
                                              color: AppColors.text00,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'icons/ic_profile.svg',
                                    height: 20,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'New York, USA',
                                    style: AppDefaults.titleStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '\$150.00',
                                    style: GoogleFonts.inter(
                                      color: AppColors.primary500,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' /month',
                                    style: GoogleFonts.inter(
                                      color: AppColors.text800,
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
