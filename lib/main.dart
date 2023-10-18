// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/splashScreen_controller.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/SplashScreen/splash_screen_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var Splash = Get.put(SplashScreenController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
