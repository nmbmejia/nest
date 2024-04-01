import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectname/pages/home/controllers/homepage_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Get.lazyPut<HomePageController>(() => HomePageController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (homepageController) {
      return const Scaffold(
        body: Column(
          children: [],
        ),
      );
    });
  }
}
