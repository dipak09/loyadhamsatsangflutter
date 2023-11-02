// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  // var Splash = Get.put(SplashScreenController());
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Get.off(() => BottomNavigation(index: 2));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.splashScreen),
                    fit: BoxFit.fill))));
  }
}
