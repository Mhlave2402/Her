import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/features/ride/widgets/raise_fare_dialog.dart';

class FindingDriverScreen extends StatelessWidget {
  const FindingDriverScreen({Key? key}) : super(key: key);

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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      rideController.currentRideState == RideState.driverFoundPendingAcceptance
                          ? 'assets/animations/driver_found.json' // Placeholder for your new Lottie animation
                          : 'assets/animations/finding_driver.json',
                      height: 200,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: Text('Animation failed to load')),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      rideController.currentRideState == RideState.driverFoundPendingAcceptance
                          ? 'Driver found! Waiting for them to accept...'
                          : 'Finding your driver...',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (rideController.currentRideState == RideState.driverFoundPendingAcceptance)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'This usually takes a few seconds.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Get.dialog(const RaiseFareDialog());
                      },
                      child: const Text('Raise Fare'),
                    ),
                  ],
                ),
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
