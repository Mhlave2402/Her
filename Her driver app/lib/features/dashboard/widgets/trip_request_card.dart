import 'package:flutter/material.dart';
import 'dart:async';

class TripRequestCard extends StatefulWidget {
  final String pickupLocation;
  final String dropoffLocation;
  final double pickupDistance;
  final double tripDistance;
  final int estimatedPickupTime;
  final String vehicleCategory;
  final double fare;
  final List<String> specialRequests;
  final double clientRating;
  final int countdownSeconds;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onPass;
  final Function(String) onBid;

  const TripRequestCard({
    Key? key,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupDistance,
    required this.tripDistance,
    required this.estimatedPickupTime,
    required this.vehicleCategory,
    required this.fare,
    required this.specialRequests,
    required this.clientRating,
    required this.countdownSeconds,
    required this.onAccept,
    required this.onDecline,
    required this.onPass,
    required this.onBid,
  }) : super(key: key);

  @override
  _TripRequestCardState createState() => _TripRequestCardState();
}

class _TripRequestCardState extends State<TripRequestCard> {
  late Timer _timer;
  late int _countdown;

  @override
  void initState() {
    super.initState();
    _countdown = widget.countdownSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('New Trip Request', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: _countdown / widget.countdownSeconds,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                    Text('$_countdown', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(context, Icons.location_on, 'Pickup', widget.pickupLocation),
            const SizedBox(height: 8),
            // Placeholder for map preview
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(child: Text('Map Preview')),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(context, Icons.location_on_outlined, 'Drop-off', widget.dropoffLocation),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetric(context, 'Trip Distance', '${widget.tripDistance} km'),
                _buildMetric(context, 'Pickup Distance', '${widget.pickupDistance} km'),
                _buildMetric(context, 'Pickup Time', '${widget.estimatedPickupTime} min'),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(context, Icons.directions_car, 'Vehicle', widget.vehicleCategory),
            const SizedBox(height: 16),
            if (widget.specialRequests.isNotEmpty) ...[
              _buildSpecialRequests(context),
              const SizedBox(height: 16),
            ],
            if (widget.clientRating > 0) ...[
              _buildClientRating(context),
              const SizedBox(height: 16),
            ],
            Center(
              child: Text(
                'R${widget.fare.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onDecline,
                    child: const Text('Decline'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showBidDialog(context),
                    child: const Text('Bid'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: widget.onAccept,
                    child: const Text('Accept'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: widget.onPass,
                child: const Text('Pass to Others'),
                style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
            const SizedBox(height: 2),
            SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              child: Text(value, style: Theme.of(context).textTheme.bodyLarge, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetric(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSpecialRequests(BuildContext context) {
    // Placeholder for special request icons
    return Row(
      children: widget.specialRequests.map((request) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(label: Text(request)),
      )).toList(),
    );
  }

  Widget _buildClientRating(BuildContext context) {
    return Row(
      children: [
        const Text('Client Rating: '),
        for (int i = 0; i < 5; i++)
          Icon(
            i < widget.clientRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 20,
          ),
      ],
    );
  }

  void _showBidDialog(BuildContext context) {
    final bidController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter your bid'),
        content: TextField(
          controller: bidController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Bid amount',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onBid(bidController.text);
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
