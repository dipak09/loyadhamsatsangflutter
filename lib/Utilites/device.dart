import 'package:flutter/services.dart';

class DeviceConfig {
  DeviceConfig._();
  static rotationLock() async {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
