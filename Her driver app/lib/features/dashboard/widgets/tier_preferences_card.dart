import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/profile/controllers/profile_controller.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/styles.dart';

class TierPreferencesCard extends StatelessWidget {
  const TierPreferencesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('tier_preferences'.tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              if (profileController.tierList.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileController.tierList.length,
                  itemBuilder: (context, index) {
                    final tier = profileController.tierList[index];
                    return _buildTierToggle(
                      context,
                      tier,
                      profileController.globalPrefs[tier] ?? false,
                      (value) {
                        profileController.updateGlobalTierPreference(tier, value);
                      },
                      isRegisteredTier: tier == profileController.registeredTier,
                    );
                  },
                ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Text('per_vehicle_settings'.tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              if (profileController.vehicles.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileController.vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = profileController.vehicles[index];
                    return _buildVehicleTierToggles(context, vehicle, profileController);
                  },
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTierToggle(BuildContext context, String tier, bool value, ValueChanged<bool> onChanged, {bool isRegisteredTier = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tier.tr, style: textRegular),
        Switch(
          value: value,
          onChanged: isRegisteredTier ? null : onChanged,
        ),
      ],
    );
  }

  Widget _buildVehicleTierToggles(BuildContext context, dynamic vehicle, ProfileController profileController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(vehicle['plate'], style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profileController.tierList.length,
          itemBuilder: (context, index) {
            final tier = profileController.tierList[index];
            return _buildTierToggle(
              context,
              tier,
              profileController.perVehiclePrefs[vehicle['id'].toString()]?[tier] ?? false,
              (value) {
                profileController.updatePerVehicleTierPreference(vehicle['id'].toString(), tier, value);
              },
              isRegisteredTier: tier == vehicle['vehicle_tier'],
            );
          },
        ),
      ],
    );
  }
}
