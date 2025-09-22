import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayHelper {
  static void showCustomSnackBar(String message, {bool isError = true}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      isDismissible: true,
    ));
  }
}
