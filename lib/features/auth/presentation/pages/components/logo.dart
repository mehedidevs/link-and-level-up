import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  final String assetName = 'icons/ic_logo.png';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity / 2,
      child: AspectRatio(aspectRatio: 1 / 1, child: Image.asset(assetName)),
    );
  }
}
