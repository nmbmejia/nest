import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointly/pages/dialogs.dart';
import 'package:pointly/pages/home/controllers/homepage_controller.dart';
import 'package:pointly/services/app_colors.dart';
import 'package:pointly/services/shared_storage.dart';
import 'package:pointly/services/strings.dart';
import 'package:pointly/widgets/custom_dialog.dart';
import 'package:pointly/widgets/custom_snackbar.dart';

enum ExpiryUnit { minutes, hours, day }

// ignore: must_be_immutable
class RoomController extends GetxController {
  HomePageController homePageController = Get.find<HomePageController>();
  TextEditingController roomCodeTextEditingController = TextEditingController();
  TextEditingController roomNameTextEditingController = TextEditingController();
  TextEditingController roomExpiryTextEditingController =
      TextEditingController(text: '60');
  Rx<ExpiryUnit> roomExpiryUnit = ExpiryUnit.minutes.obs;
  RxBool isJoiningRoom = false.obs;
  RxBool isCreatingRoom = false.obs;

  RxInt selectedUserFromStage = 0.obs;

  RxBool isVisible = false.obs;
  RxBool isOnAlert = false.obs;

  @override
  void onInit() {
    autoJoinLastSavedRoom();

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void leaveRoom() {
    showLeavingRoomDialog(homePageController, this);
    Future.delayed(const Duration(seconds: 3), () async {
      // If success
      CustomDialog().dismissIfAny(homePageController);
      homePageController.currentState.value = AppStates.initial;
      await SharedStorage.deleteLastJoinedRoom();
      // Else if failed
    });
  }

  void autoJoinLastSavedRoom() async {
    await SharedStorage.getLastJoinedRoom().then((roomCode) {
      if (roomCode != null) {
        if (roomCode.isNotEmpty) {
          debugPrint('User has an existing room code: $roomCode');
          joinRoom(roomCode, isLastSaved: true);
        }
      }
    });
  }

  void resetVariables() {
    isVisible.value = false;
    isOnAlert.value = false;
    homePageController.roomName.value = '';
    roomCodeTextEditingController.clear();
    roomNameTextEditingController.clear();
    roomExpiryTextEditingController.text = '60';
    roomExpiryUnit.value = ExpiryUnit.minutes;
  }

  bool validateRoomParameters() {
    bool res = false;
    int roomExpiryNumber =
        int.tryParse(roomExpiryTextEditingController.text) ?? 0;
    if (roomExpiryUnit.value == ExpiryUnit.minutes) {
      res = roomExpiryNumber >= 10 && roomExpiryNumber <= 60 ? true : false;
      if (!res) {
        CustomSnackbar().simple(Strings.minuteError);
      } else {
        return true;
      }
    } else if (roomExpiryUnit.value == ExpiryUnit.hours) {
      res = roomExpiryNumber >= 1 && roomExpiryNumber <= 24 ? true : false;
      if (!res) {
        CustomSnackbar().simple(Strings.hourError);
      } else {
        return true;
      }
    } else if (roomExpiryUnit.value == ExpiryUnit.day) {
      res = roomExpiryNumber >= 1 && roomExpiryNumber <= 3 ? true : false;
      if (!res) {
        CustomSnackbar().simple(Strings.dayError);
      } else {
        return true;
      }
    }
    return res;
  }

  void createRoom() {
    if (roomNameTextEditingController.text.length > 2) {
      if (validateRoomParameters()) {
        isCreatingRoom.value = true;
        showCreatingRoomDialog(homePageController, this);
        Future.delayed(const Duration(seconds: 5), () {
          // If success
          debugPrint('Creating room ${roomNameTextEditingController.text}...');
          CustomDialog().dismissIfAny(homePageController);
          homePageController.currentState.value = AppStates.inRoom;
          homePageController.roomName.value =
              roomNameTextEditingController.text;
          SharedStorage.saveLastJoinedRoom('XXXASD');
          // Else if failed

          isCreatingRoom.value = false;
        });
      }
    } else {
      CustomSnackbar().simple(Strings.longerName);
    }
  }

  void joinRoom(String roomCode, {bool isLastSaved = false}) {
    isJoiningRoom.value = true;
    showJoiningRoomDialog(homePageController, this, isLastSaved: isLastSaved);
    Future.delayed(const Duration(seconds: 5), () {
      // If success
      debugPrint('Joining room $roomCode...');
      CustomDialog().dismissIfAny(homePageController);
      homePageController.currentState.value = AppStates.inRoom;
      homePageController.roomName.value = 'HOME';
      SharedStorage.saveLastJoinedRoom(roomCode);
      // Else if failed

      isJoiningRoom.value = false;
    });
  }

  void sendAlert() {
    CustomDialog().dismissIfAny(homePageController);
    if (!isVisible.value) {
      CustomSnackbar().simple(
          'You have sent an alert valid for 5 seconds and can be seen in the map.');
    } else {
      CustomSnackbar().simple('You have sent an alert valid for 5 seconds.');
    }

    isOnAlert.value = true;
    isVisible.value = true;

    // For testing only, reset.
    Future.delayed(const Duration(seconds: 5), () {
      isOnAlert.value = false;
      isVisible.value = false;
    });
  }

  final removeSymbol = RegExp(r'[^\w\s]+');
  void onRoomCodeInput(String text) {
    EasyDebounce.debounce(
        'roomInputDebounce', const Duration(milliseconds: 500), () {
      String trimmedRoomCode = text.replaceAll(removeSymbol, '');
      if (trimmedRoomCode.length == 6) {
        joinRoom(trimmedRoomCode, isLastSaved: false);
      }
    });
  }

  void setSelectedUserFromStage(int index) {
    if (index == 0) {
      homePageController.recenterCamera();
    }
    selectedUserFromStage.value = index;
    debugPrint('selectedUserFromStage ${selectedUserFromStage.value}');
  }

  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';

  IconData getBatteryIcon(
    int percentage, {
    bool isCharging = false,
  }) {
    if (isCharging) {
      return Icons.battery_charging_full;
    } else {
      if (percentage >= 80) {
        return Icons.battery_full;
      } else if (percentage >= 70) {
        return Icons.battery_6_bar;
      } else if (percentage >= 60) {
        return Icons.battery_5_bar;
      } else if (percentage >= 50) {
        return Icons.battery_4_bar;
      } else if (percentage >= 30) {
        return Icons.battery_3_bar;
      } else if (percentage >= 15) {
        return Icons.battery_2_bar;
      } else if (percentage >= 5) {
        return Icons.battery_1_bar;
      } else if (percentage < 5) {
        return Icons.battery_0_bar;
      }
    }
    return Icons.battery_unknown;
  }

  Color getBatteryColor(
    int percentage, {
    bool isCharging = false,
  }) {
    if (isCharging) {
      return AppColors.batteryChargingColor;
    } else {
      if (percentage >= 80) {
        return AppColors.batteryGreenColor;
      } else if (percentage >= 70) {
        return AppColors.batteryGreenColor;
      } else if (percentage >= 60) {
        return AppColors.batteryGreenColor;
      } else if (percentage >= 50) {
        return AppColors.batteryGreenColor;
      } else if (percentage >= 30) {
        return AppColors.batteryGreenColor;
      } else if (percentage >= 15) {
        return AppColors.batteryRedColor;
      } else if (percentage >= 5) {
        return AppColors.batteryRedColor;
      } else if (percentage < 5) {
        return AppColors.batteryRedColor;
      }
    }
    return AppColors.whiteColor;
  }
}
