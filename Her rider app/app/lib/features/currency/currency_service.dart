import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyService with ChangeNotifier {
  String _currencyCode = 'ZAR';
  String _currencySymbol = 'R';
  double _exchangeRate = 1.0;

  String get currencyCode => _currencyCode;
  String get currencySymbol => _currencySymbol;
  double get exchangeRate => _exchangeRate;

  Future<void> initialize() async {
    try {
      // Get current location
      final position = await Geolocator.getCurrentPosition();
      
      // Call backend to get zone and currency info
      final baseUrl = 'http://localhost'; // Fetched from Laravel .env file
      final response = await http.post(
        Uri.parse('$baseUrl/api/get-currency-by-location'),
        body: jsonEncode({
          'latitude': position.latitude,
          'longitude': position.longitude,
          'type': 'user', // Identify as user app
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _updateCurrency(
          data['currencyCode'] ?? 'ZAR',
          data['currencySymbol'] ?? 'R',
          data['exchangeRate'] ?? 1.0,
        );
      }
    } catch (e) {
      // Fallback to default currency
      _updateCurrency('ZAR', 'R', 1.0);
    }
  }

  void _updateCurrency(String code, String symbol, double rate) {
    _currencyCode = code;
    _currencySymbol = symbol;
    _exchangeRate = rate;
    notifyListeners();
  }

  String format(double amount) {
    final format = NumberFormat.currency(
      symbol: _currencySymbol,
      decimalDigits: 2,
      locale: _getLocaleFromCurrency(_currencyCode),
    );
    return format.format(amount);
  }

  String _getLocaleFromCurrency(String currencyCode) {
    final mapping = {
      'ZAR': 'en_ZA',
      'USD': 'en_US',
      'EUR': 'de_DE',
      'GBP': 'en_GB',
      'NGN': 'en_NG',
      'KES': 'sw_KE',
    };
    return mapping[currencyCode] ?? 'en_US';
  }

  // Convert amount from base currency to local currency
  double convertToLocalCurrency(double baseAmount) {
    return baseAmount * _exchangeRate;
  }

  // Convert amount from local currency to base currency
  double convertToBaseCurrency(double localAmount) {
    return localAmount / _exchangeRate;
  }
}
