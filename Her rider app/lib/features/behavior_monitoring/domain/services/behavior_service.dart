import 'package:her_user_app/features/behavior_monitoring/domain/models/driver_behavior_model.dart';
import 'package:her_user_app/features/behavior_monitoring/domain/repositories/behavior_repository_interface.dart';
import 'package:her_user_app/features/behavior_monitoring/domain/services/behavior_service_interface.dart';

class BehaviorService implements BehaviorServiceInterface {
  final BehaviorRepositoryInterface behaviorRepository;

  BehaviorService({required this.behaviorRepository});

  @override
  Future<List<DriverBehaviorModel>> getDriverBehavior(int driverId) {
    return behaviorRepository.getDriverBehavior(driverId);
  }

  @override
  Future<void> submitReport(int driverId, String reason) {
    return behaviorRepository.submitReport(driverId, reason);
  }
}
