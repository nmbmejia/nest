import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holdable_button/holdable_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pointly/pages/home/controllers/homepage_controller.dart';
import 'package:pointly/pages/home/controllers/room_controller.dart';
import 'package:pointly/pages/initial/controllers/intial_controller.dart';
import 'package:pointly/services/app_colors.dart';
import 'package:pointly/services/strings.dart';
import 'package:pointly/widgets/custom_dialog.dart';
import 'package:pointly/widgets/standard_button.dart';
import 'package:pointly/widgets/string_extension.dart';

//! ROOM RELATED

showRoomMenu(HomePageController homePageController,
    RoomController roomController, InitialController initialController) {
  RxBool showSpaceHistory = false.obs;
  return CustomDialog().custom(homePageController, roomController,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  Strings.inviteCodeForRoom + homePageController.roomName.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.tertiaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5)),
              const SizedBox(
                height: 5,
              ),
              const Text(Strings.sampleRoom,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.copy,
                    size: 14,
                    color: AppColors.blueGreyColor,
                  ),
                  Text(Strings.clickToCopy,
                      style: TextStyle(
                          color: AppColors.blueGreyColor,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          letterSpacing: -0.5)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(Strings.sessionEndsOn,
                  style: TextStyle(
                      color: AppColors.tertiaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5)),
              const SizedBox(
                height: 5,
              ),
              const Text('January 6, 2024 3:00pm',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  showSpaceHistory.value = !showSpaceHistory.value;
                },
                child: Text(
                    showSpaceHistory.value
                        ? Strings.hideRoomHistory
                            .toLowerCase()
                            .capitalizeFirstWordLetter()
                        : Strings.showRoomHistory
                            .toLowerCase()
                            .capitalizeFirstWordLetter(),
                    style: TextStyle(
                        color: AppColors.tertiaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5)),
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible: showSpaceHistory.value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.copy,
                      size: 14,
                      color: AppColors.blueGreyColor,
                    ),
                    Text(Strings.clickToCopy,
                        style: TextStyle(
                            color: AppColors.blueGreyColor,
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.5)),
                  ],
                ),
              ),
              Visibility(
                visible: showSpaceHistory.value,
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      color: AppColors.roomHistoryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Icon(Icons.location_history_rounded,
                                    size: 40, color: AppColors.whiteColor),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${initialController.firstName} ${initialController.lastName}\narrived in the area.',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'January 5\n11:32AM',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ]),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              customButton(
                Strings.leaveRoom.capitalizeFirstWordLetter(),
                backgroundColor: AppColors.secondaryColor,
                textColor: AppColors.whiteColor,
                onPressed: () {
                  roomController.leaveRoom();
                },
              ),
              cancelButton(
                homePageController,
              )
            ],
          ),
        ),
      ),
      actions: []);
}

cancelButton(HomePageController homePageController) {
  return customButton(Strings.cancelButton,
      backgroundColor: AppColors.whiteColor,
      textColor: AppColors.primaryColor,
      addSpaceOnTop: false,
      onPressed: () => CustomDialog().dismissIfAny(homePageController));
}

showSendingAlertDialog(
  HomePageController homePageController,
  RoomController roomController,
) {}

showOptionToAlertDialog(
  HomePageController homePageController,
  RoomController roomController,
) {
  return CustomDialog().simple(homePageController, roomController,
      'To send an alert', 'Hold the following button for 5 seconds',
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HoldableButton(
              width: 100,
              height: 100,
              buttonColor: AppColors.batteryYellowColor,
              loadingColor: AppColors.whiteColor,
              radius: 100.0,
              duration: 5,
              startPoint: 0.25,
              onConfirm: () {
                roomController.sendAlert();
              },
              strokeWidth: 10,
              child: const Text('Hold'),
            ),
            const SizedBox(
              height: 8,
            ),
            cancelButton(
              homePageController,
            )
          ],
        )
      ]);
}

showLeavingRoomDialog(
  HomePageController homePageController,
  RoomController roomController,
) {
  return CustomDialog().simple(homePageController, roomController,
      Strings.leavingRoom, Strings.pleaseWait,
      actions: [
        const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ]);
}

showCreatingRoomDialog(
  HomePageController homePageController,
  RoomController roomController,
) {
  return CustomDialog().simple(homePageController, roomController,
      Strings.creatingRoom, Strings.pleaseWait,
      actions: [
        const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ]);
}

showJoiningRoomDialog(
    HomePageController homePageController, RoomController roomController,
    {bool isLastSaved = false}) {
  return CustomDialog().simple(
      homePageController,
      roomController,
      isLastSaved ? Strings.joiningLastRoom : Strings.joiningRoom,
      Strings.pleaseWait,
      actions: [
        const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ]);
}

showCreateOrJoinDialog(
  HomePageController homePageController,
  RoomController roomController,
) {
  return CustomDialog().simple(
      homePageController, roomController, Strings.enterYourCode, '',
      actions: [
        Center(
          child: Column(
            children: [
              Opacity(
                opacity: 0.5,
                child: TextField(
                  autofocus: true,
                  showCursor: false,
                  controller: roomController.roomCodeTextEditingController,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.characters,
                  style: const TextStyle(
                      fontSize: 30, color: AppColors.whiteColor),
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    counterText: "",
                    hintStyle:
                        TextStyle(fontSize: 30, color: AppColors.whiteColor),
                    hintText: Strings.sampleRoom,
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  ),
                  inputFormatters: [
                    MaskTextInputFormatter(
                        mask: 'AAA-AAA', type: MaskAutoCompletionType.lazy)
                  ],
                  onChanged: (text) {
                    roomController.onRoomCodeInput(text);
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () =>
                    showCreateRoomDialog(homePageController, roomController),
                child: const Text(Strings.createARoom,
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5)),
              ),
              const SizedBox(
                height: 5,
              ),
              cancelButton(
                homePageController,
              )
            ],
          ),
        )
      ]);
}

showCreateRoomDialog(
  HomePageController homePageController,
  RoomController roomController,
) {
  RxBool showSettings = false.obs;
  return CustomDialog().simple(
      homePageController, roomController, Strings.createARoom, '',
      actions: [
        Center(
          child: Obx(
            () => Column(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: TextField(
                    autofocus: true,
                    showCursor: false,
                    controller: roomController.roomNameTextEditingController,
                    textAlign: TextAlign.center,
                    maxLength: 30,
                    textCapitalization: TextCapitalization.characters,
                    style: const TextStyle(
                        fontSize: 30, color: AppColors.whiteColor),
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintStyle:
                          TextStyle(fontSize: 30, color: AppColors.whiteColor),
                      hintText: Strings.sampleRoomName,
                      counterText: "",
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    ),
                  ),
                ),
                Visibility(
                  visible: showSettings.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  border: Border.all(
                                      width: 1, color: AppColors.whiteColor)),
                              child: Center(
                                child: TextField(
                                  controller: roomController
                                      .roomExpiryTextEditingController,
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLength: 2,
                                  showCursor: false,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 32,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintStyle: TextStyle(
                                        fontSize: 32,
                                        color: AppColors.primaryColor
                                            .withOpacity(0.5),
                                        fontWeight: FontWeight.bold),
                                    hintText: '60',
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(Strings.expiresAfter,
                                    style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -0.5)),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          roomController.roomExpiryUnit.value =
                                              ExpiryUnit.minutes;
                                        },
                                        child: Opacity(
                                          opacity: roomController
                                                      .roomExpiryUnit.value ==
                                                  ExpiryUnit.minutes
                                              ? 1.0
                                              : 0.5,
                                          child: Text(Strings.minutes,
                                              style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontSize: roomController
                                                              .roomExpiryUnit
                                                              .value ==
                                                          ExpiryUnit.minutes
                                                      ? 14
                                                      : 10,
                                                  fontWeight: roomController
                                                              .roomExpiryUnit
                                                              .value ==
                                                          ExpiryUnit.minutes
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  letterSpacing: -0.5)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          roomController.roomExpiryUnit.value =
                                              ExpiryUnit.hours;
                                        },
                                        child: Opacity(
                                          opacity: roomController
                                                      .roomExpiryUnit.value ==
                                                  ExpiryUnit.hours
                                              ? 1.0
                                              : 0.5,
                                          child: Text(Strings.hours,
                                              style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontSize: roomController
                                                              .roomExpiryUnit
                                                              .value ==
                                                          ExpiryUnit.hours
                                                      ? 14
                                                      : 10,
                                                  fontWeight: roomController
                                                              .roomExpiryUnit
                                                              .value ==
                                                          ExpiryUnit.hours
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  letterSpacing: -0.5)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          roomController.roomExpiryUnit.value =
                                              ExpiryUnit.day;
                                        },
                                        child: Opacity(
                                          opacity: roomController
                                                      .roomExpiryUnit.value ==
                                                  ExpiryUnit.day
                                              ? 1.0
                                              : 0.5,
                                          child: Text(Strings.days,
                                              style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontSize: roomController
                                                              .roomExpiryUnit
                                                              .value ==
                                                          ExpiryUnit.day
                                                      ? 14
                                                      : 10,
                                                  fontWeight: roomController
                                                              .roomExpiryUnit
                                                              .value ==
                                                          ExpiryUnit.day
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  letterSpacing: -0.5)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                    roomController.roomExpiryUnit.value ==
                                            ExpiryUnit.minutes
                                        ? Strings.minuteError
                                        : roomController.roomExpiryUnit.value ==
                                                ExpiryUnit.hours
                                            ? Strings.hourError
                                            : Strings.dayError,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 8,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    border: Border.all(
                                        width: 1, color: AppColors.whiteColor)),
                                child: const Center(
                                  child: Icon(
                                    Icons.lock,
                                    size: 30.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            const Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.setAreaNotifs,
                                      style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.5)),
                                  Text(Strings.setAreaNotifsSubtitle,
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 8,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: !showSettings.value,
                  child: InkWell(
                    onTap: () {
                      showSettings.value = true;
                    },
                    child: const Text(Strings.changeSettings,
                        style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                customButton(Strings.createButton,
                    onPressed: () => roomController.createRoom()),
                cancelButton(homePageController)
              ],
            ),
          ),
        )
      ]);
}
