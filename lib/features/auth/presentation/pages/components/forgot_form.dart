import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_defaults.dart';
import '../../../../../config/app_icons.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../network/auth/otp/otp.dart';
import '../../../../../network/network_client.dart';

class ForgotForm extends StatefulWidget {
  const ForgotForm({super.key});

  @override
  State<ForgotForm> createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final networkClient = NetworkClient();
  bool _isLoading = false;

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

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final request = OTPRequest(
        email: _emailController.text,
      );

      final response = await networkClient.apiService.requestOTP(request);

      if (response != null) {
        _showSuccess(response.message);
        if (mounted) {
          // Navigate to OTP verification page with email
          Navigator.pushNamed(
              context,
              AppRoutes.OtpPage,
              arguments: _emailController.text
          );
        }
      } else {
        _showError('Failed to send OTP. Please try again.');
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';

      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection';
      }

      _showError(errorMessage);
    } catch (e) {
      _showError('An unexpected error occurred');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDefaults.space),
          Text(
            "Email",
            style: AppDefaults.textWhite500,
          ),
          TextFormField(
            controller: _emailController,
            enabled: !_isLoading,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background700,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDefaults.radius),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter Email Address',
              hintStyle: AppDefaults.hintStyle,
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
            onPressed: _isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              padding: const EdgeInsets.symmetric(
                  vertical: AppDefaults.padding
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDefaults.radius),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 0,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white),
              ),
            )
                : Text(
              'Send',
              style: AppDefaults.buttonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
