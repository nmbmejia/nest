// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:projectname/pages/home/controllers/homepage_controller.dart';
import 'package:projectname/services/app_colors.dart';

class CustomDialog {
  simple(HomePageController homePageController, String title, String body,
      {List<Widget>? actions}) {
    dismissIfAny(homePageController);

    //! Add cancel button to dialogs that doesn't automatically close itself. Since we manually track dialog open and closing.
    try {
      Dialogs.materialDialog(
          msg: body,
          title: title,
          barrierDismissible: false,
          color: AppColors.primaryColor,
          context: Get.context!,
          msgAlign: TextAlign.center,
          msgStyle: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              letterSpacing: -0.3),
          titleAlign: TextAlign.center,
          titleStyle: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5),
          barrierColor: Colors.black.withOpacity(0.5),
          actions: actions);
      if (!homePageController.anyDialogOpen.value) {
        homePageController.anyDialogOpen.value = true;
      }
    } catch (e) {
      debugPrint('\n');
    }
  }

  custom(HomePageController homePageController,
      {Widget? body, List<Widget>? actions}) {
    dismissIfAny(homePageController);

    Dialogs.materialDialog(
        dialogWidth: Get.width / 2,
        color: AppColors.primaryColor,
        barrierDismissible: false,
        customView: body ?? Container(),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        barrierColor: Colors.black.withOpacity(0.5),
        context: Get.context!,
        actions: actions);
    if (!homePageController.anyDialogOpen.value) {
      homePageController.anyDialogOpen.value = true;
    }
  }

  dismissIfAny(HomePageController homePageController) {
    if (homePageController.anyDialogOpen.value) {
      Navigator.pop(Get.context!);
      homePageController.anyDialogOpen.value = false;
    }
  }
}

/*  SAMPLE ACTIONS
[
          IconsOutlineButton(
            onPressed: () {},
            text: 'Cancel',
            iconData: Icons.cancel_outlined,
            textStyle: TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: () {},
            text: 'Delete',
            iconData: Icons.delete,
            color: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]
        */

/*
Text(Strings.andYourContactNumber.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5)),
                const Opacity(
                  opacity: 0.3,
                  child: Text(Strings.veryImportantForEmergencies,
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          letterSpacing: -0.5)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Opacity(
                  opacity: 0.5,
                  child: TextField(
                    controller: initialController.contactTextController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 17, color: AppColors.whiteColor),
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintStyle:
                          TextStyle(fontSize: 17, color: AppColors.whiteColor),
                      hintText: Strings.maskedNumber,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    ),
                  ),
                ),
                */
