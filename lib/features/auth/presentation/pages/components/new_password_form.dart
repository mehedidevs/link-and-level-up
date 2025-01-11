import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_defaults.dart';
import '../../../../../config/app_icons.dart';
import '../../../../../config/routes/app_routes.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({super.key});

  @override
  _NewPasswordFormState createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  bool _isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordView() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  String? password;
  String? re_type_password;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (password != re_type_password) {
      return 'Password field does not march';
    }
    return null;
  }

  void _submitForm() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.StartScreen,
      // The named route you want to navigate to
      (Route<dynamic> route) => false, // This will remove all previous routes
    );
    /*if (_formKey.currentState!.validate()) {
      // Proceed with form submission
      Navigator.pushNamed(context, AppRoutes.login);
    }*/
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
            onChanged: (password) {
              setState(() {
                this.password = password;
              });
            },
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
                        : Colors.white54),
                onPressed: _togglePasswordView,
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
            onChanged: (password) {
              setState(() {
                this.password = password;
              });
            },
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
                        : Colors.white54),
                onPressed: _togglePasswordView,
              ),
            ),
            validator: _validatePassword,
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
            child: Text(
              'Reset Password',
              style: AppDefaults.buttonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
