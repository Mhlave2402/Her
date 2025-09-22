import 'package:her_user_app/features/behavior_monitoring/domain/models/driver_behavior_model.dart';
import 'package:her_user_app/features/behavior_monitoring/domain/repositories/behavior_repository_interface.dart';
import 'package:her_user_app/data/api/api_client.dart';
import 'package:her_user_app/util/app_constants.dart';

class BehaviorRepository implements BehaviorRepositoryInterface {
  final ApiClient apiClient;

  BehaviorRepository({required this.apiClient});

  @override
  Future<List<DriverBehaviorModel>> getDriverBehavior(int driverId) async {
    try {
      final response = await apiClient.get('${AppConstants.DRIVER_BEHAVIOR_URI}?driver_id=$driverId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.body['data'];
        return data.map((json) => DriverBehaviorModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load driver behavior');
      }
    } catch (e) {
      throw Exception('Failed to load driver behavior');
    }
  }

  @override
  Future<void> submitReport(int driverId, String reason) async {
    try {
      final response = await apiClient.post(AppConstants.DRIVER_REPORT_URI, {
        'driver_id': driverId,
        'reason': reason,
      });
      if (response.statusCode != 200) {
        throw Exception('Failed to submit report');
      }
    } catch (e) {
      throw Exception('Failed to submit report');
    }
  }
}
