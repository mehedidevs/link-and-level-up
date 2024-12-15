import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../athlete/home/components/section_header.dart';


class FeaturedTrainer extends StatelessWidget {
  const FeaturedTrainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Featured Trainer'),

        SizedBox(
          height: 280,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const TrainerCard(
                  title: 'Goal Keeping Techniques',
                  trainer: 'Mike Hussey',
                  price: '\$150.00',
                  rating: 4.6,
                );
              }),
        ),

        // Add more TrainerCard widgets as needed
      ],
    );
  }
}

class TrainerCard extends StatelessWidget {
  final String title;
  final String trainer;
  final String price;
  final double rating;

  const TrainerCard(
      {super.key,
      required this.title,
      required this.trainer,
      required this.price,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, AppRoutes.TrainerDetailsPageForUser);
        },
        child: Container(
          width: 226,
          height: 260,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2F91224920fd7851ae36fdac5b5ed2194e.jpeg?alt=media&token=8a288db3-c591-45db-be57-326e94cf3a25',
                      height: 141,
                      width: 226,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset('images/placeholder.jpg'),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppDefaults.space / 2),
                        child: SvgPicture.asset('icons/ic_love.svg'),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppDefaults.space / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: AppColors.text700,
                                  width: 1.0,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: AppColors.text700,
                                  width: 1.0,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
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
                        Row(
                          children: [
                            SvgPicture.asset('icons/ic_star.svg'),
                            const SizedBox(width: 5),
                            const Text(
                              '4.6',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppDefaults.space,
                    ),
                    const Text(
                      'Goal Keeping Techniques fdsfdfds fdfdsf fsdfdsfs',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('icons/ic_profile.svg'),
                        const Text(
                          'Mike Hussy',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '\$150.00',
                      style: TextStyle(
                        color: AppColors.primary500,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
