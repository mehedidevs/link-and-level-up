import 'package:flutter/material.dart';

import '../../../../config/app_defaults.dart';
import 'components/bottom_buttons.dart';
import 'components/logo.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                Center(child: Logo()),
                Spacer(flex: 3),
              ],
            ),
            SizedBox(height: AppDefaults.space),
            Positioned(
              bottom: AppDefaults.space * 2,
              left: AppDefaults.space,
              right: AppDefaults.space,
              child: BottomButtons(),
            )
          ],
        ),
      ),
    );
  }
}
