import 'package:get/get.dart';
import 'package:her_user_app/common_widgets/custom_snackbar.dart';
import 'package:her_user_app/features/sos/data/sos_repository.dart';

class SosController extends GetxController implements GetxService {
  final SosRepository sosRepository;
  SosController({required this.sosRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> sendSos(String latitude, String longitude, String? tripId, String? note) async {
    _isLoading = true;
    update();
    Response response = await sosRepository.sendSos(latitude, longitude, tripId, note);
    if (response.statusCode == 200) {
      Get.back();
      customSnackBar('SOS sent successfully', isError: false);
    } else {
      customSnackBar(response.statusText!, isError: true);
    }
    _isLoading = false;
    update();
  }
}
