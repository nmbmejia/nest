// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nest/pages/home/homepage.dart';

// ignore: must_be_immutable
class InitialController extends GetxController {
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController contactTextController = TextEditingController();

  // Local user data
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString contactNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void checkUserDetailsIfExists() async {
    // Login
    goToHomePage();
  }

  void goToHomePage() {
    Get.offAll(const HomePage());
  }
}
