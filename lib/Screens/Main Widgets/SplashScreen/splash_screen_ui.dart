import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/Controllers/firebase_notification_controller.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar_ui.dart';
import 'package:loyadhamsatsang/Utilites/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {

  String? token;
  getToken() async {
    SharedPreferenceService prefs = SharedPreferenceService();
    token = (await prefs.getStringData('fcmToken'));
    setState(() {
      deviceToken = token;
    });
  }
 //  var Splash = Get.put(SplashScreenController());
  @override
  void initState() {
    super.initState();
    appInfo();
    getToken();
     //firebaseNotificationController.getFcmNotification();
    Timer(Duration(seconds: 5), () {
      Get.off(() => BottomNavigation(index: 2));
    });
  }

  appInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    log("appName-->$appName");
    log("packageName-->$packageName");
    log("version-->$version");
    log("buildNumber-->$buildNumber");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.splashScreen),
                    fit: BoxFit.fill))));
  }
}
