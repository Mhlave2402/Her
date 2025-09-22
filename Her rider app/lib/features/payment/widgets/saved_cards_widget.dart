import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/common_widgets/custom_button.dart';
import 'package:her_user_app/features/payment/controllers/payment_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/images.dart';
import 'package:her_user_app/util/styles.dart';

class SavedCardsWidget extends StatefulWidget {
  final Function(String) onCardSelected;

  const SavedCardsWidget({
    super.key,
    required this.onCardSelected,
  });

  @override
  State<SavedCardsWidget> createState() => _SavedCardsWidgetState();
}

class _SavedCardsWidgetState extends State<SavedCardsWidget> {
  final PaymentController _paymentController = Get.find();
  String? _selectedCardId;

  @override
  void initState() {
    super.initState();
    _paymentController.getSavedCards();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _paymentController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved Cards',
                  style: fontSizeMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                
                // Saved cards list
                ..._paymentController.savedCards.map((card) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    child: ListTile(
                      leading: _getCardIcon(card['brand']),
                      title: Text('**** **** **** ${card['last4']}'),
                      subtitle: Text('Exp: ${card['exp_month']}/${card['exp_year']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (card['is_default'])
                            const Icon(Icons.star, color: Colors.amber),
                          if (_selectedCardId == card['id'])
                            const Icon(Icons.check_circle, color: Colors.green),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'setDefault') {
                                _paymentController.setDefaultCard(card['id']);
                              } else if (value == 'remove') {
                                _paymentController.removeCard(card['id']);
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'setDefault',
                                child: Text('Set as Default'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'remove',
                                child: Text('Remove'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() => _selectedCardId = card['id']);
                        widget.onCardSelected(card['id']!);
                      },
                    ),
                  );
                }).toList(),
                
                const SizedBox(height: Dimensions.paddingSizeLarge),
                
                // Use selected card button
                CustomButton(
                  buttonText: 'Use Selected Card',
                  onPressed: _selectedCardId == null ? null : () {
                    widget.onCardSelected(_selectedCardId!);
                    Get.back();
                  },
                ),
                
                const SizedBox(height: Dimensions.paddingSizeDefault),
                
                // Add new card option
                TextButton(
                  onPressed: () => Get.to(() => const CardPaymentScreen(
                    amount: 0, // Will be set in context
                    referenceId: '', // Will be set in context
                  )),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Text(
                        'Add New Card',
                        style: fontSizeMedium.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            );
    });
  }

  Widget _getCardIcon(String? brand) {
    switch (brand?.toLowerCase()) {
      case 'visa':
        return Image.asset(Images.visa, width: 40, height: 25);
      case 'mastercard':
        return Image.asset(Images.mastercard, width: 40, height: 25);
      case 'amex':
        return Image.asset(Images.amex, width: 40, height: 25);
      default:
        return const Icon(Icons.credit_card, size: 40);
    }
  }
}
