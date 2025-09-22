import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/profile/controllers/profile_controller.dart';
import 'package:her_driver_app/features/splash/controllers/splash_controller.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/images.dart';
import 'package:her_driver_app/util/styles.dart';
import 'package:her_driver_app/features/home/screens/vehicle_add_screen.dart';
import 'package:her_driver_app/common_widgets/button_widget.dart';
import 'package:her_driver_app/features/chat/screens/chat_screen.dart';

class UnverifiedDashboardScreen extends StatelessWidget {
  const UnverifiedDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      bool isVehicleInfoSubmitted = profileController.profileInfo?.vehicle != null;
      String? vehicleStatus = profileController.profileInfo?.vehicle?.vehicleRequestStatus;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.paddingSizeLarge),
            _buildVerificationPendingBanner(context),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            _buildProgressIndicator(context, isVehicleInfoSubmitted, vehicleStatus),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            if (!isVehicleInfoSubmitted || vehicleStatus == 'denied')
              ButtonWidget(
                buttonText: isVehicleInfoSubmitted ? 'update_vehicle_info'.tr : 'add_vehicle_information'.tr,
                onPressed: () => Get.to(() => VehicleAddScreen(vehicleInfo: profileController.profileInfo?.vehicle)),
              ),
            if (vehicleStatus == 'pending')
              Center(
                child: Text(
                  'registration_not_approve_yet_vehicle'.tr,
                  style: textRegular.copyWith(color: Theme.of(context).hintColor),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            _buildHelpAndSupportSection(context),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            _buildLearnMoreLink(context),
          ],
        ),
      );
    });
  }

  Widget _buildVerificationPendingBanner(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final vehicleStatus = profileController.profileInfo?.vehicle?.vehicleRequestStatus;
    String message = 'vehicle_verification_pending'.tr;
    Color color = Theme.of(context).primaryColor;
    IconData icon = Icons.info;

    if (vehicleStatus == 'denied') {
      message = 'vehicle_verification_denied'.tr;
      color = Colors.red;
      icon = Icons.cancel;
    }

    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(
            child: Text(
              message,
              style: textMedium.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, bool isVehicleInfoSubmitted, String? vehicleStatus) {
    int currentStep = 0;
    if (isVehicleInfoSubmitted) {
      currentStep = 1;
    }
    if (vehicleStatus == 'approved') {
      currentStep = 2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('verification_progress'.tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Row(
          children: [
            _buildProgressStep(context, 'vehicle_details'.tr, currentStep >= 0),
            Expanded(child: Divider(color: currentStep > 0 ? Colors.green : Theme.of(context).hintColor)),
            _buildProgressStep(context, 'document_uploads'.tr, currentStep >= 1),
            Expanded(child: Divider(color: currentStep > 1 ? Colors.green : Theme.of(context).hintColor)),
            _buildProgressStep(context, 'verification_status'.tr, currentStep >= 2),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressStep(BuildContext context, String title, bool completed) {
    return Column(
      children: [
        Icon(
          completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: completed ? Colors.green : Theme.of(context).hintColor,
          size: 40,
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Text(title, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
      ],
    );
  }

  Widget _buildHelpAndSupportSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('help_support'.tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        ListTile(
          leading: Icon(Icons.chat, color: Theme.of(context).primaryColor),
          title: Text('in_app_support_chat'.tr),
          onTap: () {
            Get.to(() => const ChatScreen(role: 'admin'));
          },
        ),
      ],
    );
  }

  Widget _buildLearnMoreLink(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: Implement navigation to guidelines
      },
      child: Text(
        'learn_more_about_requirements'.tr,
        style: textRegular.copyWith(
          decoration: TextDecoration.underline,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
