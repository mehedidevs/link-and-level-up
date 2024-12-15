import 'package:flutter/material.dart';

import '../../../config/app_defaults.dart';
import '../../athlete/profile/components/app_bar.dart';
import '../../athlete/profile/components/sports_level_list.dart';



class LevelSelectionPage extends StatefulWidget {
  const LevelSelectionPage({super.key});

  @override
  State<LevelSelectionPage> createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends State<LevelSelectionPage> {
  double pageNumber = 6;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProgressiveAppBar(pageNumber: pageNumber),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding * 2,
                    vertical: AppDefaults.padding),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'What your sports level',
                        style: AppDefaults.titleHeadlineStyle,
                      ),
                    ),
                    const SizedBox(height: AppDefaults.space),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'This helps us to create your personalized plan',
                        style: AppDefaults.titleStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDefaults.space),
              const Expanded(child: SportsLevelList()),
              const SizedBox(height: AppDefaults.space),
            ],
          ),
        ),
      ),
    );
  }
}
