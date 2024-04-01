import 'dart:async';
import 'dart:io';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:pointly/models/stage_members_model.dart';
import 'package:pointly/pages/initial/controllers/intial_controller.dart';
import 'package:pointly/services/stage_member_directory.dart';
import 'package:pointly/widgets/custom_snackbar.dart';
import 'package:pointly/widgets/profile_avatar_marker.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

enum AppStates { initial, inRoom }

// ignore: must_be_immutable
class HomePageController extends GetxController {
  bool anyDialogOpen = false;
  Rx<AppStates> currentState = AppStates.initial.obs;
  InitialController initialController = Get.find<InitialController>();
  final Completer<GoogleMapController> tmpInitializer =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;
  CameraPosition initialPosition = const CameraPosition(
      target: LatLng(7.038889479964407, 125.5110292479172));

  // Streams
  late StreamSubscription<Position> positionStream;

  // Room things
  bool isUser0Initialized = false;
  RxList<StageMember> stageMembers = <StageMember>[].obs;
  RxString roomName = ''.obs;

  @override
  void onInit() {
    currentState.value = AppStates.initial;
    // initializeUser0();
    super.onInit();
  }

  @override
  void dispose() {
    positionStream.cancel();
    mapController.dispose();
    super.dispose();
  }

  void refreshObservables() {
    stageMembers.refresh();
  }

  // Local device properties
  Future<int> getBatteryLevel() async {
    return int.tryParse(
            (await BatteryInfoPlugin().androidBatteryInfo)?.health ?? '') ??
        (await BatteryInfoPlugin().iosBatteryInfo)?.batteryLevel ??
        -1;
  }

  Future<String> getDeviceModel() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final info = await DeviceInfoPlugin().iosInfo;
      return info.name;
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      return androidInfo.model;
    }
  }

  // [USER0] FUNCTIONALITIES

  void initializeUser0() async {
    // Just one time variables
    String fullName =
        '${initialController.firstName.value} ${initialController.lastName}';
    String contactNumber = initialController.contactNumber.value;
    int batteryLevel = await getBatteryLevel();
    Position position = await Geolocator.getCurrentPosition();
    String? deviceId = await PlatformDeviceId.getDeviceId;
    String deviceModel = await getDeviceModel();
    // Creation of marker
    Marker marker = Marker(
        markerId: MarkerId(StageMemberDirectory.user0),
        icon: await const ProfileAvatarMarker().toBitmapDescriptor(
            logicalSize: const Size(150, 150), imageSize: const Size(150, 150)),
        position: LatLng(position.latitude, position.longitude));

    recenterCamera();

    stageMembers.add(StageMember(
        isUser0: true,
        name: fullName,
        contactNumber: contactNumber,
        deviceId: deviceId,
        deviceModel: deviceModel,
        isOnAlert: false,
        isVisible: true,
        isArrived: false,
        marker: marker,
        markerStored: null,
        position: LatLng(position.latitude, position.longitude),
        battery: batteryLevel,
        speed: 0,
        lastUpdatedAt: DateTime.now()));

    refreshObservables();

    // Activate position listener
    positionStream = Geolocator.getPositionStream().listen((position) async {
      EasyThrottle.throttle(
          'updateUser', // <-- An ID for this particular throttler
          const Duration(milliseconds: 5000), // <-- The throttle duration
          () {
        updateUser0Position(StageMemberDirectory.user0,
            LatLng(position.latitude, position.longitude));
      });
    });
  }

  StageMember? user0() {
    int indexOfUser0 =
        stageMembers.indexWhere((member) => member.isUser0 == true);
    if (indexOfUser0 == -1) {
      return null;
    }
    return stageMembers[indexOfUser0];
  }

  RxBool isUser0Visible() {
    if (user0()?.marker != null && user0()?.isVisible == true) {
      return true.obs;
    } else {
      return false.obs;
    }
  }

  // [STAGE MEMBER] FUNCTIONALITIES

  void toggleUser0Visibility() {
    if (user0()?.marker != null) {
      user0()?.markerStored = user0()?.marker?.copyWith();
      user0()?.marker = null;
      user0()?.isVisible = false;
    } else {
      user0()?.isVisible = true;
      user0()?.marker = user0()?.markerStored?.copyWith();
      user0()?.markerStored = null;
    }
    refreshObservables();
  }

  void updateUser0Position(String userId, LatLng newPosition) {
    if (user0()?.marker != null) {
      user0()?.position = newPosition;
      user0()?.marker = user0()?.marker?.copyWith(positionParam: newPosition);
    } else {
      if (user0()?.markerStored != null) {
        user0()?.position = newPosition;
        user0()?.markerStored =
            user0()?.markerStored?.copyWith(positionParam: newPosition);
      }
    }
    refreshObservables();
  }

  Future<void> startSharing() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    int? androidBatt =
        (await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel;
    int? iosBatt = (await BatteryInfoPlugin().iosBatteryInfo)?.batteryLevel;

    CustomSnackbar().simple('Link copied to clipboard!');
  }

  void endSharing() {
    // currentMode.value = AppMode.homepage;
  }

  void initialize(GoogleMapController controller) async {
    tmpInitializer.complete(controller);

    await tmpInitializer.future.then((value) {
      mapController = value;
      initializeUser0();
    });
  }

  void initializeIcons() {
    // BitmapDescriptor.fromAssetImage(
    //         const ImageConfiguration(), "assets/icon/marker.png")
    //     .then(
    //   (icon) {
    //     markerIcon = icon;
    //   },
    // );
  }

  void setSelectedUser(int index) {
    // if (index != selectedUser.value) {
    //   selectedUser.value = index;
    // }
  }

  void recenterCamera({LatLng? target, double zoom = 15}) async {
    if (target == null) {
      Position defaultTarget = await Geolocator.getCurrentPosition();
      await mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(defaultTarget.latitude, defaultTarget.longitude),
            zoom: zoom),
      ));
    } else {
      await mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom),
      ));
    }
  }
}
