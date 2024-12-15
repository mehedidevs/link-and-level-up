import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';

class PaymentReceipt extends StatefulWidget {
  const PaymentReceipt({super.key});

  @override
  State<PaymentReceipt> createState() => _PaymentReceiptState();
}

class _PaymentReceiptState extends State<PaymentReceipt> {
  @override
  Widget build(BuildContext context) {
    return const EReceiptScreen();
  }
}

class EReceiptScreen extends StatelessWidget {
  const EReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: Text(
          'E-Receipt',
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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BarcodeWidget(),
            SizedBox(height: 16),
            ReceiptDetailWidget(
              label: 'Booking Date',
              value: 'August 24, 2024 | 10:00AM',
            ),
            ReceiptDetailWidget(
              label: 'From',
              value: 'October 04, 2024',
            ),
            ReceiptDetailWidget(
              label: 'To',
              value: 'November 04, 2024',
            ),
            ReceiptDetailWidget(
              label: 'Trainer',
              value: 'John Doe',
            ),
            Divider(),
            ReceiptDetailWidget(
              label: 'Amount',
              value: '\$6456.00',
            ),
            ReceiptDetailWidget(
              label: 'Tax',
              value: '\$5.00',
            ),
            ReceiptDetailWidget(
              label: 'Total',
              value: '\$30',
            ),
            Divider(),
            ReceiptDetailWidget(
              label: 'Name',
              value: 'John Doe',
            ),
            ReceiptDetailWidget(
              label: 'Phone Number',
              value: '+880 1582658745',
            ),
            ReceiptDetailWidget(
              label: 'Transaction ID',
              value: '#RSM54564564',
            ),
            Spacer(),
            DownloadButton(),
          ],
        ),
      ),
    );
  }
}

class BarcodeWidget extends StatelessWidget {
  const BarcodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
          child: SizedBox(
        height: 200,
        child: SfBarcodeGenerator(
          barColor: AppColors.text00,
          backgroundColor: AppColors.scaffoldBackground,
          value: 'LLU App Bar Code Demo',
          symbology: Code128A(),
        ),
      )),
    );
  }
}

class ReceiptDetailWidget extends StatelessWidget {
  final String label;
  final String value;

  const ReceiptDetailWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Implement download functionality here
          Navigator.pushNamed(context, AppRoutes.PaymentCongratulations);
        },
        child: const Text(
          'Download E-Receipt',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
