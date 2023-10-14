import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastNotifications {
  ToastNotifications._();

  static showSuccess({String? title, String? msg}) async {
    Get.snackbar(
      title ?? "Success",
      msg!,
      duration: Duration(seconds: 4),
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  static showError({String? title, String? msg}) async {
    Get.snackbar(
      title ?? "Error",
      msg!,
      duration: Duration(seconds: 4),
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }
}
