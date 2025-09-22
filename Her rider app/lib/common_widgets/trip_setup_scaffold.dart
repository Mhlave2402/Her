import 'package:flutter/material.dart';
import 'package:her_user_app/common_widgets/blurred_map_background.dart';
import 'package:her_user_app/common_widgets/floating_back_button.dart';

class TripSetupScaffold extends StatelessWidget {
  final Widget child;
  const TripSetupScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BlurredMapBackground(),
          child,
          const FloatingBackButton(),
        ],
      ),
    );
  }
}
