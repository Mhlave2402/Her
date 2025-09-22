import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/home/controllers/category_controller.dart';
import 'package:her_user_app/features/parcel/screens/parcel_screen.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/features/set_destination/screens/set_destination_screen.dart';
import 'package:her_user_app/features/splash/controllers/config_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/images.dart';
import 'package:her_user_app/util/styles.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (categoryController) {
      return SizedBox(
        height: 105,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCategoryItem(
              context,
              'bike'.tr,
              Images.bike,
              () {
                categoryController.updateVehicleType('bike');
                Get.to(() => const SetDestinationScreen(rideType: RideType.ride));
              },
            ),
            _buildCategoryItem(
              context,
              'car'.tr,
              Images.car,
              () {
                categoryController.updateVehicleType('car');
                Get.to(() => const SetDestinationScreen(rideType: RideType.ride));
              },
            ),
            _buildCategoryItem(
              context,
              'parcel'.tr,
              Images.parcel,
              () => Get.to(() => const ParcelScreen()),
            ),
            if (Get.find<ConfigController>().config?.scheduleTripStatus ?? false)
              _buildCategoryItem(
                context,
                'schedule_trip'.tr,
                Images.scheduleTripIcon,
                () => Get.to(() => const SetDestinationScreen(rideType: RideType.scheduleRide)),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildCategoryItem(BuildContext context, String title, String image, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 75,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).hintColor.withOpacity(0.15),
            ),
            margin: const EdgeInsets.only(bottom: 5),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Image.asset(image),
            ),
          ),
          Text(
            title,
            style: textSemiBold.copyWith(
              color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
              fontSize: Dimensions.fontSizeSmall,
            ),
          ),
        ],
      ),
    );
  }
}
