import 'package:flutter/material.dart';


import '../../../../../config/app_defaults.dart';
import '../../../../../config/app_text.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/themes/app_themes.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: AppDefaults.padding / 2,
              horizontal: AppDefaults.padding),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.signup);
            },
            child: const Text(AppText.getStarted),
          ),
        ),
        const SizedBox(height: AppDefaults.space),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: AppDefaults.padding / 2,
              horizontal: AppDefaults.padding),
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
            child: const Text(
              AppText.signIn,
              style: AppTheme.textStyleWhite,
            ),
          ),
        ),
      ],
    );
  }
}
