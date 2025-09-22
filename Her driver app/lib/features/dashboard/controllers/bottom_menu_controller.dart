import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/util/images.dart';
import 'package:her_driver_app/common_widgets/confirmation_dialog_widget.dart';


class BottomMenuController extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;


  resetNavBar(){
    _currentTab = 0;
  }
  void setTabIndex(int index) {
    _currentTab = index;
    update();
  }

  void exitApp() {
    Get.dialog(ConfirmationDialogWidget(
      icon: Images.logOutIcon,
      description: 'do_you_want_to_exit_the_app'.tr,
      iconColor: Theme.of(Get.context!).primaryColor,
      onYesPressed:() {
        SystemNavigator.pop();
        exit(0);
      },
    ), barrierDismissible: false);
  }

}
