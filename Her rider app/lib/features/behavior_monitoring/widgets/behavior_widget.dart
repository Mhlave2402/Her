import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/behavior_monitoring/controllers/behavior_controller.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';

class BehaviorWidget extends StatefulWidget {
  const BehaviorWidget({Key? key}) : super(key: key);

  @override
  State<BehaviorWidget> createState() => _BehaviorWidgetState();
}

class _BehaviorWidgetState extends State<BehaviorWidget> {
  @override
  void initState() {
    super.initState();
    Get.find<BehaviorController>().getDriverBehavior(int.parse(Get.find<RideController>().tripDetails!.driver!.id!));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BehaviorController>(builder: (behaviorController) {
      return behaviorController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Driver Behavior',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: behaviorController.driverBehaviorList.length,
                  itemBuilder: (context, index) {
                    final behavior = behaviorController.driverBehaviorList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(behavior.type),
                          Text(behavior.value.toString()),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
    });
  }
}
