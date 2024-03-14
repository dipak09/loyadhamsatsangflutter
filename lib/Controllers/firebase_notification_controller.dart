import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/Utilites/messaging_service.dart';

class FirebaseNotificationController extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    getFcmNotification();
    update();
  }

  Future<void> getFcmNotification() async {
   // String Token = FcmTokenService.getDeviceToken().toString();
    try {
      log("Firebase Notification Fcm Token111 -->$deviceToken");
      isLoading(true);
      update();
      String apiUrl = 'https://loyadham.in/api/webservice/getDeviceToken?token=$deviceToken';
      log(apiUrl.toString());
      final response = await dio.get(apiUrl);
      final data = response.data["result"];
      log("Firebase Notification Api Response-->$data");
      log("Firebase Notification Fcm Token -->$deviceToken");
      isLoading(false);
      update();
    } catch (e) {
      print("Error : ${e}");
      isLoading(false);
      update();
    }
  }
}
