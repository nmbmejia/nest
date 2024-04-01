import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointly/pages/initial/controllers/intial_controller.dart';
import 'package:pointly/services/app_colors.dart';
import 'package:pointly/services/strings.dart';
import 'package:pointly/widgets/standard_button.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: AppColors.primaryColor,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Strings.whatsYourName.toUpperCase(),
                    style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5)),
                const Opacity(
                  opacity: 0.3,
                  child: Text(Strings.youCanChangeThisLaterToo,
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
                    controller: initialController.firstNameTextController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                        fontSize: 17, color: AppColors.whiteColor),
                    decoration: const InputDecoration(
                      hintStyle:
                          TextStyle(fontSize: 17, color: AppColors.whiteColor),
                      hintText: Strings.firstName,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: TextField(
                    controller: initialController.lastNameTextController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                        fontSize: 17, color: AppColors.whiteColor),
                    decoration: const InputDecoration(
                      hintStyle:
                          TextStyle(fontSize: 17, color: AppColors.whiteColor),
                      hintText: Strings.lastName,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                const SizedBox(
                  height: 50,
                ),
                customButton(Strings.continueButton,
                    onPressed: () => initialController.saveUserDetails()),
              ],
            )),
          ),
        ));
  }
}
