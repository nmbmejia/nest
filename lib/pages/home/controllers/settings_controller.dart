import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nest/pages/home/controllers/homepage_controller.dart';

enum LimitingUnit { mins, hours, days }

// ignore: must_be_immutable
class SettingsController extends GetxController {
  TextEditingController trackingLengthTextController = TextEditingController();
  TextEditingController maxGuestsTextController = TextEditingController();
  HomePageController homePageController = Get.find<HomePageController>();

  RxString roomLink = ''.obs;
  RxString username = ''.obs;
  RxInt trackingLength = 60.obs;
  Rx<LimitingUnit> trackingLengthUnit = LimitingUnit.mins.obs;
  RxInt maxGuests = 10.obs;
  RxBool allowAllerts = true.obs;

  @override
  void onInit() {
    setDefaultValues();
    super.onInit();
  }

  void setDefaultValues() async {
    // roomLink.value = await SharedStorage.getRoomLink() ?? '';
    // username.value = await SharedStorage.getUsername() ?? '';
    // trackingLength.value = await SharedStorage.getTrackingLength() ?? 60;
    // trackingLengthUnit.value =
    //     await SharedStorage.getTrackingLengthUnit() ?? LimitingUnit.mins;
    // maxGuests.value = await SharedStorage.getMaxGuests() ?? 10;
    // allowAllerts.value = await SharedStorage.getAllowAlerts() ?? true;

    if (true) {
      debugPrint('============SETTINGS==============');
      debugPrint('Max Tracking Time: ${trackingLength.value}');
      debugPrint('Tracking unit: ${trackingLengthUnit.value}');
      debugPrint('Max Guests Count: ${maxGuests.value}');
    }
    trackingLengthTextController.text = trackingLength.value.toString();
    maxGuestsTextController.text = maxGuests.value.toString();
  }

  void setTrackingLength() async {
    int length = int.parse(trackingLengthTextController.text);
    trackingLength.value = length;
    // await SharedStorage.saveTrackingLength(length);
  }

  void setTrackingLengthUnit(LimitingUnit unit) async {
    trackingLengthUnit.value = unit;
    // await SharedStorage.saveTrackingLengthUnit(unit.toString());
  }

  void setMaxGuests() async {
    int mG = int.parse(maxGuestsTextController.text);
    maxGuests.value = mG;
    // await SharedStorage.saveMaxGuests(mG);
  }

  void setAllowAlerts() async {
    bool setTo = !allowAllerts.value;
    allowAllerts.value = setTo;
    // await SharedStorage.saveAllowAllerts(setTo);
  }
}
