import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import 'components/forgot_form.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.text100,),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppDefaults.space),
                ForgotForm(),
                SizedBox(height: AppDefaults.space),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
