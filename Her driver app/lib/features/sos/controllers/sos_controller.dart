import 'dart:async';
import 'package:get/get.dart';
import 'package:her_driver_app/features/location/controllers/location_controller.dart';
import 'package:her_driver_app/features/sos/data/sos_repository.dart';

class SosController extends GetxController implements GetxService {
  final SosRepository sosRepository;
  SosController({required this.sosRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Timer? _timer;

  Future<void> sendSos(String latitude, String longitude, String? tripId, String? note, {bool isSilent = false}) async {
    _isLoading = true;
    update();
    Response response = await sosRepository.sendSos(latitude, longitude, tripId, note);
    if (response.statusCode == 200) {
      if (!isSilent) {
        Get.back();
        showCustomSnackBar('SOS sent successfully', isError: false);
      }
      startLiveLocationSharing(tripId);
    } else {
      if (!isSilent) {
        showCustomSnackBar(response.statusText!, isError: true);
      }
    }
    _isLoading = false;
    update();
  }

  void startLiveLocationSharing(String? tripId) {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      final locationController = Get.find<LocationController>();
      await locationController.getCurrentLocation();
      if (locationController.currentPosition != null) {
        sendSos(
          locationController.currentPosition!.latitude.toString(),
          locationController.currentPosition!.longitude.toString(),
          tripId,
          "Live location update",
          isSilent: true,
        );
      }
    });
  }

  void stopLiveLocationSharing() {
    _timer?.cancel();
  }
}
