import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/profile/controllers/profile_controller.dart';
import 'package:her_driver_app/helper/price_converter.dart';
import 'package:her_driver_app/localization/localization_controller.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/styles.dart';

class ProfileLevelDetailsWidget extends StatelessWidget {
  const ProfileLevelDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController){
      return !profileController.levelModel!.data!.isCompleted! ?
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('upgrade_to_next_level'.tr),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        LinearProgressIndicator(value: _calculateProgressValue(
            _calculateTotalTargetPoint(
                profileController.levelModel?.data?.completedCurrentLevelTarget?.rideCompletePoint ?? 0,
                profileController.levelModel?.data?.completedCurrentLevelTarget?.earningAmountPoint ?? 0,
                profileController.levelModel?.data?.completedCurrentLevelTarget?.cancellationRatePoint ?? 0,
                profileController.levelModel?.data?.completedCurrentLevelTarget?.reviewGivenPoint ?? 0
            ),
            _calculateTotalTargetPoint(
                profileController.levelModel?.data?.currentLevel?.targetedRidePoint ?? 0,
                profileController.levelModel?.data?.currentLevel?.targetedAmountPoint ?? 0,
                profileController.levelModel?.data?.currentLevel?.targetedCancelPoint ?? 0,
                profileController.levelModel?.data?.currentLevel?.targetedReviewPoint ?? 0
            )
        ),
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          minHeight: Dimensions.paddingSizeSeven,
          backgroundColor: Theme.of(context).hintColor.withValues(alpha: 0.25),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        Align(
          alignment: Get.find<LocalizationController>().isLtr ?
          Alignment.centerLeft :
          Alignment.centerRight,
          child: Text.rich(TextSpan(children: [
            TextSpan(text:
            'earn_more'.tr,
              style: textRegular.copyWith(color: Theme.of(context).hintColor),
            ),
            TextSpan(text: ' ${_calculateTotalTargetPoint(
                profileController.levelModel?.data?.completedCurrentLevelTarget?.rideCompletePoint ?? 0,
                profileController.levelModel?.data?.completedCurrentLevelTarget?.earningAmountPoint ?? 0,
                profileController.levelModel?.data?.completedCurrentLevelTarget?.cancellationRatePoint ?? 0,
                profileController.levelModel?.data?.completedCurrentLevelTarget?.reviewGivenPoint ?? 0
            ).toInt()}/${_calculateTotalTargetPoint(
                profileController.levelModel?.data?.currentLevel?.targetedRidePoint ?? 0,
                profileController.levelModel?.data?.currentLevel?.targetedAmountPoint ?? 0,
                profileController.levelModel?.data?.currentLevel?.targetedCancelPoint ?? 0,
                profileController.levelModel?.data?.currentLevel?.targetedReviewPoint ?? 0
            ).toInt()} ',style: textRegular.copyWith(color: Theme.of(context).primaryColor)),
            TextSpan(
              text: 'point_for_next_level'.tr,
              style: textBold.copyWith(color: Theme.of(context).hintColor),
            ),
          ])),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        if(profileController.levelModel?.data?.nextLevel != null)
          Center(child: Text.rich(TextSpan(children: [
            TextSpan(text:'your_next_level_is'.tr),
            const TextSpan(text: ' '),
            TextSpan(text: profileController.levelModel?.data?.nextLevel?.name,
              style: textBold,
            )
          ]))),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              border: Border.all(color: Theme.of(context).hintColor.withValues(alpha: 0.25))
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if((profileController.levelModel?.data?.currentLevel?.targetedRide?.toInt() ?? 0 )> 0)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('trips_completed'.tr,style: textRegular.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium!.color
                )),

                Text('${profileController.levelModel?.data?.completedCurrentLevelTarget?.rideComplete?.toInt()}/'
                    '${profileController.levelModel?.data?.currentLevel?.targetedRide?.toInt()}',
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),
                ),
              ]),

            if((profileController.levelModel?.data?.currentLevel?.targetedRide?.toInt() ?? 0 )> 0)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  '${profileController.levelModel?.data?.completedCurrentLevelTarget?.
                  rideCompletePoint?.toInt()} ${'points'.tr}',
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),
                ),

                SizedBox(width: Get.width * 0.3, child: LinearProgressIndicator(
                  value: _calculateProgressValue(
                    profileController.levelModel?.data?.completedCurrentLevelTarget?.rideComplete ?? 0,
                    profileController.levelModel?.data?.currentLevel?.targetedRide ?? 0,
                  ),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  minHeight: Dimensions.paddingSizeSeven,
                  backgroundColor: Theme.of(context).hintColor.withValues(alpha: 0.25),
                ))
              ]),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            if((profileController.levelModel?.data?.currentLevel?.targetedReview?.toInt() ?? 0 )> 0)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('review_given'.tr,style: textRegular.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium!.color
                )),

                Text('${profileController.levelModel?.data?.completedCurrentLevelTarget?.reviewGiven?.toInt()}/'
                    '${profileController.levelModel?.data?.currentLevel?.targetedReview?.toInt()}',
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),
                )
              ]),

            if((profileController.levelModel?.data?.currentLevel?.targetedReview?.toInt() ?? 0 )> 0)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('${profileController.levelModel?.data?.completedCurrentLevelTarget?.
                reviewGivenPoint?.toInt()} ${'points'.tr}',
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),
                ),

                SizedBox(width: Get.width * 0.3, child: LinearProgressIndicator(
                  value: _calculateProgressValue(
                      profileController.levelModel?.data?.completedCurrentLevelTarget?.reviewGiven ?? 0,
                      profileController.levelModel?.data?.currentLevel?.targetedReview ?? 0
                  ),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  minHeight: Dimensions.paddingSizeSeven,
                  backgroundColor: Theme.of(context).hintColor.withValues(alpha: 0.25),
                ))
              ]),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            if((profileController.levelModel?.data?.currentLevel?.targetedCancel?.toInt() ?? 0 )> 0)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('maximum_cancellation_rate'.tr,style: textRegular.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium!.color
                )),

                Text('${profileController.levelModel?.data?.completedCurrentLevelTarget?.cancellationRate?.toInt()}/'
                    '${profileController.levelModel?.data?.currentLevel?.targetedCancel?.toInt()}',
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),
                )
              ]),

            if((profileController.levelModel?.data?.currentLevel?.targetedCancel?.toInt() ?? 0 )> 0)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('${profileController.levelModel?.data?.completedCurrentLevelTarget?.
                cancellationRatePoint?.toInt()} ${'points'.tr}',
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),
                ),

                SizedBox(width: Get.width * 0.3, child: LinearProgressIndicator(
                  value: _calculateProgressValue(
                    profileController.levelModel?.data?.currentLevel?.targetedCancel ?? 0,
                    (profileController.levelModel?.data?.completedCurrentLevelTarget?.cancellationRate ?? 0) == 0 ?
                    1 :
                    profileController.levelModel?.data?.completedCurrentLevelTarget?.cancellationRate ?? 1,
                  ),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  minHeight: Dimensions.paddingSizeSeven,
                  backgroundColor: Theme.of(context).hintColor.withValues(alpha: 0.25),
                ))
              ]),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            if((profileController.levelModel?.data?.currentLevel?.targetedAmount?.toInt() ?? 0 )> 0)
              Text('minimum_earned'.tr,style: textRegular.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium!.color
              )),

            if((profileController.levelModel?.data?.currentLevel?.targetedAmount?.toInt() ?? 0 )> 0)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('${profileController.levelModel?.data?.completedCurrentLevelTarget?.
                earningAmountPoint?.toInt()} ${'points'.tr}',
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),
                ),

                Text(
                  '${PriceConverter.convertPrice(
                      context,
                      profileController.levelModel?.data?.completedCurrentLevelTarget?.earningAmount ?? 0)} of '
                      '${PriceConverter.convertPrice(
                      context,
                      profileController.levelModel?.data?.currentLevel?.targetedAmount ?? 0)}',
                  style: textRobotoRegular.copyWith(color: Theme.of(context).primaryColor),
                ),
              ]),
          ]),
        )
      ]) :
      Text('you_reached_the_maximum_level'.tr, style: textBold);
    });
  }

  double _calculateTotalTargetPoint(
      double targetedRidePoint,double targetedAmountPoint,
      double targetedCancelPoint, double targetedReviewPoint){
    return targetedRidePoint + targetedAmountPoint + targetedCancelPoint + targetedReviewPoint;
  }

  double _calculateProgressValue(double completeValue, double targetValue){
    return (1 / targetValue) * completeValue;
  }
}
