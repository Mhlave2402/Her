import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/wallet/controllers/wallet_controller.dart';

class TopUpDialog extends StatefulWidget {
  final String topUpMethod;

  const TopUpDialog({super.key, required this.topUpMethod});

  @override
  State<TopUpDialog> createState() => _TopUpDialogState();
}

class _TopUpDialogState extends State<TopUpDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Top Up with ${widget.topUpMethod}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.topUpMethod == "Gift Card"
              ? "Enter the gift card code:"
              : "Enter the amount to top up:"),
          TextFormField(
            controller: _textEditingController,
            keyboardType: widget.topUpMethod == "Gift Card"
                ? TextInputType.text
                : TextInputType.number,
            decoration: InputDecoration(
              hintText: widget.topUpMethod == "Gift Card" ? "Code" : "Amount",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (widget.topUpMethod == "Gift Card") {
              Get.find<WalletController>()
                  .redeemGiftCard(_textEditingController.text);
            } else {
              // In a real app, you would integrate a payment gateway here.
              // For this example, we'll just generate a dummy token.
              Get.find<WalletController>().topUpWithCard(
                  _textEditingController.text, "dummy_token");
            }
          },
          child: const Text("Top Up"),
        ),
      ],
    );
  }
}
