import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointly/pages/home/controllers/room_controller.dart';
import 'package:pointly/services/app_colors.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

Widget customProfileAvatar({
  double size = 50,
  int batteryPercentage = 100,
  bool isCharging = false,
  String? name,
  Color backGroundColor = AppColors.primaryColor,
  void Function()? onTap,
}) {
  RoomController roomController = Get.find<RoomController>();
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: SizedBox(
      width: size,
      child: FittedBox(
        child: Material(
            type: MaterialType
                .transparency, //Makes it usable on any background color, thanks @IanSmith
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(
                    color: roomController.getBatteryColor(batteryPercentage,
                        isCharging: isCharging),
                    width: 4.0),
                color: backGroundColor,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                //This keeps the splash effect within the circle
                borderRadius: BorderRadius.circular(
                    1000.0), //Something large to ensure a circle
                onTap: () {
                  if (onTap != null) {
                    onTap();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: name != null
                      ? Center(
                          child: Text(name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        )
                      : const Icon(
                          Icons.person,
                          size: 30.0,
                          color: Colors.white,
                        ),
                ),
              ),
            )),
      ),
    ),
  );

  // return SizedBox(
  //   width: size,
  //   child: FittedBox(
  //     child: Material(
  //         type: MaterialType
  //             .transparency, //Makes it usable on any background color, thanks @IanSmith
  //         child: Ink(
  //           decoration: BoxDecoration(
  //             border:
  //                 Border.all(color: AppColors.batteryGreenColor, width: 4.0),
  //             color: backGroundColor,
  //             shape: BoxShape.circle,
  //           ),
  //           child: InkWell(
  //             //This keeps the splash effect within the circle
  //             borderRadius: BorderRadius.circular(
  //                 1000.0), //Something large to ensure a circle
  //             onTap: () {
  //               if (onTap != null) {
  //                 onTap();
  //               }
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.all(20.0),
  //               child: name != null
  //                   ? Center(
  //                       child: Text(name,
  //                           style: const TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w600)),
  //                     )
  //                   : const Icon(
  //                       Icons.person,
  //                       size: 30.0,
  //                       color: Colors.white,
  //                     ),
  //             ),
  //           ),
  //         )),
  //   ),
  // );
}

Widget customProfileAvatarMarker({
  double size = 50,
  int batteryPercentage = 100,
  bool isCharging = false,
  String? name,
  Color backGroundColor = AppColors.primaryColor,
  void Function()? onTap,
}) {
  RoomController roomController = Get.find<RoomController>();
  return RepaintBoundary(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: SizedBox(
        width: size,
        child: FittedBox(
          child: Material(
              type: MaterialType
                  .transparency, //Makes it usable on any background color, thanks @IanSmith
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: roomController.getBatteryColor(batteryPercentage,
                          isCharging: isCharging),
                      width: 4.0),
                  color: backGroundColor,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  //This keeps the splash effect within the circle
                  borderRadius: BorderRadius.circular(
                      1000.0), //Something large to ensure a circle
                  onTap: () {
                    if (onTap != null) {
                      onTap();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: name != null
                        ? Center(
                            child: Text(name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          )
                        : const Icon(
                            Icons.person,
                            size: 30.0,
                            color: Colors.white,
                          ),
                  ),
                ),
              )),
        ),
      ),
    ),
  );

  // return SizedBox(
  //   width: size,
  //   child: FittedBox(
  //     child: Material(
  //         type: MaterialType
  //             .transparency, //Makes it usable on any background color, thanks @IanSmith
  //         child: Ink(
  //           decoration: BoxDecoration(
  //             border:
  //                 Border.all(color: AppColors.batteryGreenColor, width: 4.0),
  //             color: backGroundColor,
  //             shape: BoxShape.circle,
  //           ),
  //           child: InkWell(
  //             //This keeps the splash effect within the circle
  //             borderRadius: BorderRadius.circular(
  //                 1000.0), //Something large to ensure a circle
  //             onTap: () {
  //               if (onTap != null) {
  //                 onTap();
  //               }
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.all(20.0),
  //               child: name != null
  //                   ? Center(
  //                       child: Text(name,
  //                           style: const TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w600)),
  //                     )
  //                   : const Icon(
  //                       Icons.person,
  //                       size: 30.0,
  //                       color: Colors.white,
  //                     ),
  //             ),
  //           ),
  //         )),
  //   ),
  // );
}
