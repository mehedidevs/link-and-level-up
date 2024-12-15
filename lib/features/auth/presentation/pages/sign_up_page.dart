import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/app_icons.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/LoadingOverlay.dart';
import '../../../../core/constants/keys.dart';
import '../../../../db/secure_storage_service.dart';
import '../../../../network/auth/register/user_request.dart';
import '../../../../network/network_client.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordHidden = true;

  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Network client
  final _networkClient = NetworkClient();

  void _togglePasswordView() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
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

  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _networkClient.apiService.signUp(
        UserRequest(
          fullName: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );

      var storage = SecureStorageService();
      await storage.saveInt(userId, response.userId);

      // Get saved value for verification
      final savedUserId = await storage.getInt(userId);
      print("user id save ${response.userId}");
      print("user id saved $savedUserId");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pushNamed(context, AppRoutes.userTypeSelection);
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _isLoading,
          message: 'Creating account...',
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.space),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppDefaults.space * 3),
                    const Text(
                      'Create Your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.text100,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppDefaults.space),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already Have An Account?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.text300,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: AppDefaults.padding,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                            child: const Text(
                              'Log In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDefaults.space),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Full Name",
                            style: TextStyle(
                                color: AppColors.text100,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          TextFormField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.background700,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppDefaults.radius),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Enter Your Full Name',
                              hintStyle:
                                  const TextStyle(color: AppColors.text700),
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: AppDefaults.space),
                                  Image.asset(
                                    AppIcons.person,
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
                            ),
                            validator: _validateFullName,
                          ),
                          const SizedBox(height: AppDefaults.space),
                          const Text(
                            "Email",
                            style: TextStyle(
                                color: AppColors.text100,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.background700,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppDefaults.radius),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Enter Email Address',
                              hintStyle:
                                  const TextStyle(color: AppColors.text700),
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
                          const Text(
                            "Password",
                            style: TextStyle(
                                color: AppColors.text100,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isPasswordHidden,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.background700,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppDefaults.radius),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Enter Password',
                              hintStyle:
                                  const TextStyle(color: AppColors.text700),
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
                                    _isPasswordHidden
                                        ? AppIcons.lock
                                        : AppIcons.lock,
                                    color: _isPasswordHidden
                                        ? AppColors.secondary500
                                        : Colors.white54),
                                onPressed: _togglePasswordView,
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: AppDefaults.space),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _submitForm,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.grey),
                                    ),
                                  )
                                : const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDefaults.space),
                    const Text(
                      'By continuing, you agree to LLU\'s Terms of Service and Privacy Policy',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: AppColors.text400,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: AppDefaults.space * 2),
                    const Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white54)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDefaults.padding),
                          child: Text(
                            'or',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white54)),
                      ],
                    ),
                    const SizedBox(height: AppDefaults.space),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(AppIcons.google),
                      label: const Text('Continue With Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.background400,
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDefaults.padding),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDefaults.radius),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDefaults.space),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.apple, color: Colors.white),
                      label: const Text('Continue With Apple'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.background700,
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDefaults.padding),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDefaults.radius),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDefaults.space),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Skip For Now',
                        style: TextStyle(color: AppColors.secondary500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
