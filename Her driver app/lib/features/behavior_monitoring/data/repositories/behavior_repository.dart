import 'package:get/get.dart';
import 'package:her_driver_app/data/api_client.dart';
import 'package:her_driver_app/features/behavior_monitoring/domain/services/behavior_service_interface.dart';
import 'package:her_driver_app/util/app_constants.dart';

class BehaviorRepository implements BehaviorServiceInterface {
  final ApiClient apiClient;
  BehaviorRepository({required this.apiClient});

  @override
  Future<Response> sendSpeedingEvent(double speed) async {
    return await apiClient.postData(AppConstants.speedingEventUri, {'speed': speed});
  }

  @override
  Future<Response> sendHardBrakingEvent(double acceleration) async {
    return await apiClient.postData(AppConstants.hardBrakingEventUri, {'acceleration': acceleration});
  }
}
