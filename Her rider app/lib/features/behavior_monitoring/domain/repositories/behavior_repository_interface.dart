import 'package:her_user_app/features/behavior_monitoring/domain/models/driver_behavior_model.dart';

abstract class BehaviorRepositoryInterface {
  Future<List<DriverBehaviorModel>> getDriverBehavior(int driverId);
  Future<void> submitReport(int driverId, String reason);
}
