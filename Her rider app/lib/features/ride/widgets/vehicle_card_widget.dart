import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/features/ride/domain/models/estimated_fare_model.dart';
import 'package:her_user_app/features/ride/domain/models/premium_feature_model.dart';

class VehicleCardWidget extends StatelessWidget {
  final FareModel fare;

  const VehicleCardWidget({
    Key? key,
    required this.fare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showFareBreakdown(context);
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Left Section
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      fare.vehicleCategory?.image ?? '',
                      height: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.car_rental, size: 60),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      fare.vehicleCategory?.name ?? 'N/A',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16),
                        const SizedBox(width: 4),
                        Text(fare.vehicleCategory?.capacity.toString() ?? 'N/A'),
                        const SizedBox(width: 8),
                        const Icon(Icons.luggage, size: 16),
                        const SizedBox(width: 4),
                        Text(fare.vehicleCategory?.hatchBagCapacity.toString() ?? 'N/A'),
                      ],
                    ),
                  ],
                ),
              ),
              // Center Section
              Expanded(
                flex: 1,
                child: GetBuilder<RideController>(
                  builder: (rideController) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: rideController.selectedPremiumFeatures.map((feature) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Image.network(
                            feature.iconUrl,
                            height: 24,
                            width: 24,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              // Right Section
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${fare.estimatedFare?.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tap for details',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFareBreakdown(BuildContext context) {
    final rideController = Get.find<RideController>();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fare Breakdown',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Base Fare'),
                  Text('\$${(fare.estimatedFare! - _getFeatureSurcharge(rideController.selectedPremiumFeatures)).toStringAsFixed(2)}'),
                ],
              ),
              const Divider(),
              ..._buildFeatureSurchargeRows(rideController.selectedPremiumFeatures),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Fare',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${fare.estimatedFare?.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  double _getFeatureSurcharge(List<PremiumFeature> selectedFeatures) {
    double totalSurcharge = 0;
    for (var feature in selectedFeatures) {
      totalSurcharge += feature.surcharge;
    }
    return totalSurcharge;
  }

  List<Widget> _buildFeatureSurchargeRows(List<PremiumFeature> selectedFeatures) {
    return selectedFeatures.map((feature) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(feature.name),
            Text('\$${feature.surcharge.toStringAsFixed(2)}'),
          ],
        ),
      );
    }).toList();
  }
}
