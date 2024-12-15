import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';


class PaymentReviewSummary extends StatefulWidget {
  const PaymentReviewSummary({super.key});

  @override
  State<PaymentReviewSummary> createState() => _PaymentReviewSummaryState();
}

class _PaymentReviewSummaryState extends State<PaymentReviewSummary> {
  @override
  Widget build(BuildContext context) {
    return const ReviewSummaryScreen();
  }
}

class ReviewSummaryScreen extends StatelessWidget {
  const ReviewSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: Text(
          'Review Summary',
          style: AppDefaults.bodyTitleTextStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GymInfoCard(),
              SizedBox(height: 20),
              BookingDetails(),
              SizedBox(height: 20),
              PaymentSummary(),
              SizedBox(height: 20),
              PaymentButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class GymInfoCard extends StatelessWidget {
  const GymInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Card(
        color: AppColors.background900,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://www.bigissue.com/wp-content/uploads/2023/07/1575_PaulM_2RA7PR3-2.jpg?w=1920',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('icons/ic_verify_white.svg'),
                        const SizedBox(width: 4),
                        Text('GYM', style: AppDefaults.buttonTextStyleSmall),
                        const Spacer(),
                        SvgPicture.asset('icons/ic_star.svg'),
                        Text('4.8', style: AppDefaults.bodyTextStyle),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Pulse Stadium Center',
                        style: AppDefaults.bodyTitleTextStyle),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text('NY, USA', style: AppDefaults.bodyTextStyle),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('\$5456',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.cyan,
                                fontWeight: FontWeight.w600)),
                        Text('/month', style: AppDefaults.buttonTextStyleSmall),
                      ],
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

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDetailRow('Booking Date', 'August 24, 2024 | 10:00AM'),
        _buildDetailRow('From', 'October 04, 2024'),
        _buildDetailRow('To', 'November 04, 2024'),
        _buildDetailRow('Trainer', 'John Doe'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppDefaults.bodyTextStyle),
          Text(value, style: AppDefaults.buttonTextStyle),
        ],
      ),
    );
  }
}

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPaymentRow('Amount', '\$6456.00'),
        _buildPaymentRow('Tax', '\$5.00'),
        const Divider(),
        _buildPaymentRow('Total', '\$30', isTotal: true),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.money, color: Colors.cyan),
            const SizedBox(width: 8),
            const Text('Cash', style: TextStyle(color: Colors.cyan)),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Handle payment method change
              },
              child: const Text('Change', style: TextStyle(color: Colors.cyan)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppDefaults.bodyTextStyle),
          Text(
            value,
            style: TextStyle(
                fontSize: isTotal ? 20 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: AppColors.text00),
          ),
        ],
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle payment

          Navigator.pushNamed(context, AppRoutes.PaymentReceipt);
        },
        child: const Text('Make Payment'),
      ),
    );
  }
}
