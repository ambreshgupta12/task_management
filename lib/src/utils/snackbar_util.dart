import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/src/constants/color_constants.dart';
import 'package:task_manager/src/constants/string_constants.dart';

class SnackBarUtils {
  static void showSuccessSnackBar({required String message}) {
    Get.snackbar(
      KString.success,
      message,
      backgroundColor: KColors.successColor,
      colorText: KColors.whiteColor,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  static void showErrorSnackBar({required String message}) {
    Get.snackbar(
      KString.error,
      message,
      colorText: KColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: KColors.errorColor,
        duration: const Duration(seconds: 2)
    );
  }
}
