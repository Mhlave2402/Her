import 'package:her_driver_app/data/api_client.dart';
import 'package:her_driver_app/util/app_constants.dart';

class DriverPrefsRepository {
  final ApiClient apiClient;

  DriverPrefsRepository({required this.apiClient});

  Future<dynamic> getTierSettings() async {
    final response = await apiClient.get(AppConstants.tierSettingsUri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> updateTierSettings(Map<String, bool> global, Map<String, Map<String, bool>> perVehicle) async {
    final response = await apiClient.put(
      AppConstants.tierSettingsUri,
      {'global': global, 'per_vehicle': perVehicle},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> toggleVehicleActive(String vehicleId) async {
    final response = await apiClient.put(
      '${AppConstants.vehicleUri}/$vehicleId/toggle-active',
      {},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
