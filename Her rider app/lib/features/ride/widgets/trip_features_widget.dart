import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/features/ride/domain/models/premium_feature_model.dart';
import 'package:her_user_app/features/ride/widgets/feature_card_widget.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/images.dart';

class TripFeaturesWidget extends StatelessWidget {
  const TripFeaturesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'trip_features'.tr,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: Dimensions.paddingSizeSmall,
            mainAxisSpacing: Dimensions.paddingSizeSmall,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureCardWidget(
                feature: PremiumFeature(name: 'Child Friendly', iconUrl: Images.childFriendly, surcharge: 0),
                isSelected: rideController.isChildFriendly,
                onTap: () => rideController.toggleChildFriendly(),
              ),
              FeatureCardWidget(
                feature: PremiumFeature(name: 'Nanny Ride', iconUrl: Images.nannyRide, surcharge: 0),
                isSelected: rideController.isNannyRide,
                onTap: () => rideController.toggleNannyRide(),
              ),
              FeatureCardWidget(
                feature: PremiumFeature(name: 'Kids Only', iconUrl: Images.kidsOnly, surcharge: 0),
                isSelected: rideController.isKidsOnly,
                onTap: () => rideController.toggleKidsOnly(),
              ),
              FeatureCardWidget(
                feature: PremiumFeature(name: 'Baby Seat', iconUrl: Images.babySeat, surcharge: 0),
                isSelected: rideController.isBabySeat,
                onTap: () => rideController.toggleBabySeat(),
              ),
              FeatureCardWidget(
                feature: PremiumFeature(name: 'Male Companion', iconUrl: Images.maleCompanion, surcharge: 0),
                isSelected: rideController.withMaleCompanion,
                onTap: () => rideController.toggleWithMaleCompanion(),
              ),
            ],
          ),
        ],
      );
    });
  }
}
