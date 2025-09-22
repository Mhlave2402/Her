import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/giftcard/controllers/gift_card_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/common_widgets/app_bar_widget.dart';
import 'package:her_user_app/common_widgets/body_widget.dart';

class GiftCardListScreen extends StatefulWidget {
  const GiftCardListScreen({super.key});

  @override
  State<GiftCardListScreen> createState() => _GiftCardListScreenState();
}

class _GiftCardListScreenState extends State<GiftCardListScreen> {
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
          title: 'redeemed_cards'.tr,
          onBackPressed: () => Get.back(),
        ),
        body: GetBuilder<GiftCardController>(builder: (giftCardController) {
          return ListView.builder(
            itemCount: giftCardController.giftCards.length,
            itemBuilder: (context, index) {
              final giftCard = giftCardController.giftCards[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.card_giftcard),
                  title: Text(giftCard.code!),
                  subtitle: Text('Amount: ${giftCard.amount}'),
                  trailing: Text('Expires at: ${giftCard.expiresAt}'),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
