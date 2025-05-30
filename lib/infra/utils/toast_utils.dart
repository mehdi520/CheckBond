import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../configs/config_exports.dart';

class ToastUtils {
  static void showSuccess(String message) {
    _showToast(message, backgroundColor: AppColors.success);
  }

  static void showError(String message) {
    _showToast(message, backgroundColor: AppColors.error);
  }

  static void showInfo(String message) {
    _showToast(message, backgroundColor: AppColors.info);
  }

  static void _showToast(String message, {Color backgroundColor = AppColors.secondary900}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: backgroundColor,
      textColor: AppColors.white,
      fontSize: 14.0,
    );
  }
}
