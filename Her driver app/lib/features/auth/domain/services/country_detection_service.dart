import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:her_driver_app/features/splash/controllers/splash_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryDetectionService {
  Future<CountryCode> detectCountry() async {
    // 1. Check cached country code
    final cachedCode = await _getCachedCountryCode();
    if (cachedCode != null) {
      return cachedCode;
    }

    // 2. Try SIM card detection
    final simCountryCode = await _getSimCountryCode();
    if (simCountryCode != null) {
      await _cacheCountryCode(simCountryCode);
      return simCountryCode;
    }

    // 3. Try locale detection
    final localeCountryCode = await _getLocaleCountryCode();
    if (localeCountryCode != null) {
      await _cacheCountryCode(localeCountryCode);
      return localeCountryCode;
    }

    // 4. Try IP-based geolocation
    try {
      final response = await http.get(Uri.parse('https://ipapi.co/json/'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final ipCountryCode = CountryCode.fromCountryCode(data['country_code']);
        await _cacheCountryCode(ipCountryCode);
        return ipCountryCode;
      }
    } catch (e) {
      // Fallback to default
    }

    // 5. Fallback to default from splash controller
    final defaultCode = CountryCode.fromCountryCode(Get.find<SplashController>().config!.countryCode!);
    await _cacheCountryCode(defaultCode);
    return defaultCode;
  }

  Future<CountryCode?> _getCachedCountryCode() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('country_code');
    if (code != null) {
      return CountryCode.fromCountryCode(code);
    }
    return null;
  }

  Future<void> _cacheCountryCode(CountryCode countryCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('country_code', countryCode.code!);
  }

  Future<CountryCode?> _getSimCountryCode() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.simCountryIso != null && deviceInfo.simCountryIso!.isNotEmpty) {
        return CountryCode.fromCountryCode(deviceInfo.simCountryIso!);
      }
    }
    return null;
  }

  Future<CountryCode?> _getLocaleCountryCode() async {
    final locale = WidgetsBinding.instance.window.locale;
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      return CountryCode.fromCountryCode(locale.countryCode!);
    }
    return null;
  }
}
