// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pointly/pages/home/controllers/homepage_controller.dart';
import 'package:pointly/pages/home/controllers/room_controller.dart';
import 'package:pointly/pages/home/homepage.dart';
import 'package:pointly/pages/initial/permission_manager.dart';
import 'package:pointly/pages/initial/questionnaire.dart';
import 'package:pointly/services/shared_storage.dart';
import 'package:pointly/widgets/custom_snackbar.dart';

// ignore: must_be_immutable
class InitialController extends GetxController {
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController contactTextController = TextEditingController();

  // Local user data
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString contactNumber = ''.obs;

  RxBool isLocationAlwaysEnabled = false.obs;

  @override
  void onInit() {
    checkPermissions();
    super.onInit();
  }

  void checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      closeApp();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        closeApp();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      closeApp();
    }

    isLocationAlwaysEnabled.value = true;
  }

  void checkUserDetailsIfExists() async {
    firstName.value = await SharedStorage.getFirstName() ?? '';
    lastName.value = await SharedStorage.getLastName() ?? '';
    contactNumber.value = await SharedStorage.getPhoneNumber() ?? '';
    if (firstName.value.isNotEmpty &&
        lastName.value.isNotEmpty &&
        contactNumber.value.isNotEmpty) {
      Get.to(const PermissionManagerPage());
    } else {
      Get.to(const QuestionnairePage());
    }
  }

  Future<void> saveUserDetails() async {
    String _firstName = firstNameTextController.text;
    String _lastName = lastNameTextController.text;
    String _contactNumber = contactTextController.text;
    if (_firstName.isNotEmpty &&
        _lastName.isNotEmpty &&
        _contactNumber.isNotEmpty) {
      if (_contactNumber.length == 11 &&
          (_contactNumber.split('')[0] == '0' &&
              _contactNumber.split('')[1] == '9')) {
        firstName.value = _firstName;
        lastName.value = _lastName;
        contactNumber.value = _contactNumber;
        await SharedStorage.saveFirstName(_firstName);
        await SharedStorage.saveLastName(_lastName);
        await SharedStorage.savePhoneNumber(_contactNumber);
        Get.to(const PermissionManagerPage());
      } else {
        CustomSnackbar().simple('Contact number is invalid.');
      }
    } else {
      CustomSnackbar().simple('Please fill out all fields.');
    }
  }

  void goToHomePage() {
    Get.offAll(const HomePage());
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
