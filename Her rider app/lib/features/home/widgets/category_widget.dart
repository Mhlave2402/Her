import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/home/controllers/category_controller.dart';
import 'package:her_user_app/features/home/domain/models/category_model.dart';
import 'package:her_user_app/features/splash/controllers/config_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback? onTap;
  const CategoryWidget({super.key, required this.category, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Get.find<CategoryController>().updateVehicleType(category.name!),
      child: Padding(
        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
        child: Column(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                border: isSelected ? Border.all(color: Theme.of(context).primaryColor, width: 2) : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                child: category.image!.startsWith('http')
                    ? Image.network(
                        '${Get.find<ConfigController>().config!.imageBaseUrl}/category/${category.image}',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(category.image!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Text(
              category.name!,
              style: textMedium.copyWith(
                fontSize: Dimensions.fontSizeSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
