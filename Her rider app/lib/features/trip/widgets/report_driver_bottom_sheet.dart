import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/common_widgets/button_widget.dart';
import 'package:her_user_app/features/behavior_monitoring/controllers/behavior_controller.dart';
import 'package:her_user_app/util/dimensions.dart';

class ReportDriverBottomSheet extends StatefulWidget {
  final int driverId;
  const ReportDriverBottomSheet({Key? key, required this.driverId}) : super(key: key);

  @override
  State<ReportDriverBottomSheet> createState() => _ReportDriverBottomSheetState();
}

class _ReportDriverBottomSheetState extends State<ReportDriverBottomSheet> {
  String? _selectedReason;
  final List<String> _reasons = [
    'Road rage',
    'Driving above speed limit',
    'Unauthorized detour',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'report_driver'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'select_a_reason'.tr,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _reasons.length,
            itemBuilder: (context, index) {
              return RadioListTile<String>(
                title: Text(_reasons[index].tr),
                value: _reasons[index],
                groupValue: _selectedReason,
                onChanged: (value) {
                  setState(() {
                    _selectedReason = value;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 10),
          ButtonWidget(
            buttonText: 'submit'.tr,
            onPressed: _selectedReason != null
                ? () {
                    Get.find<BehaviorController>().submitReport(widget.driverId, _selectedReason!);
                    Get.back();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
