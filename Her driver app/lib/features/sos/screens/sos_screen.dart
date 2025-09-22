import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/sos/controllers/sos_controller.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/styles.dart';
import 'package:her_driver_app/common_widgets/app_bar_widget.dart';
import 'package:her_driver_app/common_widgets/body_widget.dart';
import 'package:her_driver_app/common_widgets/button_widget.dart';
import 'package:her_driver_app/common_widgets/custom_text_field.dart';

class SosScreen extends StatefulWidget {
  final String? tripId;
  const SosScreen({super.key, this.tripId});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        appBar: AppBarWidget(
          title: 'sos'.tr,
          onBackPressed: () => Get.back(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'send_sos_request'.tr,
                style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Text(
                'are_you_sure_to_send_sos'.tr,
                style: textRegular.copyWith(color: Theme.of(context).hintColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              CustomTextField(
                controller: _noteController,
                hintText: 'write_a_note'.tr,
                maxLines: 3,
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              GetBuilder<SosController>(builder: (sosController) {
                return ButtonWidget(
                  buttonText: 'send'.tr,
                  isLoading: sosController.isLoading,
                  onPressed: () async {
                    Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    sosController.sendSos(
                      position.latitude.toString(),
                      position.longitude.toString(),
                      widget.tripId,
                      _noteController.text.trim(),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
