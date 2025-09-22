import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/home/controllers/category_controller.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/common_widgets/category_widget.dart';

class RideCategoryWidget extends StatelessWidget {
  final Function(void)? onTap;
  const RideCategoryWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return GetBuilder<CategoryController>(builder: (categoryController) {
        if (categoryController.categoryList == null) {
          return Center(child: SpinKitCircle(color: Theme.of(context).primaryColor, size: 40.0));
        }

        final filteredList = categoryController.categoryList!
            .where((category) => category.type == categoryController.vehicleType)
            .toList();

        return filteredList.isNotEmpty
            ? SizedBox(
                height: 220,
                width: Get.width,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: filteredList.length,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CategoryWidget(
                          index: index,
                          fromSelect: true,
                          category: filteredList[index],
                          isSelected: rideController.rideCategoryIndex == index,
                          onTap: onTap,
                        ),
                      );
                    }),
              )
            : Center(child: Text('no_vehicles_found'.tr));
      });
    });
  }
}
