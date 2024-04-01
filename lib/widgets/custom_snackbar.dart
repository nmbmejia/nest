import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:projectname/services/app_colors.dart';

class CustomSnackbar {
  simple(String content) {
    showToast(
      content,
      fullWidth: true,
      backgroundColor: AppColors.whiteColor,
      textPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      shapeBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      context: Get.context!,
      animation: StyledToastAnimation.fadeScale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      animDuration: const Duration(milliseconds: 1500),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }
}
