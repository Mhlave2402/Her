import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
  }
}
