import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/image_widget.dart';
import 'package:ride_sharing_user_app/features/ride/domain/models/trip_details_model.dart';
import 'package:ride_sharing_user_app/features/ride/widgets/fare_widget.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/config_controller.dart';
import 'package:ride_sharing_user_app/helper/date_converter.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';


class TripDetailsTopSectionWidget extends StatelessWidget {
  final TripDetails? tripDetails;
  const TripDetailsTopSectionWidget({super.key, required this.tripDetails});

  @override
  Widget build(BuildContext context) {
    String? pickupTime = tripDetails?.type == 'parcel' ? tripDetails?.parcelStartTime : tripDetails?.rideStartTime;
    String? dropOfTime = tripDetails?.type == 'parcel' ? tripDetails?.parcelCompleteTime : tripDetails?.rideCompleteTime;

    return Column(children: [
      Container(
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
            boxShadow: [BoxShadow(
              color: Theme.of(context).hintColor.withValues(alpha: 0.2),
              blurRadius: 6,
            )]
        ),
        child: Column(spacing: Dimensions.paddingSizeSmall, children: [
          Stack(children: [
            Container(width: 80, height: Get.height * 0.105,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha:0.04) ,
              ),
              child: Center(child: Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    child: tripDetails?.type != 'parcel' ?
                    ImageWidget(
                      width: 60, height: 60,
                      image : '${Get.find<ConfigController>().config!.imageBaseUrl!.vehicleCategory!}/${tripDetails?.vehicleCategory?.image!}',
                      fit: BoxFit.cover,
                    ) :
                    Image.asset(Images.parcel,height: 60,width: 30)
                ),

                Text(
                  tripDetails?.type != 'parcel' ?
                  tripDetails?.vehicleCategory != null ?
                  tripDetails?.vehicleCategory?.name ?? '' : '' :
                  'parcel'.tr,
                  style: textMedium.copyWith(
                    fontSize: Dimensions.fontSizeExtraSmall,
                    color: Theme.of(context).textTheme.bodyMedium!.color!.withValues(alpha:0.8),
                  ),
                ),
              ])),
            ),

            Positioned(
              right: 0,
              child: Container(
                height: 20,width: 20,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: tripDetails?.currentStatus == 'cancelled' ?
                    Theme.of(context).colorScheme.error.withValues(alpha:0.15) :
                    tripDetails?.currentStatus == 'completed' ?
                    Theme.of(context).colorScheme.surfaceTint.withValues(alpha:0.15) :
                    tripDetails?.currentStatus == 'returning' ?
                    Theme.of(context).colorScheme.surfaceContainer.withValues(alpha:0.15) :
                    tripDetails?.currentStatus == 'returned' ?
                    Theme.of(context).colorScheme.surfaceTint.withValues(alpha:0.15) :
                    Theme.of(context).colorScheme.tertiaryContainer.withValues(alpha:0.3) ,
                    shape: BoxShape.circle
                ),
                child: tripDetails?.currentStatus == 'cancelled' ?
                Image.asset(Images.crossIcon,color: Theme.of(context).colorScheme.error) :
                tripDetails?.currentStatus == 'completed' ?
                Image.asset(Images.selectedIcon,color: Theme.of(context).colorScheme.surfaceTint) :
                tripDetails?.currentStatus == 'returning' ?
                Image.asset(Images.returnIcon,color: Theme.of(context).colorScheme.surfaceContainer) :
                tripDetails?.currentStatus == 'returned' ?
                Image.asset(Images.returnIcon,color: Theme.of(context).colorScheme.surfaceTint) :
                Image.asset(Images.ongoingMarkerIcon,color: Theme.of(context).colorScheme.tertiaryContainer),
              ),
            )
          ]),

          if(tripDetails?.type == 'scheduled_request' && tripDetails?.currentStatus == 'pending')
            RichText(text: TextSpan(
              text: 'your_scheduled_trip_has_been'.tr,
              children: [
                TextSpan(text: ' ${'created'.tr}. ', style: textSemiBold.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color)),
                TextSpan(text: 'please_wait_for_a_driver_to_start'.tr)
              ],style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withValues(alpha: 0.7)),
            ),textAlign: TextAlign.center)
          else
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('your_trip_has_been'.tr, style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7))),

              Text((tripDetails?.currentStatus ?? '').tr, style: textRegular.copyWith(
                  color:tripDetails?.currentStatus == 'cancelled' ?
                  Theme.of(context).colorScheme.error : Theme.of(context).textTheme.bodyMedium?.color,
              )),
            ])
        ]),
      ),
      const SizedBox(height: Dimensions.paddingSizeExtraSmall),

      Text(_isShownPaidFare(tripDetails) ? 'your_trip_cost'.tr : 'estimated_trip_cost'.tr, style: textSemiBold.copyWith(
          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
          fontSize: Dimensions.fontSizeSmall
      )),

      Text(
        PriceConverter.convertPrice(
          _isShownPaidFare(tripDetails) ?
          tripDetails!.paidFare! :
          ( tripDetails!.discountActualFare! > 0 ? tripDetails!.discountActualFare! : tripDetails!.actualFare!),
        ),
        style: textSemiBold.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: Dimensions.fontSizeOverLarge
        ),
      ),

      if(tripDetails?.type == AppConstants.scheduleRequest && (tripDetails?.currentStatus == AppConstants.pending || tripDetails?.currentStatus == AppConstants.accepted))
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeThree)
          ),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeThree),
          child: Text(
            '${'pickup_time'.tr} : ${DateConverter.tripDetailsShowFormat(tripDetails?.scheduledAt ?? '')}',
            style: textRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7) ,
            ),
          ),
        )
      else
        Text(
          DateConverter.stringToLocalDateOnly(tripDetails!.createdAt!),
          style: textRegular.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7) ,
          ),
        ),
      const SizedBox(height: Dimensions.paddingSizeSmall),

      if(pickupTime != null || dropOfTime != null)
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
          color: Theme.of(context).hintColor.withValues(alpha:0.08),
        ),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: IntrinsicHeight(
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            if(pickupTime != null)...[
              FareWidget(
                  title: 'pickup_time'.tr,
                  value: DateConverter.stringDateTimeToTimeOnly(pickupTime)
              ),

              if(dropOfTime != null)
              VerticalDivider(color: Theme.of(context).hintColor.withValues(alpha: 0.5))
            ],

            if(dropOfTime != null)
            FareWidget(
                title: 'drop_off_time'.tr,
                value: DateConverter.stringDateTimeToTimeOnly(dropOfTime)
            ),
          ]),
        ),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: Dimensions.iconSizeMedium,
          child: Image.asset(Images.distanceCalculated, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7)),
        ),
        const SizedBox(width: Dimensions.paddingSizeExtraSmall),

        Text(_isShownPaidFare(tripDetails) ? 'total_distance'.tr : 'estimated_distance'.tr, style: textRegular.copyWith(
          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha:0.7),
        )),

        Text(' - ${_isShownPaidFare(tripDetails) ?  tripDetails?.actualDistance : tripDetails?.estimatedDistance}km',
          style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color),
        ),
      ])

    ]);
  }
}

bool _isShownPaidFare(TripDetails? tripDetails){
  return (
      tripDetails?.currentStatus == 'cancelled' || tripDetails?.currentStatus == 'completed' ||
      (tripDetails?.parcelInformation?.payer == 'sender' && tripDetails?.currentStatus == 'ongoing') ||
      tripDetails?.currentStatus == 'returning' || tripDetails?.currentStatus == 'returned'
  ) ? true : false;
}