import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';

class PayShortfallWidget extends StatelessWidget {
  const PayShortfallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return rideController.shortfallTrip != null
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF231f20),
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'please_pay_shortfall'.tr,
                    style: textRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Text(
                    '${rideController.shortfallTrip!.shortfallAmount}',
                    style: textBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        rideController.payShortfall();
                      },
                      child: Text('pay_now'.tr),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox();
    });
  }
}
