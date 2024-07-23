

import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/Controllers/splashScreen_controller.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/SplashScreen/splash_screen_ui.dart';
import 'package:loyadhamsatsang/Utilites/device.dart';
import 'package:loyadhamsatsang/Utilites/messaging_service.dart';
import 'package:loyadhamsatsang/firebase_options.dart';
// import 'package:timezone/timezone.dart' as tz;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   // options: DefaultFirebaseOptions.currentPlatform,
  // );
  // Plugin must be initialized before using
  // await FlutterDownloader.initialize(
  //     debug: true, // optional: set to false to disable printing logs to console (default: true)
  //     ignoreSsl: true // option: set to false to disable working with http links (default: false)
  // );

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



class _MyAppState extends State<MyApp> {
  String location = 'Unknown';
// String timeZone = 'Unknown';
  DateTime dateTimeInTimeZone = DateTime.now();
  List<String> _availableTimezones = <String>[];
  // String _timezone = 'Unknown';
  // Future<Position> _determinePosition() async {
  //   // Check if location services are enabled
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled return an error message
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   // Check location permissions
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // If permissions are granted, return the current location
  //   return await Geolocator.getCurrentPosition();
  // }
  //
  // Future<void> getPosition() async {
  //   try {
  //     // Call _determinePosition to get the user's current position
  //     Position position = await _determinePosition();
  //
  //     // Extract latitude and longitude from the position object
  //     double latitude = position.latitude;
  //     double longitude = position.longitude;
  //     DateTime dateTime = position.timestamp;
  //
  //     // Print the latitude and longitude
  //     print('Latitude: $latitude, Longitude: $longitude, dateTime: $dateTime');
  //    tz.Location timezone = await getTimezoneFromCoordinates(latitude, longitude);
  //     print('Timezone: ${timezone.name}');
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }
  //
  // Future<tz.Location> getTimezoneFromCoordinates(
  //     double latitude, double longitude) async {
  //   // Reverse geocode the coordinates to get the address
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(latitude, longitude);
  //
  //   print('placemarks: ${placemarks}');
  //
  //   // Extract the timezone identifier from the placemark
  //   Placemark placemark = placemarks.first;
  //   String timezoneName = placemark.isoCountryCode!;
  //
  //   // Find the timezone by name
  //   tz.Location? location = tz.getLocation("Asia/Kolkata");
  //   print('location: ${location}');
  //   return location;
  // }
  // final _messagingService = MessagingService();
  Future<void> _initData() async {
    try {
      timeZone = await FlutterTimezone.getLocalTimezone();
    } catch (e) {
      print('Could not get the local timezone');
    }
    try {
      _availableTimezones = await FlutterTimezone.getAvailableTimezones();
      _availableTimezones.sort();
    } catch (e) {
      print('Could not get available timezones');
    }
    if (mounted) {
      setState(() {});
    }
    DateTime dateTime = DateTime.now();
    print("timeZoneName${dateTime.timeZoneName}");
    log("###_availableTimezones${_availableTimezones}###");
    log("@@@finalTimezone${timeZone}@@@");
  }
  // Future<String> getTimezoneFromCoordinates(double latitude, double longitude) async {
  //   // Get the location details based on latitude and longitude
  //   tz.Location location = tz.getLocation(latitude, longitude);
  //   tz.Location location = tz.getLocation(latitude, longitude);
  //
  //   // Get the timezone identifier
  //   String timezone = location.timeZoneId;
  //
  //   return timezone;
  // }

  @override
  void initState() {
    super.initState();
     _initData();
   // _determinePosition();
   // getPosition();
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
        //colorScheme: ColorScheme.fromSeed(seedColor: AppColors.apptheme),
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
