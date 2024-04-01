import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pointly/pages/initial/controllers/intial_controller.dart';
import 'package:pointly/services/app_colors.dart';
import 'package:pointly/services/strings.dart';
import 'package:pointly/widgets/standard_button.dart';

class PermissionManagerPage extends StatefulWidget {
  const PermissionManagerPage({super.key});

  @override
  State<PermissionManagerPage> createState() => _PermissionManagerPageState();
}

class _PermissionManagerPageState extends State<PermissionManagerPage> {
  final initialController = Get.put(InitialController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            color: AppColors.primaryColor,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Strings.appName.toUpperCase(),
                    style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5)),
                const Opacity(
                  opacity: 0.3,
                  child: Text(Strings.requiresThisPermissionToWork,
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          letterSpacing: -0.5)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.location.toUpperCase(),
                              style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5)),
                          const Opacity(
                            opacity: 0.3,
                            child: Text(Strings.locationSubtitle,
                                style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: -0.5)),
                          ),
                        ],
                      ),
                      Obx(
                        () => Opacity(
                          opacity:
                              initialController.isLocationAlwaysEnabled.value
                                  ? 0.5
                                  : 1.0,
                          child: customButton(
                              initialController.isLocationAlwaysEnabled.value
                                  ? Strings.enabledButton
                                  : Strings.enableButton,
                              width: 100, onPressed: () async {
                            await Permission.location.request();
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.physicalActivity.toUpperCase(),
                              style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5)),
                          const Opacity(
                            opacity: 0.3,
                            child: Text(Strings.physicalActivitySubtitle,
                                style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: -0.5)),
                          ),
                        ],
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: customButton(Strings.enableButton,
                            width: 100, onPressed: () {}),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                customButton(Strings.continueButton,
                    onPressed: () => initialController.goToHomePage()),
              ],
            )),
          ),
        ));
  }
}
