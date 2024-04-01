import 'package:get/get.dart';
import 'package:projectname/pages/initial/controllers/intial_controller.dart';

enum AppStates { initial, inRoom }

// ignore: must_be_immutable
class HomePageController extends GetxController {
  InitialController initialController = Get.find<InitialController>();
  RxBool anyDialogOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
