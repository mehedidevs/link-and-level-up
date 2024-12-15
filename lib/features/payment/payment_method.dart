import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';


class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return const PaymentMethodsScreen();
  }
}

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String? _selectedPaymentMethod;

  void _onPaymentMethodSelected(String method) {
    setState(() {
      _selectedPaymentMethod = method;
      Navigator.pushNamed(context, AppRoutes.AddCard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: Text(
          'Payment Methods',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentSection(
              title: 'Cash',
              children: [
                PaymentOption(
                  icon: Icons.attach_money,
                  label: 'Cash',
                  isSelected: _selectedPaymentMethod == 'Cash',
                  onTap: () => _onPaymentMethodSelected('Cash'),
                ),
              ],
            ),
            PaymentSection(
              title: 'Credit & Debit Card',
              children: [
                PaymentOption(
                  icon: Icons.credit_card,
                  label: 'Add New Card',
                  isSelected: _selectedPaymentMethod == 'Add New Card',
                  onTap: () => _onPaymentMethodSelected('Add New Card'),
                ),
              ],
            ),
            PaymentSection(
              title: 'More payment Option',
              children: [
                PaymentOption(
                  label: 'Paypal',
                  isSelected: _selectedPaymentMethod == 'Paypal',
                  onTap: () => _onPaymentMethodSelected('Paypal'),
                ),
                const SizedBox(
                  height: AppDefaults.space,
                ),
                PaymentOption(
                  label: 'Apple pay',
                  isSelected: _selectedPaymentMethod == 'Apple pay',
                  onTap: () => _onPaymentMethodSelected('Apple pay'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const PaymentSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppDefaults.bodyTitleTextStyle,
          ),
          const SizedBox(height: 8),
          ...children,
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.placeholder : Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.teal),
            if (icon != null) const SizedBox(width: 16),
            Text(
              label,
              style: AppDefaults.menuTextStyle,
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.teal,
              ),
          ],
        ),
      ),
    );
  }
}
