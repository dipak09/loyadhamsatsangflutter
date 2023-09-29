import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/LoginScreen/login_screen_ui.dart';
import '../../../Constants/app_images.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.off(() => LoginScreenUI());
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppImages.splashImage,
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
