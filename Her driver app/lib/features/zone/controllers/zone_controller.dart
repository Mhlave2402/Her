import 'package:get/get.dart';
import 'package:her_driver_app/features/zone/data/zone_repository.dart';
import 'package:her_driver_app/features/location/models/address_model.dart';
import 'dart:convert';
import 'package:her_driver_app/data/api_client.dart';
import 'package:her_driver_app/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZoneController extends GetxController implements GetxService {
  final ZoneRepository zoneRepository;
  final SharedPreferences sharedPreferences;
  ZoneController({required this.zoneRepository, required this.sharedPreferences});

  AddressModel? _address;
  AddressModel? get address => _address;

  Future<void> getZone(String type) async {
    Response response = await zoneRepository.getZone(type);
    if (response.statusCode == 200) {
      _address = AddressModel.fromJson(response.body['zone']);
      sharedPreferences.setString(AppConstants.userAddress, jsonEncode(response.body['zone']));
      Get.find<ApiClient>().updateHeader(
        sharedPreferences.getString(AppConstants.token) ?? '',
        sharedPreferences.getString(AppConstants.languageCode),
        _address!.latitude,
        _address!.longitude,
        _address!.zoneId.toString(),
      );
    }
  }
}
