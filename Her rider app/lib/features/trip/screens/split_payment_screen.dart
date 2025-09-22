import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/trip/controllers/trip_controller.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class SplitPaymentScreen extends StatefulWidget {
  final int tripId;
  const SplitPaymentScreen({Key? key, required this.tripId}) : super(key: key);

  @override
  State<SplitPaymentScreen> createState() => _SplitPaymentScreenState();
}

class _SplitPaymentScreenState extends State<SplitPaymentScreen> {
  Contact? _contact;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split Payment'),
      ),
      body: GetBuilder<TripController>(
        builder: (tripController) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final Contact? contact = await FlutterContacts.openExternalPick();
                    setState(() {
                      _contact = contact;
                    });
                  },
                  child: const Text('Select Contact'),
                ),
                if (_contact != null)
                  Text('Selected: ${_contact!.displayName}'),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // This is a placeholder for getting the user ID from the contact.
                    // You would need to implement a way to map the contact to a user in your system.
                    tripController.requestSplitPayment(
                      widget.tripId,
                      123, // Placeholder user ID
                    );
                  },
                  child: const Text('Request Split'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
