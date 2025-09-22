import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/behavior_monitoring/domain/services/behavior_service_interface.dart';
import 'package:her_driver_app/features/trip/controllers/trip_controller.dart';

class BehaviorController extends GetxController implements GetxService {
  final BehaviorServiceInterface behaviorServiceInterface;
  BehaviorController({required this.behaviorServiceInterface});

  StreamSubscription? _locationSubscription;
  Position? _lastPosition;

  // Speeding parameters
  final double speedingThreshold = 80.0; // km/h

  // Braking parameters
  final double hardBrakingThreshold = -10.0; // m/s^2

  void startMonitoring() {
    _locationSubscription = Geolocator.getPositionStream().listen((Position position) {
      if (_lastPosition != null) {
        // Get current trip ID if available
        int? currentTripId = Get.find<TripController>().currentTrip.value?.id;
        
        // Check for speeding
        final double currentSpeed = position.speed * 3.6; // convert m/s to km/h
        if (currentSpeed > speedingThreshold) {
          if (kDebugMode) {
            print('Speeding detected: $currentSpeed km/h');
          }
          final double thresholdExceeded = currentSpeed - speedingThreshold;
          behaviorServiceInterface.sendSpeedingEvent(
            thresholdExceeded, 
            position.latitude, 
            position.longitude,
            currentTripId,
          );
        }

        // Check for hard braking
        final double timeDifference = position.timestamp.difference(_lastPosition!.timestamp).inMilliseconds / 1000.0;
        if (timeDifference > 0) {
          final double acceleration = (position.speed - _lastPosition!.speed) / timeDifference;
          if (acceleration < hardBrakingThreshold) {
            if (kDebugMode) {
              print('Hard braking detected: $acceleration m/s^2');
            }
            final double thresholdExceeded = (hardBrakingThreshold - acceleration).abs();
            behaviorServiceInterface.sendHardBrakingEvent(
              thresholdExceeded, 
              position.latitude, 
              position.longitude,
              currentTripId,
            );
          }
        }
      }
      _lastPosition = position;
    });
  }

  void stopMonitoring() {
    _locationSubscription?.cancel();
  }
}
