import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/help_and_support/screens/help_and_support_screen.dart';
import 'package:her_driver_app/features/notification/controllers/notification_controller.dart';
import 'package:her_driver_app/features/refer_and_earn/controllers/refer_and_earn_controller.dart';
import 'package:her_driver_app/features/refer_and_earn/screens/refer_and_earn_screen.dart';
import 'package:her_driver_app/features/ride/screens/ride_request_list_screen.dart';
import 'package:her_driver_app/features/trip/screens/trip_details_screen.dart';
import 'package:her_driver_app/helper/date_converter.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/images.dart';
import 'package:her_driver_app/util/styles.dart';
import 'package:her_driver_app/features/notification/domain/models/notification_model.dart';

class NotificationCardWidget extends StatelessWidget {
  final Notifications notification;
  final Notifications? previousNotification;
  final Notifications? nextNotification;
  final int? index;
  const NotificationCardWidget({super.key, required this.notification, required this.nextNotification, required this.previousNotification, this.index});

  @override
  Widget build(BuildContext context) {
    int currentNotificationMinutes = calculateMinute(notification.createdAt!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: InkWell(
        onTap: () {
          Get.find<NotificationController>().sendReadStatus(notification.id ?? 0, index ?? 0);

          if(notification.action == 'new_ride_request' || notification.action == 'new_parcel_request'){
            Get.to(()=> RideRequestScreen());

          }else{
            Get.bottomSheet(Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.paddingSizeLarge),
                  topRight: Radius.circular(Dimensions.paddingSizeLarge),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(mainAxisSize: MainAxisSize.min,children: [
                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  Container(
                    padding: const EdgeInsets.all(Dimensions.paddingSize),
                    margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    ),
                    child: Image.asset(
                      _getIcons(notification.notificationType ?? ''),
                      width: 20,height: 20,
                      fit: BoxFit.cover,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Text(notification.title ?? '',style: textBold,textAlign: TextAlign.center),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Text(
                    notification.description ?? '',textAlign: TextAlign.center,
                    style: textRegular.copyWith(color: Theme.of(context).hintColor),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  InkWell(
                      onTap: ()=> _navigateOnclickRoute(notification.action ?? '', notification.rideRequestId ?? ''),
                      child: Text(
                        _getNotificationButtonText(notification.action ?? ''),
                        style: textRegular.copyWith(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                      )
                  ),

                  const SizedBox(height: 30),
                ]),
              ),
            ));
          }
        },
        child: Column(children: [
          if(previousNotification == null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              child: Text(DateConverter.isoStringToLocalDateAndMonthOnly(notification.createdAt!) ==  DateConverter.localDateTimeToDateAndMonthOnly(DateTime.now()) ?
              'today'.tr :
              DateConverter.isoStringToLocalDateAndMonthOnly(notification.createdAt!) ==  DateConverter.localDateTimeToDateAndMonthOnly(DateTime.now().subtract(const Duration(days: 1))) ?
              'last_day'.tr :
              DateConverter.isoDateTimeStringToDateOnly(notification.createdAt!)),
            ),

          Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode ?
              Theme.of(context).scaffoldBackgroundColor :
              Theme.of(context).hintColor.withValues(alpha: 0.07),
              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeLarge,
            ),
            margin: const EdgeInsets.symmetric(vertical: 2),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(Dimensions.paddingSize),
                margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  color: Get.isDarkMode ?
                  Theme.of(context).scaffoldBackgroundColor :
                  Theme.of(context).primaryColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                ),
                child: Image.asset(
                  _getIcons(notification.notificationType ?? ''),
                  width: 20,height: 20,
                  fit: BoxFit.cover,
                  color: Get.isDarkMode ? Theme.of(context).textTheme.bodyMedium!.color : Theme.of(context).primaryColor,
                ),
              ),

              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(right: Dimensions.paddingSizeExtraLarge),
                      child: Text(notification.title ?? '',
                        style: (notification.isRead ?? false) ? textRegular : textBold,
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                      ),
                    )),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [
                        Text(
                          currentNotificationMinutes < 60 ?
                          '$currentNotificationMinutes ${'min_ago'.tr}' :
                          DateConverter.isoDateTimeStringToLocalTime(notification.createdAt!),
                          style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: (notification.isRead ?? false) ? null : Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                        Icon(
                          Icons.alarm,
                          size: Dimensions.fontSizeLarge,
                          color: Theme.of(context).hintColor.withValues(alpha: 0.5),
                        ),
                      ]),
                    ),
                  ]),

                  Text(
                      notification.description ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    style: textRegular.copyWith(color: (notification.isRead ?? false) ?Theme.of(context).hintColor : null),
                  ),

                ]),
              ),
            ]),
          ),

          if(((nextNotification == null) && (previousNotification != null) &&
              (DateConverter.isoStringToLocalDateAndMonthOnly(notification.createdAt!) != DateConverter.isoStringToLocalDateAndMonthOnly(previousNotification!.createdAt!))))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              child: Text(DateConverter.isoStringToLocalDateAndMonthOnly(notification.createdAt!) ==  DateConverter.localDateTimeToDateAndMonthOnly(DateTime.now().subtract(const Duration(days: 1))) ?
              'last_day'.tr :
              DateConverter.isoDateTimeStringToDateOnly(notification.createdAt ?? '2024-07-13T04:59:40.000000Z')),
            ),

          if((nextNotification != null) &&
              (DateConverter.isoStringToLocalDateAndMonthOnly(notification.createdAt!) != DateConverter.isoStringToLocalDateAndMonthOnly(nextNotification!.createdAt!)))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              child: Text(DateConverter.isoStringToLocalDateAndMonthOnly(nextNotification!.createdAt!) ==  DateConverter.localDateTimeToDateAndMonthOnly(DateTime.now().subtract(const Duration(days: 1))) ?
              'last_day'.tr :
              DateConverter.isoDateTimeStringToDateOnly(nextNotification?.createdAt ?? '2024-07-13T04:59:40.000000Z')),
            ),
        ]),
      ),
    );
  }

  void _navigateOnclickRoute(String action,String tripId){
    if(action == 'referral_reward_received'){
      Get.find<ReferAndEarnController>().setReferralTypeIndex(1);
      Get.to(() => const ReferAndEarnScreen());
    }else if(action == 'debited_from_wallet' || action == 'parcel_refund_request'){
      Get.to(() => TripDetails(tripId: tripId));
    }else{
      Get.to(() => const HelpAndSupportScreen());
    }
  }

  String _getNotificationButtonText(String action){
    final actionMap = {
      'referral_reward_received': 'earning_history'.tr,
      'debited_from_wallet': 'parcel_details'.tr,
      'parcel_refund_request': 'parcel_details'.tr,
      'parcel_refund_request_approved': 'help_and_support'.tr,
    };

    return actionMap[action] ?? '';
  }
}

String _getIcons(String notificationType){
  switch (notificationType) {
    case 'trip':
      return Images.notificationTripIcon;

    case 'parcel':
      return Images.notificationParcelIcon;

    case 'coupon':
      return Images.notificationCouponIcon;

    case 'review':
      return Images.notificationReviewIcon;

    case 'referral_code':
      return Images.notificationReferralIcon;

    case 'safety_alert':
      return Images.notificationSafetyAlertIcon;

    case 'business_page':
      return Images.notificationBusinessIcon;

    case 'chatting':
      return Images.notificationChattingIcon;

    case 'level':
      return Images.notificationLevelIcon;

    case 'fund':
      return Images.notificationFundIcon;

    case 'withdraw_request':
      return Images.notificationWalletIcon;

    default:
      return Images.notificationOthersIcon;
  }

}


int calculateMinute(String isoDateTime){
  DateTime dateTime = DateConverter.isoStringToLocalDate(isoDateTime);
  return DateTime.now().difference(dateTime).inMinutes;
}
