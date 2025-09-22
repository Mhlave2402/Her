import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:her_driver_app/features/trip/services/location_service.dart';

class TripTrackingView extends StatefulWidget {
  final String tripId;

  TripTrackingView({required this.tripId});

  @override
  _TripTrackingViewState createState() => _TripTrackingViewState();
}

class _TripTrackingViewState extends State<TripTrackingView> {
  final LocationService _locationService = LocationService();
  final Location _location = Location();
  late GoogleMapController _mapController;
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  void _startLocationUpdates() {
    _locationSubscription = _location.onLocationChanged.listen((LocationData currentLocation) {
      _locationService.updateLocation(
        widget.tripId,
        currentLocation.latitude!,
        currentLocation.longitude!,
      );
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
            zoom: 15,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Tracking'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 15,
        ),
      ),
    );
  }
}
