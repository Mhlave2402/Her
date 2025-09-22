import 'package:flutter/material.dart';
import 'package:her_user_app/features/trip/widgets/trip_sharing_widget.dart';

class TripSharingView extends StatelessWidget {
  final String tripId;

  TripSharingView({required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Sharing'),
      ),
      body: Center(
        child: TripSharingWidget(tripId: tripId),
      ),
    );
  }
}
