import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/home/widgets/vehicle_category_selector_widget.dart';
import 'package:her_user_app/features/set_destination/screens/set_destination_screen.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';

class HomeFloatingWidget extends StatelessWidget {
  const HomeFloatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusExtraLarge)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => Get.to(() => const SetDestinationScreen()),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeLarge,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                      'where_to'.tr,
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            const VehicleCategorySelectorWidget(),
          ],
        ),
      ),
    );
  }
}
