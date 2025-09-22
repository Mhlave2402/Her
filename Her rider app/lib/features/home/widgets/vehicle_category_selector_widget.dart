import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/home/controllers/category_controller.dart';
import 'package:her_user_app/features/home/domain/models/category_model.dart';
import 'package:her_user_app/features/home/widgets/category_widget.dart';
import 'package:her_user_app/features/set_destination/screens/set_destination_screen.dart';

class VehicleCategorySelectorWidget extends StatelessWidget {
  const VehicleCategorySelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (categoryController) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryWidget(
              category: CategoryModel(name: 'car', image: 'assets/image/car.png'), // Replace with actual asset path
              isSelected: categoryController.vehicleType == 'car',
              onTap: () {
                categoryController.setVehicleType('car');
                Get.to(() => const SetDestinationScreen());
              },
            ),
            CategoryWidget(
              category: CategoryModel(name: 'bike', image: 'assets/image/bike.png'), // Replace with actual asset path
              isSelected: categoryController.vehicleType == 'bike',
              onTap: () {
                categoryController.setVehicleType('bike');
                Get.to(() => const SetDestinationScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
