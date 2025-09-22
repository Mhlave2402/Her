import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/features/ride/widgets/vehicle_card_widget.dart';
import 'package:her_user_app/features/ride/domain/models/estimated_fare_model.dart';
import 'package:her_user_app/features/ride/widgets/feature_card_widget.dart';

class ChooseVehicleScreen extends StatefulWidget {
  const ChooseVehicleScreen({Key? key}) : super(key: key);

  @override
  State<ChooseVehicleScreen> createState() => _ChooseVehicleScreenState();
}

class _ChooseVehicleScreenState extends State<ChooseVehicleScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<RideController>().getPremiumFeatures();
    Get.find<RideController>().getEstimatedFare(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Replace this with your map widget
          Container(
            color: Colors.grey[300],
            child: const Center(
              child: Text('Map Placeholder'),
            ),
          ),
          GetBuilder<RideController>(
            builder: (rideController) {
              return Column(
                children: [
                  Expanded(
                    child: Container(), // This will push the vehicle selection to the bottom
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: rideController.premiumFeatureList.length,
                      itemBuilder: (context, index) {
                        return FeatureCardWidget(
                          feature: rideController.premiumFeatureList[index],
                          isSelected: rideController.selectedPremiumFeatures.contains(rideController.premiumFeatureList[index]),
                          onTap: () => rideController.togglePremiumFeature(rideController.premiumFeatureList[index]),
                        );
                      },
                    ),
                  ),
                  rideController.fareList.isNotEmpty
                      ? SizedBox(
                          height: 200, // Adjust the height as needed
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: rideController.fareList.length,
                            itemBuilder: (context, index) {
                              FareModel fare = rideController.fareList[index];
                              return VehicleCardWidget(
                                fare: fare,
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              );
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF231f20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
