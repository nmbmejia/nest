import 'package:animated_marker/animated_marker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointly/pages/home/controllers/homepage_controller.dart';
import 'package:pointly/pages/home/controllers/room_controller.dart';
import 'package:pointly/pages/home/overlays.dart';
import 'package:pointly/services/app_colors.dart';
import 'package:pointly/services/stage_member_directory.dart';
import 'package:pointly/widgets/profile_avatar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int animationDurationInSeconds = 2;
  double iconSize = 22;
  double mainButtonSizes = 45;

  EdgeInsets paddingForCircles = const EdgeInsets.all(10);
  RxDouble blurStart = 3.0.obs;
  RxDouble blurEnd = 0.0.obs;

  @override
  void initState() {
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<RoomController>(() => RoomController());
    super.initState();
  }

  void toggleBlur() {
    blurStart.value == 3.0 ? blurStart.value = 0.0 : blurStart.value = 3.0;
    blurEnd.value == 0.0 ? blurEnd.value = 3.0 : blurEnd.value = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (homepageController) {
      return Scaffold(
        body: Stack(
          children: [
            Obx(() {
              debugPrint('\n\n\n');
              debugPrint('******** INITIALIZE MAP**********');
              debugPrint(
                  '# of Markers: ${homepageController.stageMembers.map((member) => member.marker).whereType<Marker>().length}');
              debugPrint(
                  '# of Members: ${homepageController.stageMembers.length}');
              debugPrint('*********************************');
              return GoogleMap(
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: homepageController.initialPosition,
                markers: homepageController.stageMembers
                    .map((member) => member.marker)
                    .whereType<Marker>()
                    .toSet(),
                onMapCreated: (GoogleMapController controller) {
                  homepageController.initialize(controller);
                },
              );
            }),
            // ignore: void_checks
            const Overlays()
          ],
        ),
      );
    });
  }
}
