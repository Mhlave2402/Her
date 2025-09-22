import 'package:get/get.dart';
import 'package:her_user_app/features/behavior_monitoring/domain/models/driver_behavior_model.dart';
import 'package:her_user_app/features/behavior_monitoring/domain/services/behavior_service_interface.dart';

class BehaviorController extends GetxController implements GetxService {
  final BehaviorServiceInterface behaviorServiceInterface;

  BehaviorController({required this.behaviorServiceInterface});

  List<DriverBehaviorModel> _driverBehaviorList = [];
  List<DriverBehaviorModel> get driverBehaviorList => _driverBehaviorList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getDriverBehavior(int driverId) async {
    _isLoading = true;
    update();
    try {
      _driverBehaviorList = await behaviorServiceInterface.getDriverBehavior(driverId);
    } catch (e) {
      // Handle error
    }
    _isLoading = false;
    update();
  }

  Future<void> submitReport(int driverId, String reason) async {
    _isLoading = true;
    update();
    try {
      await behaviorServiceInterface.submitReport(driverId, reason);
    } catch (e) {
      // Handle error
    }
    _isLoading = false;
    update();
  }
}
