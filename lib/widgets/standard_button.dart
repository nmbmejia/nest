import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nest/services/app_colors.dart';

Widget customButton(String text,
    {double? width,
    void Function()? onPressed,
    Color? backgroundColor = AppColors.secondaryColor,
    Color? textColor = AppColors.whiteColor,
    bool addSpaceOnTop = true,
    bool boldText = false}) {
  return Container(
    margin: EdgeInsets.only(top: addSpaceOnTop ? 20 : 0),
    width: width ?? Get.width / 1.5,
    child: ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: backgroundColor,
          foregroundColor: AppColors.whiteColor),
      child: Text(text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: boldText ? FontWeight.bold : FontWeight.w600,
              letterSpacing: -0.5)),
    ),
  );
}
