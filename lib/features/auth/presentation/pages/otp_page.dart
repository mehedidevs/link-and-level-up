import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  List<TextEditingController>? _controllers;
  FocusNode? _focusNode;
  Timer? _timer;
  int _start = 60;
  bool _isResendAvailable = false;
  bool _isSendButtonActive = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (index) => TextEditingController());
    _focusNode = FocusNode();
    for (var controller in _controllers!) {
      controller.addListener(_checkIfOtpFieldsAreFilled);
    }
  }

  void startTimer() {
    setState(() {
      _isResendAvailable = false;
      _start = 60;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendAvailable = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _checkIfOtpFieldsAreFilled() {
    bool allFieldsFilled =
        _controllers!.every((controller) => controller.text.isNotEmpty);
    setState(() {
      _isSendButtonActive = allFieldsFilled;
    });
  }

  @override
  void dispose() {
    _controllers?.forEach((controller) {
      controller.dispose();
    });
    _focusNode!.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String get timerText => 'Resend In 00:${_start.toString().padLeft(2, '0')}';

  Color? btnBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.text00,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: const Text("Verify OTP",
              style: TextStyle(
                color: AppColors.text00,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              )),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: AppDefaults.space * 2, bottom: AppDefaults.space),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _controllers![index],
                      focusNode: index == 0 ? _focusNode : null,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: AppDefaults.otpTextStyle,
                      cursorColor: AppColors.text00,
                      decoration: const InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primary500, width: 2),
                        ),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        if (value.length == 1) {
                          if (index + 1 < 4) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).unfocus();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _isResendAvailable
                  ? () {
                      startTimer();
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn’t Get Any Code?",
                    style: AppDefaults.bodyTextStyle,
                  ),
                  const SizedBox(
                    width: AppDefaults.space / 2,
                  ),
                  Text(
                    _isResendAvailable ? "Resend Code" : timerText,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _isResendAvailable
                          ? AppColors.primary600
                          : AppColors.secondary500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.space * 2,
                  vertical: AppDefaults.space),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: _isSendButtonActive
                      ? () {
                          Navigator.pushNamed(context, AppRoutes.passwordReset);
                          startTimer();
                          setState(() {
                            _isSendButtonActive = false;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSendButtonActive
                        ? AppColors.primary500
                        : AppColors.text100,
                  ),
                  child: Text('Send',
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w600))),
            ),
          ],
        ),
      ),
    );
  }
}
