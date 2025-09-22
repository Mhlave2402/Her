import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/payment/controllers/payment_controller.dart';
import 'package:her_user_app/common_widgets/custom_appbar.dart';
import 'package:her_user_app/common_widgets/custom_button.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';

class CardPaymentScreen extends StatefulWidget {
  final double amount;
  final String referenceId;
  final bool fromParcel;

  const CardPaymentScreen({
    super.key,
    required this.amount,
    required this.referenceId,
    this.fromParcel = false,
  });

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final PaymentController _paymentController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  bool _saveCard = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _paymentController.initPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Card Payment'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Form(
          key: _formKey,
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Text(
                    'Pay ${widget.amount.toStringAsFixed(2)}',
                    style: fontSizeMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  
                  // Supported Card Types
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/visa.png', width: 40),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Image.asset('assets/image/mastercard.png', width: 40),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Image.asset('assets/image/amex.png', width: 40),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  // Card Number
                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }
                      if (value.replaceAll(' ', '').length < 16) {
                        return 'Invalid card number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  
                  // Expiry and CVV
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expiryController,
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            labelText: 'MM/YY',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter expiry';
                            }
                            if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                              return 'Invalid format (MM/YY)';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault),
                      Expanded(
                        child: TextFormField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'CVV',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter CVV';
                            }
                            if (value.length < 3) {
                              return 'Invalid CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  
                  // Card Holder
                  TextFormField(
                    controller: _cardHolderController,
                    decoration: const InputDecoration(
                      labelText: 'Card Holder Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter card holder name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  
                  // Save Card Option
                  Row(
                    children: [
                      Checkbox(
                        value: _saveCard,
                        onChanged: (value) => setState(() => _saveCard = value!),
                      ),
                      const Text('Save card for future payments'),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  
                  // Pay Button
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          buttonText: 'Pay Now',
                          onPressed: _processPayment,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _processPayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Split expiry into month/year
      final expiryParts = _expiryController.text.split('/');
      final month = expiryParts[0];
      final year = '20${expiryParts[1]}';
      
      // Prepare payment data
      final paymentData = {
        'card_number': _cardNumberController.text.replaceAll(' ', ''),
        'exp_month': month,
        'exp_year': year,
        'cvc': _cvvController.text,
        'save_card': _saveCard,
      };

      // Call payment processing
      final result = await _paymentController.paymentSubmit(
        widget.referenceId,
        'card', // Using generic 'card' method
        fromParcel: widget.fromParcel,
        cardData: paymentData,
      );

      setState(() => _isLoading = false);
      
      if (result.statusCode == 200) {
        Get.back(result: true); // Payment successful
      } else {
        String errorMessage = "An unknown error occurred.";
        if (result.body != null && result.body is Map<String, dynamic>) {
          if (result.body['errors'] != null && result.body['errors'] is List && result.body['errors'].isNotEmpty) {
            errorMessage = result.body['errors'][0]['message'];
          } else if (result.body['message'] != null) {
            errorMessage = result.body['message'];
          }
        }
        Get.snackbar('Payment Failed', errorMessage);
      }
    }
  }
}
