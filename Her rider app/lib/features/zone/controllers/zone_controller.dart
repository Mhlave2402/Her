import 'package:get/get.dart';
import 'package:her_user_app/features/zone/data/zone_repository.dart';
import 'package:her_user_app/features/address/domain/models/address_model.dart';
import 'dart:convert';
import 'package:her_user_app/data/api_client.dart';
import 'package:her_user_app/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZoneController extends GetxController implements GetxService {
  final ZoneRepository zoneRepository;
  final SharedPreferences sharedPreferences;
  ZoneController({required this.zoneRepository, required this.sharedPreferences});

  Address? _address;
  Address? get address => _address;

  String? get currencySymbol => "\$";
  String? get currencyPosition => "left";
  String? get currencyDecimalPoint => ".";

  Future<void> getZone(String type) async {
    Response response = await zoneRepository.getZone(type);
    if (response.statusCode == 200) {
      _address = Address.fromJson(response.body['zone']);
      sharedPreferences.setString(AppConstants.userAddress, jsonEncode(response.body['zone']));
      Get.find<ApiClient>().updateHeader(
        sharedPreferences.getString(AppConstants.token) ?? '',
        _address,
      );
    }
  }
}
