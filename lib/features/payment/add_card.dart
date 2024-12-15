import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../config/app_defaults.dart';
import '../../config/routes/app_routes.dart';


class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return const AddCardScreen();
  }
}

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Check if the user is deleting characters
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // Add a '/' after the first two digits
    if (text.length == 2 && !text.contains('/')) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    } else if (text.length > 2 && !text.contains('/')) {
      // In case the slash was removed, add it back
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    } else if (text.length == 4 && text.contains('/')) {
      // Reformat if user types out of sequence
      text = '${text.substring(0, 2)}/${text.substring(3)}';
    }

    // Ensure the text doesn't exceed 5 characters (MM/YY)
    if (text.length > 5) {
      text = text.substring(0, 5);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String cardHolderName = '';
  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';
  bool saveCard = false;

  void _onSaveCardChanged(bool? newValue) {
    setState(() {
      saveCard = newValue ?? false;
    });
  }

  void _onAddCard() {
    if (_formKey.currentState?.validate() ?? false) {
      // Process the data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Card Added Successfully')),
      );

      Navigator.pushNamed(context, AppRoutes.PaymentReviewSummary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar:AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: Text(
          'Add Card',
          style: AppDefaults.bodyTitleTextStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ) ,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreditCardWidget(
              cardNumber:
                  cardNumber.isNotEmpty ? cardNumber : 'XXXX XXXX XXXX XXXX',
              cardHolderName:
                  cardHolderName.isNotEmpty ? cardHolderName : 'Card Holder',
              expiryDate: expiryDate.isNotEmpty ? expiryDate : 'MM/YY',
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    label: 'Card holder name',
                    hintText: 'Enter your name as on card',
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card holder name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: 'Card Number',
                    hintText: 'Enter your 16-digit card number',
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }
                      if (value.length != 16) {
                        return 'Card number must be 16 digits';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          label: 'Expiry Date',
                          hintText: 'MM/YY',
                          onChanged: (value) {
                            setState(() {
                              expiryDate = value;
                              if (value.length == 2) {
                                expiryDate = '$value/';
                              }
                            });
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5),
                            // Allow 5 characters for MM/YY
                            CardExpiryInputFormatter(),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter expiry date';
                            }
                            if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                              return 'Invalid date format. Use MM/YY';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextFormField(
                          label: 'CVV',
                          hintText: 'Enter 3-digit CVV',
                          onChanged: (value) {
                            setState(() {
                              cvv = value;
                            });
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter CVV';
                            }
                            if (value.length != 3) {
                              return 'CVV must be 3 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: saveCard,
                        onChanged: _onSaveCardChanged,
                      ),
                      Text(
                        'Save Card',
                        style: AppDefaults.bodyTitleTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onAddCard,
                    child: const Center(
                      child: Text(
                        'Add Card',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;

  const CreditCardWidget({
    super.key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / .5,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: const DecorationImage(
            image: AssetImage('icons/bg_card_back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    'Card holder name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  'Expiry date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                SizedBox()
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    cardHolderName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  expiryDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({super.key, 
    required this.label,
    this.hintText,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppDefaults.bodyTextStyle,
          ),
          const SizedBox(height: 8),
          TextFormField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            validator: validator,
            inputFormatters: inputFormatters,
            style: AppDefaults.bodyTextStyle,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[900],
              hintText: hintText,
              hintStyle: GoogleFonts.inter(color: Colors.white30),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
