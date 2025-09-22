import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/features/ride/domain/models/premium_feature_model.dart';
import 'package:her_user_app/features/ride/domain/models/trip_details_model.dart';

class DriverFoundScreen extends StatelessWidget {
  const DriverFoundScreen({Key? key}) : super(key: key);

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
              final tripDetails = rideController.tripDetails;
              if (tripDetails == null || tripDetails.driver == null) {
                return const Center(
                  child: Text('Waiting for driver details...'),
                );
              }
              return DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.2,
                maxChildSize: 0.8,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildDriverInfoCard(context, tripDetails.driver!),
                          const SizedBox(height: 24),
                          _buildVehicleInfoCard(context, tripDetails),
                          const SizedBox(height: 24),
                          _buildVerificationCode(context, tripDetails),
                          const SizedBox(height: 24),
                          _buildArrivalProgress(context, rideController),
                        ],
                      ),
                    ),
                  );
                },
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
                  borderRadius: BorderRadius.circular(0),
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

  Widget _buildVerificationCode(BuildContext context, TripDetails tripDetails) {
    return Column(
      children: [
        const Text(
          'Share this code with your driver to start your trip.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            tripDetails.otp ?? '----',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDriverInfoCard(BuildContext context, Driver driver) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(driver.profileImage ?? ''),
              onBackgroundImageError: (_, __) => const Icon(Icons.person, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${driver.firstName} ${driver.lastName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        tripDetails.driverAvgRating ?? 'N/A',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleInfoCard(BuildContext context, TripDetails tripDetails) {
    final vehicle = tripDetails.vehicle;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vehicle?.model?.name ?? 'N/A',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tripDetails.vehicleCategory?.name ?? 'N/A'),
                Text(vehicle?.color ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                vehicle?.licencePlateNumber ?? 'N/A',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (tripDetails.premiumFeatures?.isNotEmpty ?? false)
              _buildSpecialFeatures(tripDetails.premiumFeatures!),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialFeatures(List<PremiumFeature> premiumFeatures) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Special Features',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: premiumFeatures.map((feature) => Chip(label: Text(feature.name))).toList(),
        ),
      ],
    );
  }

  Widget _buildArrivalProgress(BuildContext context, RideController rideController) {
    return Column(
      children: [
        Lottie.asset(
          'assets/animations/arrival.json', // Placeholder for your Lottie animation
          height: 150,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              height: 150,
              child: Center(child: Text('Animation failed to load')),
            );
          },
        ),
        const SizedBox(height: 16),
        Obx(() => Text(
              'ETA: ${rideController.remainingDistanceModel.isNotEmpty ? rideController.remainingDistanceModel.first.duration : 'N/A'} min',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }
}
