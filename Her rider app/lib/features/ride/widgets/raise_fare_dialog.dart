import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';

class RaiseFareDialog extends StatefulWidget {
  const RaiseFareDialog({Key? key}) : super(key: key);

  @override
  State<RaiseFareDialog> createState() => _RaiseFareDialogState();
}

class _RaiseFareDialogState extends State<RaiseFareDialog> {
  late double _originalFare;
  late double _currentFare;

  @override
  void initState() {
    super.initState();
    final rideController = Get.find<RideController>();
    _originalFare = rideController.estimatedFare;
    _currentFare = _originalFare;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      builder: (rideController) {
        return AlertDialog(
          title: const Text('Raise Fare'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No drivers found. Try raising the fare to attract more drivers.'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: _currentFare > _originalFare
                        ? () {
                            setState(() {
                              _currentFare -= 1.0;
                            });
                          }
                        : null,
                  ),
                  Text(
                    '\$${_currentFare.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: () {
                      setState(() {
                        _currentFare += 1.0;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                rideController.setBidingAmount(_currentFare.toString());
                rideController.submitRideRequest(rideController.noteController.text, false);
                Get.back();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
