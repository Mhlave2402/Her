import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/wallet/controllers/payout_settings_controller.dart';
import 'package:her_driver_app/common_widgets/app_bar_widget.dart';
import 'package:her_driver_app/util/dimensions.dart';

class PayoutSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Auto-withdrawal Settings'),
      body: GetBuilder<PayoutSettingsController>(
        init: PayoutSettingsController(walletServiceInterface: Get.find()),
        builder: (controller) {
          return ListView(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            children: [
              // Enable/Disable Auto-withdrawal
              SwitchListTile(
                title: Text('Enable Auto-withdrawal'),
                value: controller.isAutoWithdrawEnabled,
                onChanged: (value) {
                  controller.toggleAutoWithdraw(value);
                },
              ),
              SizedBox(height: 20),

              // Payout Schedule
              Text('Payout Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: controller.payoutSchedule,
                onChanged: (String? newValue) {
                  controller.setPayoutSchedule(newValue!);
                },
                items: <String>['daily', 'weekly', 'monthly']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.capitalizeFirst!),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Earnings Threshold
              Text('Earnings Threshold (R)', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: controller.thresholdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'e.g., 500',
                ),
              ),
              SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  controller.saveSettings();
                },
                child: Text('Save Settings'),
              ),
            ],
          );
        },
      ),
    );
  }
}
