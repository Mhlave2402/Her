import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/setting/widgets/language_select_bottomsheet.dart';
import 'package:her_driver_app/localization/localization_controller.dart';
import 'package:her_driver_app/theme/theme_controller.dart';
import 'package:her_driver_app/util/app_constants.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/images.dart';
import 'package:her_driver_app/util/styles.dart';
import 'package:her_driver_app/features/setting/controllers/setting_controller.dart';
import 'package:her_driver_app/common_widgets/app_bar_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  void initState() {
    Get.find<LocalizationController>().setInitialIndex();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    String languageName = '';
    AppConstants.languages.any((element){
      if(element.languageCode == Get.find<LocalizationController>().locale.languageCode ){
        languageName = element.languageName;
        return true;
      }
      return false;
    });
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarWidget(title: 'setting'.tr, regularAppbar: true),
        body: GetBuilder<SettingController>(builder: (settingController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeLarge),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSize,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSize),
                    border: Border.all(color: Theme.of(context).hintColor, width: .5)
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    Image.asset(Images.languageIcon,scale: 2),

                    const SizedBox(width: Dimensions.paddingSizeLarge),
                    Text('language'.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    )),
                  ]),

                  InkWell(
                    onTap: (){
                      showModalBottomSheet(isDismissible: false, enableDrag: false,
                        backgroundColor: Theme.of(context).cardColor, context: context , builder: (context){
                          return const LanguageSelectBottomSheet();
                        },
                      );
                    },
                    child: Row(children: [
                      Text(languageName, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),

                      const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                      Icon(Icons.arrow_forward_ios_outlined,size: Dimensions.fontSizeLarge,)
                    ]),
                  ),

                ]),
              ),
              const SizedBox(height: Dimensions.paddingSize),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSize),
                    border: Border.all(color: Theme.of(context).hintColor, width: .5)
                ),
                child: Row(children: [
                  Expanded(child: ListTile(
                    title: Text('theme'.tr,style: textRegular.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    )),
                    leading: Image.asset(Images.themeIcon, width: 20),
                  )),

                  GetBuilder<ThemeController>(builder: (themeController){
                    return Padding(padding: const EdgeInsets.only(right: 8.0),
                      child: FlutterSwitch(
                        value: themeController.darkTheme,
                        onToggle: (value){
                          themeController.changeThemeSetting(value);
                        },
                        width: 60, height: 30,
                        activeIcon: Image.asset(Images.darkThemeIcon,color: Theme.of(context).primaryColor),
                        activeToggleColor: Theme.of(context).primaryColor.withValues(alpha:0.25),
                        inactiveToggleColor: Theme.of(context).primaryColor,
                        inactiveIcon: Image.asset(Images.lightThemeIcon),
                        inactiveColor: Colors.grey.withValues(alpha:0.25),
                        activeColor: Theme.of(context).primaryColor.withValues(alpha:0.25),
                      ),
                    );
                  })
                ],
                ),
              ),

            ]),
          );
        }),
      ),
    );
  }
}
