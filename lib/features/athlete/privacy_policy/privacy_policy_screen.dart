import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_defaults.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context, true),
          child:  const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text('Privacy Policy',style: AppDefaults.titleHeadlineStyle,),
      ),
      body: const PrivacyPolicyText(),
    );
  }
}

class PrivacyPolicyText extends StatelessWidget {
  const PrivacyPolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'LLU Privacy Policy',
            style: AppDefaults.bodyTitleTextStyle.copyWith(color: AppColors.text00),
          ),
          const SizedBox(height: 10),
          Text(
            'This Privacy Policy outlines how personal information is collected, used, and disclosed by LLU ("we", "us", or "our") when you use our mobile application ("App"). We are committed to protecting your privacy and ensuring the security of your personal information. By using the App, you agree to the collection and use of information in accordance with this Privacy Policy.',
            style: AppDefaults.bodyTextStyle.copyWith(color: AppColors.text00),
          ),
          const SizedBox(height: 20),
          Text(
            'Information Collection and Use',
            style: AppDefaults.bodyTitleTextStyle.copyWith(color: AppColors.text00),
          ),
          const SizedBox(height: 10),
          Text(
            'We may collect various types of information when you use our App, including:\n'
                '\n1. Personal Information: When you register an account or make a purchase through the App, we may collect personal information such as your name, email address, shipping address, phone number, and payment information.\n'
                '\n2. Usage Information: We may collect information about how you interact with the App, including the pages you visit, the products you view, and your actions within the App.\n'
                '\n3. Device Information: We may collect information about the device you use to access the App, such as the device type, operating system.',
            style: AppDefaults.bodyTextStyle.copyWith(color: AppColors.text00),
          ),
        ],
      ),
    );
  }
}