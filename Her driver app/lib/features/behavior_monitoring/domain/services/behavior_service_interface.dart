import 'package:get/get_connect/http/src/response/response.dart';

abstract class BehaviorServiceInterface {
  Future<Response> sendSpeedingEvent(double speed);
  Future<Response> sendHardBrakingEvent(double acceleration);
}
