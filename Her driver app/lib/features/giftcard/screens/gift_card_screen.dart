import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/giftcard/controllers/gift_card_controller.dart';
import 'package:her_driver_app/common_widgets/app_bar_widget.dart';
import 'package:her_driver_app/common_widgets/body_widget.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<GiftCardController>().getGiftCardList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        appBar: AppBarWidget(
          title: 'gift_cards'.tr,
          onBackPressed: () => Get.back(),
        ),
        body: GetBuilder<GiftCardController>(builder: (giftCardController) {
          return ListView.builder(
            itemCount: giftCardController.giftCards.length,
            itemBuilder: (context, index) {
              final giftCard = giftCardController.giftCards[index];
              return ListTile(
                title: Text(giftCard.code!),
                subtitle: Text('Amount: ${giftCard.amount}'),
                trailing: Text('Expires at: ${giftCard.expiresAt}'),
              );
            },
          );
        }),
      ),
    );
  }
}
