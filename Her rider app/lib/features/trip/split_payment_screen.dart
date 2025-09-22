import 'package:flutter/material.dart';
import 'package:her_user_app/features/trip/trip_service.dart';
import 'dart:convert';

class SplitPaymentScreen extends StatefulWidget {
  final String tripId;

  SplitPaymentScreen({required this.tripId});

  @override
  _SplitPaymentScreenState createState() => _SplitPaymentScreenState();
}

class _SplitPaymentScreenState extends State<SplitPaymentScreen> {
  final TripService _tripService = TripService();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _sharePercentageController = TextEditingController();
  Map<String, dynamic>? _paymentStatus;

  @override
  void initState() {
    super.initState();
    _fetchPaymentStatus();
  }

  void _fetchPaymentStatus() async {
    final response = await _tripService.getPaymentStatus(widget.tripId);
    if (response.statusCode == 200) {
      setState(() {
        _paymentStatus = jsonDecode(response.body);
      });
    }
  }

  void _inviteParticipant() async {
    final response = await _tripService.inviteParticipant(
      widget.tripId,
      _userIdController.text,
      double.parse(_sharePercentageController.text),
      false,
    );
    if (response.statusCode == 201) {
      _fetchPaymentStatus();
      _userIdController.clear();
      _sharePercentageController.clear();
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Split Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_paymentStatus != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Due: ${_paymentStatus!['total_due']}'),
                      Text('Total Paid: ${_paymentStatus!['total_paid']}'),
                      Text('Balance: ${_paymentStatus!['balance']}'),
                      SizedBox(height: 16),
                      Text('Participants:', style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var participant in _paymentStatus!['participants'])
                        Text('${participant['user_id']}: ${participant['amount_paid']} / ${participant['share_percentage']}%'),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              controller: _sharePercentageController,
              decoration: InputDecoration(labelText: 'Share Percentage'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _inviteParticipant,
              child: Text('Invite Participant'),
            ),
          ],
        ),
      ),
    );
  }
}
