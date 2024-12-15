import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';


class PaymentCongratulations extends StatefulWidget {
  const PaymentCongratulations({super.key});

  @override
  State<PaymentCongratulations> createState() => _PaymentCongratulationsState();
}

class _PaymentCongratulationsState extends State<PaymentCongratulations> {
  @override
  Widget build(BuildContext context) {
    return const CongratulationsScreen();
  }
}

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: SvgPicture.asset('icons/ic_star.svg'),
                ),
                const SizedBox(height: 24),
                Text(
                  'Congratulations!',
                  style: AppDefaults.primaryHeadline
                      .copyWith(color: AppColors.text00),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour,',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to E-Receipt
                    },
                    child: const Text(
                      'View E-Receipt',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // Navigate to Home
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.AthleteMainPage,
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    'Go to Home',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
