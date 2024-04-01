import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointly/pages/home/controllers/room_controller.dart';
import 'package:pointly/services/app_colors.dart';

class ProfileAvatarMarker extends StatelessWidget {
  const ProfileAvatarMarker({
    super.key,
    this.size = 120,
    this.batteryPercentage = 100,
    this.isCharging = false,
    this.name,
    this.backgroundColor = AppColors.primaryColor,
  });

  final double size;
  final int batteryPercentage;
  final bool isCharging;
  final String? name;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    RoomController roomController = Get.find<RoomController>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: SizedBox(
        width: size,
        child: FittedBox(
          child: Material(
              type: MaterialType
                  .transparency, //Makes it usable on any background color, thanks @IanSmith
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: roomController.getBatteryColor(batteryPercentage,
                          isCharging: isCharging),
                      width: 4.0),
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: name != null
                      ? Center(
                          child: Text(name ?? '-',
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
              )),
        ),
      ),
    );
  }
}
