import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../network/auth/otp/otp.dart';
import '../../../../network/auth/otp/verify_otp.dart';
import '../../../../network/network_client.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final int otpLength = 4;
  final int resendDuration = 30;
  late String email;
  bool _initialized = false;

  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  final networkClient = NetworkClient();
  Timer? _timer;
  int _remainingTime = 0;
  bool _isResendAvailable = false;
  bool _isVerifying = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _startResendTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is String && args.isNotEmpty) {
        setState(() {
          email = args;
          _initialized = true;
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email address is missing'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context);
          }
        });
      }
    }
  }

  void _initializeControllers() {
    _controllers = List.generate(otpLength, (index) => TextEditingController());
    _focusNodes = List.generate(otpLength, (index) => FocusNode());
  }

  void _startResendTimer() {
    setState(() {
      _remainingTime = resendDuration;
      _isResendAvailable = false;
      _errorMessage = null;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _isResendAvailable = true;
          timer.cancel();
        }
      });
    });
  }

  void _showError(String message) {
    if (!mounted) return;
    setState(() {
      _errorMessage = message;
    });
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

  Future<void> _verifyOtp() async {
    final otp = _controllers.map((controller) => controller.text).join();

    if (otp.length != otpLength) {
      _showError('Please enter a valid OTP');
      return;
    }

    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    try {
      final request = VerifyOtpRequest(
        email: email,
        userOtp: int.parse(otp),
      );

      final response = await networkClient.apiService.verifyOTP(request);

      if (response != null) {
        _showSuccess(response.message);
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.passwordReset,
            arguments: {
              'email': email,
              'userOtp': int.parse(otp),
            },
          );
        }
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
      _showError('Invalid OTP. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  Future<void> _resendOtp() async {
    if (!_isResendAvailable) return;

    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    try {
      final request = OTPRequest(email: email);
      final response = await networkClient.apiService.requestOTP(request);

      if (response != null) {
        // Clear all fields
        for (var controller in _controllers) {
          controller.clear();
        }

        // Reset timer
        _startResendTimer();

        _showSuccess('OTP has been resent successfully');
      }
    } catch (e) {
      _showError('Failed to resend OTP. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text00),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Verify OTP",
          style: AppDefaults.primaryHeadline500_24,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.space * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter verification code',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We have sent the code verification to\n$email',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(otpLength, (index) {
                    return SizedBox(
                      width: 52,
                      height: 52,
                      child: TextFormField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: AppDefaults.otpTextStyle,
                        cursorColor: AppColors.text00,
                        decoration: InputDecoration(
                          counterText: '',
                          errorStyle: const TextStyle(height: 0),
                          fillColor: Colors.transparent,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: _errorMessage != null
                                  ? Colors.red
                                  : Colors.grey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: _errorMessage != null
                                  ? Colors.red
                                  : AppColors.primary500,
                              width: 1,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < otpLength - 1) {
                              _focusNodes[index + 1].requestFocus();
                            } else {
                              _focusNodes[index].unfocus();
                            }
                          } else if (index > 0 && value.isEmpty) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        },
                        onTap: () {
                          _controllers[index].selection =
                              TextSelection.fromPosition(
                            TextPosition(
                                offset: _controllers[index].text.length),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _isResendAvailable && !_isVerifying ? _resendOtp : null,
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    children: [
                      const TextSpan(text: "Didn't receive code? "),
                      TextSpan(
                        text: _isResendAvailable
                            ? "Resend"
                            : "Resend in ${_remainingTime}s",
                        style: TextStyle(
                          color: _isResendAvailable && !_isVerifying
                              ? AppColors.primary600
                              : AppColors.secondary500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isVerifying ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    disabledBackgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isVerifying
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Verify',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
