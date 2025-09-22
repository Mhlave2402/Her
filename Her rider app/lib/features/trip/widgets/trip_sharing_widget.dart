import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:her_user_app/features/trip/services/trip_service.dart';

class TripSharingWidget extends StatelessWidget {
  final String tripId;
  final TripService _tripService = TripService();

  TripSharingWidget({required this.tripId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.share),
      onPressed: () async {
        try {
          final sharingLink = await _tripService.getSharingLink(tripId);
          Share.share('Track my ride: $sharingLink');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to get sharing link')),
          );
        }
      },
    );
  }
}
