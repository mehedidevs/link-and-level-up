import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import 'components/new_password_form.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  String? email;
  int? userOtp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get arguments from route
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      email = args['email'] as String?;
      userOtp = args['userOtp'] as int?;

      // If email or OTP is missing, navigate back
      if (email == null || userOtp == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Missing required information'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        });
      }
    } else {
      // If no arguments provided, navigate back
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Missing required information'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.text100,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: Text(
            "Reset Password",
            style: AppDefaults.primaryHeadline500_24,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.space),
            child: email != null && userOtp != null
                ? NewPasswordForm(
              email: email!,
              userOtp: userOtp!,
            )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
