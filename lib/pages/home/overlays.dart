// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointly/pages/dialogs.dart';
import 'package:pointly/pages/home/controllers/homepage_controller.dart';
import 'package:pointly/pages/home/controllers/room_controller.dart';
import 'package:pointly/pages/initial/controllers/intial_controller.dart';
import 'package:pointly/services/app_colors.dart';
import 'package:pointly/services/strings.dart';
import 'package:pointly/widgets/profile_avatar.dart';
import "package:pointly/widgets/string_extension.dart";

import 'package:pointly/widgets/standard_button.dart';

class Overlays extends StatefulWidget {
  const Overlays({super.key});

  @override
  State<Overlays> createState() => _OverlaysState();
}

class _OverlaysState extends State<Overlays> {
  HomePageController homePageController = Get.find<HomePageController>();
  RoomController roomController = Get.find<RoomController>();
  InitialController initialController = Get.find<InitialController>();

  @override
  void initState() {
    toggleAnimation();
    super.initState();
  }

  void toggleAnimation() {
    Future.delayed(const Duration(milliseconds: animationSpeedInMS), () {
      if (expandingWidth.value == 0) {
        expandingWidth.value = extensionWidth;
      } else {
        expandingWidth.value = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => homePageController.currentState.value == AppStates.initial
        ? inInitial()
        : homePageController.currentState.value == AppStates.inRoom
            ? inRoom()
            : Container(
                child: const Center(child: Text('Unknown Mode')),
              ));
  }

  Widget inInitial() {
    return SafeArea(
      child: Stack(children: [stage(), createOrJoinButton()]),
    );
  }

  Widget inRoom() {
    return SafeArea(
      child: Stack(children: [stage(), roomNameButton()]),
    );
  }

  //! NOT IN A ROOM

  /// Main Button for Creating/Joining
  Widget createOrJoinButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: customButton(
          addSpaceOnTop: false,
          Strings.createRoomButtonOrJoin.capitalizeFirstWordLetter(),
          onPressed: () {
        roomController.resetVariables();
        showCreateOrJoinDialog(homePageController, roomController);
      }, backgroundColor: AppColors.primaryColor),
    );
  }

  //! WHEN IN A ROOM

  /// Main Button for Creating/Joining
  Widget roomNameButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: visibilityButton(),
          ),
          customButton(
              homePageController.roomName.value == ''
                  ? 'HOME'
                  : homePageController.roomName.value.toUpperCase(),
              addSpaceOnTop: false, onPressed: () {
            showRoomMenu(homePageController, roomController, initialController);
          }, backgroundColor: AppColors.primaryColor, boldText: true),
          Flexible(
            child: alertButton(),
          ),
        ],
      ),
    );
  }

  /// Visibility Button
  Widget visibilityButton() {
    return Container(
        padding: const EdgeInsets.all(0.0),
        child: ElevatedButton(
          onPressed: () {
            roomController.isVisible.value = !roomController.isVisible.value;
            homePageController.toggleUser0Visibility();
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(9),
            backgroundColor: AppColors.primaryColor, // <-- Button color
            foregroundColor: AppColors.blueGreyColor, // <-- Splash color
          ),
          child: Obx(
            () => Icon(
                homePageController.isUser0Visible().value
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: homePageController.isUser0Visible().value
                    ? AppColors.batteryGreenColor
                    : AppColors.blueGreyColor,
                size: 18),
          ),
        ));
  }

  /// Alert Button
  Widget alertButton() {
    return Obx(
      () => Container(
          padding: const EdgeInsets.all(0.0),
          child: ElevatedButton(
            onPressed: () {
              showOptionToAlertDialog(homePageController, roomController);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(9),
              backgroundColor: AppColors.primaryColor, // <-- Button color
              foregroundColor: AppColors.blueGreyColor, // <-- Splash color
            ),
            child: Icon(
              Icons.warning,
              color: roomController.isOnAlert.value
                  ? AppColors.batteryYellowColor
                  : Colors.white,
              size: 18,
            ),
          )),
    );
  }

  /// STAGE ELEMENTS
  RxDouble expandingWidth = 0.0.obs;

  static const int animationSpeedInMS = 500;
  static const double stageElementWidth = 70;
  static const double circleSize = 50;
  static const double extensionWidth = 350;

  double offsetFromRight = 20;
  double stageHeight = Get.height / 2;

  Widget stage() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: stageElementWidth,
        margin: const EdgeInsets.only(right: 15),
        height: stageHeight,
        /*
                    ShaderMask(
                      shaderCallback: (Rect rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.purple,
                          ],
                          stops: [
                            0.8,
                            1
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(rect);
                      },*/
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: homePageController.currentState.value == AppStates.initial
              ? 1
              : 1,
          itemBuilder: (context, index) {
            // StageMember stageMember = homePageController.stageMembers[index];
            return stageElement(index,
                batteryPercentage: 100,
                isVisible: true,
                isExpanded: true,
                // isVisible: stageMember.visibility,
                // isExpanded:
                //     stateController.selectedUserFromStage.value == index,
                onTap: () => roomController.setSelectedUserFromStage(index));
          },
        ),
      ),
    );
  }

  Widget stageElement(index,
      {int batteryPercentage = 50,
      bool isCharging = false,
      bool isVisible = true,
      bool isExpanded = false,
      void Function()? onTap}) {
    return Opacity(
      opacity: isVisible ? 1.0 : 0.75,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Visibility(
              visible: isExpanded,
              child: Positioned(
                right: offsetFromRight,
                child: Obx(
                  () => AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: animationSpeedInMS),
                    height: stageElementWidth / 1.6,
                    width: expandingWidth.value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryColor,
                    ),
                    child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        margin: EdgeInsets.only(right: offsetFromRight),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                '${initialController.firstName.value} ${initialController.lastName}'
                                    .toUpperCase(),
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        roomController.getBatteryIcon(
                                            batteryPercentage,
                                            isCharging: isCharging),
                                        size: 12.0,
                                        color: roomController.getBatteryColor(
                                            batteryPercentage,
                                            isCharging: isCharging),
                                      ),
                                      Text(
                                        '$batteryPercentage%',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            color:
                                                roomController.getBatteryColor(
                                                    batteryPercentage,
                                                    isCharging: isCharging),
                                            fontWeight: FontWeight.normal),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.update,
                                      size: 12.0,
                                      color: AppColors.blueGreyColor,
                                    ),
                                    Opacity(
                                      opacity: 0.8,
                                      child: Text(
                                        '3 mins ago',
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            customProfileAvatar(
                size: 50,
                onTap: () {
                  if (roomController.selectedUserFromStage.value != index) {
                    expandingWidth.value = 0.0;
                    Future.delayed(
                        const Duration(milliseconds: animationSpeedInMS), () {
                      toggleAnimation();
                    });
                  }
                  if (onTap != null) {
                    onTap();
                  }
                })
          ],
        ),
      ),
    );
  }
}
