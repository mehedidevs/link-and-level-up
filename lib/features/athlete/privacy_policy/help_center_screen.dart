import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_defaults.dart';
import '../../../config/app_icons.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFFB79654), Color(0xFF100F15)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
            title: Text(
              'Help Center',
              style: AppDefaults.titleHeadlineStyle,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    FittedBox(
                      child: Image.asset(
                        'images/app_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      child: Image.asset(
                        'images/help_person.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'LLU Support\nHow can we help?',
                      style: AppDefaults.titleHeadlineStyle.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Full Name",
                      style: TextStyle(
                          color: AppColors.text100,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
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
                        hintStyle: const TextStyle(color: AppColors.text700),
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
                    ),
                    const SizedBox(height: AppDefaults.space),
                    const Text(
                      "Email",
                      style: TextStyle(
                          color: AppColors.text100,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
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
                    ),
                    const SizedBox(height: AppDefaults.space),
                    const Text(
                      "Description",
                      style: TextStyle(
                          color: AppColors.text100,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          maxLines: 8,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.background700,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDefaults.radius),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Write your problem here...',
                            hintStyle:
                                const TextStyle(color: AppColors.text700),
                          ),
                        ),
                        Positioned(
                          right: 2,
                          bottom: 2,
                          child: SvgPicture.asset(
                            'icons/ic_drag.svg',
                          ),
                        )
                      ],
                    ),


                  ],
                ),
              ),
            ),
          )),
    );
  }
}
