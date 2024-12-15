import 'package:flutter/material.dart';


import '../../../../config/app_defaults.dart';
import '../../../../config/app_text.dart';
import '../../../parent/profile/components/step_progress.dart';

class ProgressiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProgressiveAppBar({
    super.key,
    required this.pageNumber,
  });

  final double pageNumber;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false, // Disable the default back button
      title: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Row(
                children: [
                  Expanded(
                    child: StepProgressBar(
                      AppText.totalProgress,
                      AppText.eachPageProgress * pageNumber,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${pageNumber.toInt()}/${AppText.totalProgressivePage}',
                    style: AppDefaults.bodyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Skip',
              style: AppDefaults.bodyTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
