import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/giftcard/controllers/gift_card_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';
import 'package:her_user_app/common_widgets/app_bar_widget.dart';
import 'package:her_user_app/common_widgets/body_widget.dart';
import 'package:her_user_app/common_widgets/button_widget.dart';
import 'package:her_user_app/common_widgets/custom_text_field.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.find<GiftCardController>().getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        appBar: AppBarWidget(
          title: 'gift_card'.tr,
          onBackPressed: () => Get.back(),
        ),
        body: GetBuilder<GiftCardController>(builder: (giftCardController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              children: [
                Text(
                  '${'balance'.tr}: ${giftCardController.balance}',
                  style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                CustomTextField(
                  controller: _codeController,
                  hintText: 'enter_gift_card_code'.tr,
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                ButtonWidget(
                  buttonText: 'redeem'.tr,
                  onPressed: () {
                    giftCardController.redeemGiftCard(_codeController.text.trim());
                  },
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                TextButton(
                  onPressed: () {
                    giftCardController.navigateToGiftCardListScreen();
                  },
                  child: Text('view_redeemed_cards'.tr),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
