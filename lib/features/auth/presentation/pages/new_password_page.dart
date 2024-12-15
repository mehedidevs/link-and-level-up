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
          title: const Text("Forgot Password",
              style: TextStyle(
                color: AppColors.text100,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              )),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(AppDefaults.space),
            child: NewPasswordForm(),

          ),
        ),
      ),
    );
  }
}
