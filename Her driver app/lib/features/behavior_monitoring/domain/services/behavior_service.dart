import 'package:get/get_connect/http/src/response/response.dart';
import 'package:her_driver_app/features/behavior_monitoring/data/repositories/behavior_repository.dart';
import 'package:her_driver_app/features/behavior_monitoring/domain/services/behavior_service_interface.dart';

class BehaviorService implements BehaviorServiceInterface {
  final BehaviorRepository behaviorRepository;
  BehaviorService({required this.behaviorRepository});

  @override
  Future<Response> sendSpeedingEvent(double speed) async {
    return await behaviorRepository.sendSpeedingEvent(speed);
  }

  @override
  Future<Response> sendHardBrakingEvent(double acceleration) async {
    return await behaviorRepository.sendHardBrakingEvent(acceleration);
  }
}
