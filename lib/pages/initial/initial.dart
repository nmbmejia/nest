import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointly/pages/initial/controllers/intial_controller.dart';
import 'package:pointly/services/app_colors.dart';
import 'package:pointly/services/strings.dart';
import 'package:pointly/widgets/standard_button.dart';

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
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            color: AppColors.primaryColor,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Strings.appName,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -3)),
                Text(Strings.appSubtitle,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: -0.5)),
                customButton(Strings.startNowButton,
                    onPressed: () =>
                        initialController.checkUserDetailsIfExists()),
              ],
            )),
          ),
        ));
  }
}
