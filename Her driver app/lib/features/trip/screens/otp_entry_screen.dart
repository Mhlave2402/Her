import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/trip/controllers/trip_controller.dart';

class OtpEntryScreen extends StatefulWidget {
  final String tripId;
  const OtpEntryScreen({Key? key, required this.tripId}) : super(key: key);

  @override
  State<OtpEntryScreen> createState() => _OtpEntryScreenState();
}

class _OtpEntryScreenState extends State<OtpEntryScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String _enteredOtp = '';

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      _otpControllers[i].addListener(() {
        if (_otpControllers[i].text.length == 1 && i < 5) {
          _focusNodes[i + 1].requestFocus();
        }
        setState(() {
          _enteredOtp = _otpControllers.map((c) => c.text).join();
        });
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter the OTP to start the trip.')),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enter OTP'),
          automaticallyImplyLeading: false,
        ),
        body: GetBuilder<TripController>(
          builder: (tripController) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Enter the code shared by your customer to start the trip.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 40,
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _enteredOtp.length == 6
                        ? () {
                            tripController.verifyOtp(widget.tripId, _enteredOtp);
                          }
                        : null,
                    child: const Text('Verify & Start Trip'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Implement resend code logic
                    },
                    child: const Text('Resend Code'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement call customer logic
                    },
                    child: const Text('Call Customer'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
