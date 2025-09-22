import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/location/controllers/location_controller.dart';
import 'package:her_user_app/theme/theme_controller.dart';
import 'package:her_user_app/util/app_constants.dart';

class BlurredMapBackground extends StatelessWidget {
  const BlurredMapBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: Get.find<LocationController>().initialPosition,
            zoom: 16,
          ),
          style: Get.isDarkMode ? Get.find<ThemeController>().darkMap : Get.find<ThemeController>().lightMap,
          minMaxZoomPreference: const MinMaxZoomPreference(0, AppConstants.mapZoom),
          zoomControlsEnabled: false,
          compassEnabled: false,
          indoorViewEnabled: true,
          mapToolbarEnabled: false,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
      ],
    );
  }
}
