import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/wallet/domain/services/wallet_service_interface.dart';

class PayoutSettingsController extends GetxController implements GetxService {
  final WalletServiceInterface walletServiceInterface;

  PayoutSettingsController({required this.walletServiceInterface});

  bool _isAutoWithdrawEnabled = false;
  bool get isAutoWithdrawEnabled => _isAutoWithdrawEnabled;

  String _payoutSchedule = 'weekly';
  String get payoutSchedule => _payoutSchedule;

  final TextEditingController _thresholdController = TextEditingController();
  TextEditingController get thresholdController => _thresholdController;

  void toggleAutoWithdraw(bool value) {
    _isAutoWithdrawEnabled = value;
    update();
  }

  void setPayoutSchedule(String value) {
    _payoutSchedule = value;
    update();
  }

  Future<void> saveSettings() async {
    // Call the API to save the settings
  }
}
