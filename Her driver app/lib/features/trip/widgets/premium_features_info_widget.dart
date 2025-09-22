import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/ride/controllers/ride_controller.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/styles.dart';

class PremiumFeaturesInfoWidget extends StatelessWidget {
  final RideController rideController;
  const PremiumFeaturesInfoWidget({super.key, required this.rideController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (rideController.tripDetail?.premiumFeatures != null &&
            rideController.tripDetail!.premiumFeatures!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeSmall,
            ),
            child: Text(
              'premium_features'.tr,
              style: textRegular.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
        if (rideController.tripDetail?.premiumFeatures != null)
          ...rideController.tripDetail!.premiumFeatures!.map((feature) {
            return FeatureInfo(
              icon: feature.iconUrl,
              title: feature.name,
            );
          }).toList(),
      ],
    );
  }
}
>>>>>>> Stashed changes

class FeatureInfo extends StatelessWidget {
  final String icon;
  final String title;
  const FeatureInfo({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
        vertical: Dimensions.paddingSizeExtraSmall,
      ),
      child: Row(
        children: [
          Image.network(icon, width: 20, height: 20),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text(
            title,
            style: textRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
            ),
          ),
        ],
      ),
    );
  }
}
