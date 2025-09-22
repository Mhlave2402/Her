import 'package:get/get.dart';
import 'package:her_user_app/features/zone_condition/services/zone_condition_service.dart';

class ZoneConditionController extends GetxController {
  final ZoneConditionService zoneConditionService;

  ZoneConditionController({required this.zoneConditionService});

  TrafficCondition? trafficCondition;
  WeatherCondition? weatherCondition;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchZoneConditions();
  }

  Future<void> fetchZoneConditions() async {
    isLoading = true;
    update();

    trafficCondition = await zoneConditionService.getTrafficCondition();
    weatherCondition = await zoneConditionService.getWeatherCondition();

    isLoading = false;
    update();
  }

  String getZoneConditionMessage() {
    if (isLoading) {
      return 'loading_traffic_data'.tr;
    }

    String message = '';
    if (trafficCondition == TrafficCondition.heavy) {
      message += 'heavy_traffic_warning'.tr;
    }

    if (weatherCondition == WeatherCondition.rainy || weatherCondition == WeatherCondition.stormy) {
      if (message.isNotEmpty) {
        message += ' and ';
      }
      message += 'weather_surcharge_warning'.tr;
    }

    if (message.isEmpty) {
      return 'normal_traffic_and_weather'.tr;
    }

    return message;
  }
}
