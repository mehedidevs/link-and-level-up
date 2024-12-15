import 'package:flutter/material.dart';

import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../athlete/home/components/section_header.dart';


class TopTrainer extends StatelessWidget {
  const TopTrainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Top Trainer'),
        SizedBox(
          height: 190,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
              return  GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.TrainerDetailsPageForUser);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                      children: [
                        ClipOval(
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/firabsecrud.appspot.com/o/fetured_trainer%2Ftrainer%2F14d7147b7508146d26409c29f0cd11c4.jpeg?alt=media&token=7c1adf61-d181-4f01-bf13-7255d40cec15',
                            // Replace with your image URL
                            width: 100, // Set the width of the image
                            height: 100, // Set the height of the image
                            fit: BoxFit
                                .cover, // Ensure the image covers the entire circle
                          ),
                        ),
                         Text('Mickael W.', style: AppDefaults.bodyTextStyle,),
                      ],
                    ),
                ),
              );

              }),
        ),
      ],
    );
  }
}
