import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nest/pages/initial/controllers/intial_controller.dart';
import 'package:nest/services/app_colors.dart';
import 'package:nest/services/strings.dart';
import 'package:nest/widgets/standard_button.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final initialController = Get.put(InitialController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Container(
          color: AppColors.primaryColor,
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(Strings.appName,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -3)),
              const Text(Strings.appSubtitle,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: -0.5)),
              customButton(Strings.startBtn,
                  onPressed: () =>
                      initialController.checkUserDetailsIfExists()),
            ],
          )),
        ));
  }
}
