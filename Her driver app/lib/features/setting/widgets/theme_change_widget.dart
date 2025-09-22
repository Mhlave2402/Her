import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/theme/theme_controller.dart';
import 'package:her_driver_app/util/dimensions.dart';

class ThemeChangeWidget extends StatelessWidget {
  const ThemeChangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController){
      return Padding(
        padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
            onTap: ()=>themeController.changeThemeSetting(false),
            child: Row(children: [
              Container(height: 15, width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).hintColor.withValues(alpha: 0.2),
                ),
                child:  !themeController.darkTheme ?
                Center(
                  child: Icon(Icons.circle,size: 10,color: Theme.of(context).textTheme.bodyLarge!.color),
                ) :
                const SizedBox.shrink(),
              ),
              const SizedBox(width: 7),

              Text('light'.tr),
            ]),
          ),
          const SizedBox(width: Dimensions.paddingSizeLarge),

          InkWell(
            onTap: ()=>themeController.changeThemeSetting(true),
            child: Row(children: [
              Container(height: 15, width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).hintColor.withValues(alpha: 0.2),
                ),
                child:  themeController.darkTheme ?
                Center(
                  child: Icon(Icons.circle,size: 10,color: Theme.of(context).textTheme.bodyMedium!.color),
                ) :
                const SizedBox.shrink(),
              ),
              const SizedBox(width: 7),

              Text('dark'.tr),
            ]),
          ),
        ]),
      );
    });
  }
}
