import 'package:get/get_connect/http/src/response/response.dart';
import 'package:her_user_app/data/api_client.dart';
import 'package:her_user_app/util/app_constants.dart';

class SosRepository {
  final ApiClient apiClient;
  SosRepository({required this.apiClient});

  Future<Response> sendSos(String latitude, String longitude, String? tripId, String? note) async {
    return await apiClient.postData(AppConstants.SOS_URI, {
      'latitude': latitude,
      'longitude': longitude,
      'trip_id': tripId,
      'note': note,
    });
  }
}
