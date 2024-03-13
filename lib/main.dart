// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/splashScreen_controller.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/SplashScreen/splash_screen_ui.dart';
import 'package:loyadhamsatsang/Utilites/device.dart';
import 'package:loyadhamsatsang/Utilites/messaging_service.dart';
import 'package:loyadhamsatsang/firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final _messagingService = MessagingService();

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    DeviceConfig.rotationLock();
    _messagingService.init(context);
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
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.red, selectionHandleColor: Colors.blue),
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
