import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_defaults.dart';
import '../../../../../config/app_icons.dart';
import '../../../../../config/routes/app_routes.dart';


class ForgotForm extends StatefulWidget {
  const ForgotForm({super.key});

  @override
  State<ForgotForm> createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Proceed with form submission
      Navigator.pushNamed(context, AppRoutes.OtpPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDefaults.space),
          const Text(
            "Email",
            style: TextStyle(
                color: AppColors.text100,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background700,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDefaults.radius),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter Email Address',
              hintStyle: const TextStyle(color: AppColors.text700),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: AppDefaults.space),
                  Image.asset(
                    AppIcons.email,
                    color: AppColors.secondary500,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: AppDefaults.space),
                  Container(
                    width: 1,
                    height: AppDefaults.space,
                    color: AppColors.secondary500,
                  ),
                  const SizedBox(width: AppDefaults.space),
                ],
              ),
            ),
            validator: _validateEmail,
          ),
          const SizedBox(height: AppDefaults.space),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              padding:
                  const EdgeInsets.symmetric(vertical: AppDefaults.padding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDefaults.radius),
              ),
            ),
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
