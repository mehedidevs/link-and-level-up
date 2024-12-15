import 'package:flutter/material.dart';

import '../../../config/app_defaults.dart';
import '../../parent/profile/components/app_bar.dart';
import '../../parent/profile/components/sports_list.dart';

class SportsSelectionPage extends StatefulWidget {
  const SportsSelectionPage({super.key});

  @override
  State<SportsSelectionPage> createState() => _SportsSelectionPageState();
}

class _SportsSelectionPageState extends State<SportsSelectionPage> {
  double pageNumber = 5;

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
                        'What Sports you like',
                        style: AppDefaults.titleHeadlineStyle,
                      ),
                    ),
                    const SizedBox(height: AppDefaults.space),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'This helps us create your personal recommendation program',
                        style: AppDefaults.titleStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDefaults.space),
              const Expanded(child: SportsList()),
              const SizedBox(height: AppDefaults.space),
            ],
          ),
        ),
      ),
    );
  }
}
