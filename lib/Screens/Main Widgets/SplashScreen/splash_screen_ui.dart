// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/splashScreen_controller.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar_ui.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  var Splash = Get.put(SplashScreenController());
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Get.off(() => BottomNavigation(
            index: 2,
          ));
    });
  }

  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: Splash.isLoading.value,
          color: Colors.white,
          opacity: 0.9,
          progressIndicator: Center(child: CircularProgressIndicator()),
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(Splash.image.toString()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ));
  }
}
