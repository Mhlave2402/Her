import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/ride/controllers/ride_controller.dart';
import 'package:her_driver_app/features/splash/controllers/config_controller.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/styles.dart';
import 'package:her_driver_app/common_widgets/image_widget.dart';

class VehicleDetailsWidget extends StatelessWidget {
  final RideController rideController;
  const VehicleDetailsWidget({super.key, required this.rideController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        border: Border.all(width: .75, color: Theme.of(context).hintColor.withAlpha(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: rideController.tripDetail?.vehicle != null
            ? Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    rideController.tripDetail!.vehicle!.model!.name!,
                    style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyMedium?.color),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text.rich(
                    overflow: TextOverflow.ellipsis,
                    TextSpan(
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyMedium!.color!.withAlpha(178),
                      ),
                      children: [
                        TextSpan(
                          text: rideController.tripDetail!.vehicle!.licencePlateNumber,
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                        ),
                        TextSpan(
                          text: " (${rideController.tripDetail!.vehicle!.color})",
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                        ),
                      ],
                    ),
                  ),
                ]),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    color: Theme.of(context).hintColor.withAlpha(64),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeThree),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
                    child: ImageWidget(
                      height: 50,
                      width: 50,
                      image: rideController.tripDetail!.vehicle != null
                          ? '${Get.find<ConfigController>().config!.imageBaseUrl!.vehicleModel!}/${rideController.tripDetail!.vehicle!.model!.image!}'
                          : '',
                    ),
                  ),
                ),
              ])
            : const SizedBox(),
      ),
    );
  }
}
