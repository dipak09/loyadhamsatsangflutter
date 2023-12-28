// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/splashScreen_controller.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/SplashScreen/splash_screen_ui.dart';
import 'package:loyadhamsatsang/Utilites/device.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    DeviceConfig.rotationLock();
  }

  var Splash = Get.put(SplashScreenController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Set system UI overlays
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness:
          Brightness.dark, // Dark icons (for light status bar)
    ));
    return GetMaterialApp(
      title: 'Loyadham Satsang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.apptheme),
        useMaterial3: true,
      ),
      home: SplashScreenUI(),
      // getPages: [
      //   // GetPage(
      //   //   name: '/dailyDarshan',
      //   //   page: () => DailyDarshanScreenUI(),
      //   // ),
      //   // GetPage(
      //   //   name: '/wallpaper',
      //   //   page: () => WallpaperScreenUI(),
      //   // ),
      //   // GetPage(
      //   //   name: '/books',
      //   //   page: () => BooksScreenUI(),
      //   // ),
      // ],
    );
  }
}
