import 'package:get/get_connect/http/src/response/response.dart';
import 'package:her_driver_app/interface/repository_interface.dart';

abstract class OutOfZoneRepositoryInterface implements RepositoryInterface {
  Future<Response> getZoneList();
}