import 'package:flutter/material.dart';
import 'package:her_user_app/features/trip/trip_service.dart';
import 'package:her_user_app/features/trip/split_payment_screen.dart';
import 'package:get/get.dart';

class RideRequestScreen extends StatefulWidget {
  @override
  _RideRequestScreenState createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  final TripService _tripService = TripService();
  bool _withMaleCompanion = false;
  bool _isChildFriendly = false;
  bool _isNannyRide = false;
  bool _isKidsOnlyRide = false;
  String _tripId = "your_trip_id"; // Replace with actual tripId

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request a Ride')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Your ride request UI elements (e.g., map, destination input) would go here.
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _withMaleCompanion,
                  onChanged: (value) {
                    setState(() {
                      _withMaleCompanion = value!;
                    });
                    _tripService.updateWithMaleCompanion(_tripId, _withMaleCompanion);
                  },
                ),
                Text('Travel with male companion'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _isChildFriendly,
                  onChanged: (value) {
                    setState(() {
                      _isChildFriendly = value!;
                    });
                    _tripService.updateIsChildFriendly(_tripId, _isChildFriendly);
                  },
                ),
                Text('Child-Friendly'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _isNannyRide,
                  onChanged: (value) {
                    setState(() {
                      _isNannyRide = value!;
                    });
                    _tripService.requestNannyRide(_tripId, _isNannyRide);
                  },
                ),
                Text('Request Nanny Ride'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _isKidsOnlyRide,
                  onChanged: (value) {
                    setState(() {
                      _isKidsOnlyRide = value!;
                    });
                    _tripService.requestKidsOnlyRide(_tripId, _isKidsOnlyRide);
                  },
                ),
                Text('Request Kids-Only Verified Ride'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle ride request logic here
              },
              child: Text('Request Ride'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.to(() => SplitPaymentScreen(tripId: _tripId)),
              child: Text('Split Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
