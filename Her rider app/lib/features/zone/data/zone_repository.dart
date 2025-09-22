import 'package:get/get.dart';
import 'package:her_user_app/data/api_client.dart';
import 'package:her_user_app/util/app_constants.dart';

class ZoneRepository {
  final ApiClient apiClient;

  ZoneRepository({required this.apiClient});

  Future<Response> getZone(String type) async {
    return await apiClient.getData(AppConstants.zoneUri);
  }
}
