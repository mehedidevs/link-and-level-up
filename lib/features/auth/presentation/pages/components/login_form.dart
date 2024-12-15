import 'package:flutter/material.dart';


import '../../../../../config/app_colors.dart';
import '../../../../../config/app_defaults.dart';
import '../../../../../config/app_icons.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/constants/keys.dart';
import '../../../../../db/secure_storage_service.dart';
import '../../../../../network/auth/login/login_request.dart';
import '../../../../../network/network_client.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<LoginForm> {
  bool _isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();
  final networkClient = NetworkClient();

  void _togglePasswordView() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
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
    if (value.length < 4) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  final _userEmailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    final userEmail = _userEmailController.text;
    final password = _passwordController.text;
    loginUser(userEmail, password);
    // dummyUser(userEmail, password);
  }

  void loginUser(String userEmail, String password) async {
    LoginRequest request = LoginRequest(email: userEmail, password: password);

    var response = await networkClient.apiService.login(request);
    var localDb = SecureStorageService();
    print("Login successful! Access Token: ${response?.user}");
    if (response != null) {
      localDb.saveString(accessToken, response.accessToken);
      localDb.saveString(refreshToken, response.refreshToken);
      //  print("Login successful! Access Token: ${response.user}");
    } else {
      print("Login failed.");
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Proceed with form submission
      //Navigator.pushNamed(context, AppRoutes.AthleteMainPage);
      _login();
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
            controller: _userEmailController,
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
                borderRadius: BorderRadius.circular(AppDefaults.radius),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter Password',
              hintStyle: const TextStyle(color: AppColors.text700),
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
                        : Colors.white54),
                onPressed: _togglePasswordView,
              ),
            ),
            validator: _validatePassword,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.forgotPassword);
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AppColors.secondary500,
                  ),
                ),
              ),
            ],
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
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

enum UserType { Athlete, Trainer, Facilitator, Parent }

class User {
  final String userEmail;
  final String password;
  final UserType userType;

  User(
      {required this.userEmail,
      required this.password,
      required this.userType});
}

List<User> dummyUsers = [
  User(
      userEmail: 'athlete1@gmail.com',
      password: 'password123',
      userType: UserType.Athlete),
  User(
      userEmail: 'trainer1@gmail.com',
      password: 'password123',
      userType: UserType.Trainer),
  User(
      userEmail: 'faciliti1@gmail.com',
      password: 'password123',
      userType: UserType.Facilitator),
  User(
      userEmail: 'parent1@gmail.com',
      password: 'password123',
      userType: UserType.Parent),
];
