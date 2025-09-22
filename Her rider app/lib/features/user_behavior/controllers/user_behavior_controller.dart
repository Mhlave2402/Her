import 'package:get/get.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';

enum UserType {
  newly,
  regular,
  loyal,
}

class UserBehaviorController extends GetxController {
  UserType getUserType() {
    final rideController = Get.find<RideController>();
    final rideCount = rideController.runningRideList?.data?.length ?? 0;

    if (rideCount == 0) {
      return UserType.newly;
    } else if (rideCount > 0 && rideCount <= 10) {
      return UserType.regular;
    } else {
      return UserType.loyal;
    }
  }

  String getGreeting(UserType userType) {
    switch (userType) {
      case UserType.newly:
        return 'welcome_back'.tr;
      case UserType.regular:
        return 'good_to_see_you_again'.tr;
      case UserType.loyal:
        return 'we_are_happy_to_have_you'.tr;
      default:
        return 'welcome_back'.tr;
    }
  }
}
