import 'package:google_maps_flutter/google_maps_flutter.dart';

class StageMember {
  bool isUser0;
  // Upper data not needed in Firebase
  String name;
  String contactNumber;
  String? deviceId;
  String? deviceModel;
  bool isOnAlert;
  bool isVisible;
  bool isArrived;
  Marker? marker;
  Marker? markerStored;
  LatLng position;
  int? battery;
  int? speed;
  DateTime? lastUpdatedAt;

  StageMember(
      {required this.isUser0,
      required this.name,
      required this.contactNumber,
      required this.deviceId,
      required this.deviceModel,
      required this.isOnAlert,
      required this.isVisible,
      required this.isArrived,
      required this.marker,
      required this.markerStored,
      required this.position,
      required this.battery,
      required this.speed,
      required this.lastUpdatedAt});
}
