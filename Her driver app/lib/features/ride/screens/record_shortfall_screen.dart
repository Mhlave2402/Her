import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/common_widgets/button_widget.dart';
import 'package:her_driver_app/common_widgets/custom_text_field.dart';
import 'package:her_driver_app/features/ride/controllers/ride_controller.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/styles.dart';

class RecordShortfallScreen extends StatefulWidget {
  final String tripId;
  const RecordShortfallScreen({super.key, required this.tripId});

  @override
  State<RecordShortfallScreen> createState() => _RecordShortfallScreenState();
}

class _RecordShortfallScreenState extends State<RecordShortfallScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('record_shortfall'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'enter_amount_paid_in_cash'.tr,
              style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            CustomTextField(
              controller: _amountController,
              hintText: 'amount'.tr,
              inputType: TextInputType.number,
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            GetBuilder<RideController>(builder: (rideController) {
              return ButtonWidget(
                buttonText: 'confirm'.tr,
                onPressed: () {
                  if (_amountController.text.isNotEmpty) {
                    rideController.recordShortfall(
                      widget.tripId,
                      _amountController.text,
                    );
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
