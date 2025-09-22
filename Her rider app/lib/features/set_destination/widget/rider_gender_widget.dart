import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';

class RiderGenderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const RiderGenderWidget({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: rideController.driverGender.name == title.toLowerCase() ?
            Theme.of(context).primaryColor.withOpacity(0.2) :
            Theme.of(context).hintColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            border: Border.all(color: rideController.driverGender.name == title.toLowerCase() ?
            Theme.of(context).primaryColor :
            Theme.of(context).hintColor.withOpacity(0.2), width: 1),
          ),
          child: Center(child: Text(title.tr, style: textMedium.copyWith(
            color: rideController.driverGender.name == title.toLowerCase() ?
            Theme.of(context).primaryColor :
            Theme.of(context).textTheme.bodyMedium!.color,
          ))),
        ),
      );
    });
  }
}
