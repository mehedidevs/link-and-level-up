import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_defaults.dart';
import '../../../../../config/app_icons.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../network/auth/forget_password/forgotpassword.dart';
import '../../../../../network/network_client.dart';

class NewPasswordForm extends StatefulWidget {
  final String email;
  final int userOtp;

  const NewPasswordForm({
    super.key,
    required this.email,
    required this.userOtp,
  });

  @override
  _NewPasswordFormState createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  bool _isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final networkClient = NetworkClient();
  bool _isLoading = false;

  void _togglePasswordView() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
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
      final request = ResetPasswordRequest(
        email: widget.email,
        userOtp: widget.userOtp,
        password: _passwordController.text,
      );

      // Debug print
      print('Request Data: ${request.toJson()}');

      final response = await networkClient.apiService.resetPassword(request);

      if (response != null) {
        _showSuccess('Password reset successful');
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.StartScreen,
                (Route<dynamic> route) => false,
          );
        }
      }
    } on DioException catch (e) {
      print('Error [${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
      print('Response data: ${e.response?.data}');

      String errorMessage = 'An error occurred';

      if (e.response != null) {
        if (e.response?.statusCode == 403) {
          // Handle 403 Forbidden specifically
          errorMessage = e.response?.data['message'] ?? 'Wrong OTP or invalid request';
        } else {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection';
      }

      _showError(errorMessage);
    } catch (e) {
      print('Unexpected error: $e');
      _showError('An unexpected error occurred');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            "Password",
            style: AppDefaults.textWhite500,
          ),
          TextFormField(
            controller: _passwordController,
            enabled: !_isLoading,
            obscureText: _isPasswordHidden,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background700,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDefaults.radius),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter Password',
              hintStyle: AppDefaults.hintStyle,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: AppDefaults.space),
                  Image.asset(
                    AppIcons.password,
                    color: AppColors.secondary500,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: AppDefaults.space),
                  Container(
                    width: 1,
                    height: 18,
                    color: AppColors.secondary500,
                  ),
                  const SizedBox(width: AppDefaults.space),
                ],
              ),
              suffixIcon: IconButton(
                icon: Image.asset(
                  _isPasswordHidden ? AppIcons.lock : AppIcons.lock,
                  color: _isPasswordHidden
                      ? AppColors.secondary500
                      : Colors.white54,
                ),
                onPressed: _isLoading ? null : _togglePasswordView,
              ),
            ),
            validator: _validatePassword,
          ),
          const SizedBox(height: AppDefaults.space),
          Text(
            "Re-Type Password",
            style: AppDefaults.textWhite500,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            enabled: !_isLoading,
            obscureText: _isPasswordHidden,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background700,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDefaults.radius),
                borderSide: BorderSide.none,
              ),
              hintText: 'Re-Enter Password',
              hintStyle: AppDefaults.hintStyle,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: AppDefaults.space),
                  Image.asset(
                    AppIcons.password,
                    color: AppColors.secondary500,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: AppDefaults.space),
                  Container(
                    width: 1,
                    height: 18,
                    color: AppColors.secondary500,
                  ),
                  const SizedBox(width: AppDefaults.space),
                ],
              ),
              suffixIcon: IconButton(
                icon: Image.asset(
                  _isPasswordHidden ? AppIcons.lock : AppIcons.lock,
                  color: _isPasswordHidden
                      ? AppColors.secondary500
                      : Colors.white54,
                ),
                onPressed: _isLoading ? null : _togglePasswordView,
              ),
            ),
            validator: _validateConfirmPassword,
          ),
          const SizedBox(height: AppDefaults.space),
          ElevatedButton(
            onPressed: _isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              padding: const EdgeInsets.symmetric(
                vertical: AppDefaults.padding,
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
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Reset Password',
                    style: AppDefaults.buttonTextStyle,
                  ),
          ),
        ],
      ),
    );
  }
}
