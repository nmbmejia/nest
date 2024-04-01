import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointly/pages/home/controllers/homepage_controller.dart';

class MapFunctions {
  HomePageController homePageController = Get.find<HomePageController>();
  void showAllMarkerView() {
    LatLngBounds? getMarkerBounds = _bounds();
    if (getMarkerBounds != null) {
      homePageController.mapController
          .animateCamera(CameraUpdate.newLatLngBounds(getMarkerBounds, 50));
    }
  }

  LatLngBounds? _bounds() {
    // if (homePageController.mapMarkers.isEmpty) return null;
    // return _createBounds(
    //     homePageController.mapMarkers.map((m) => m.position).toList());
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    //https://stackoverflow.com/questions/58094316/fit-markers-on-the-screen-with-flutter-google-maps
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }
}
