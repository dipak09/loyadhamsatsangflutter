import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/Models/notification_status_model.dart';

class UpdateNotificationStatusController extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;
// Initialize with null
  Future<void> updateNotificationStatus(bool value) async {
    try {
      isLoading(true);
      update();
      String apiUrl = 'https://loyadham.in/api/webservice/userNotificationSetting?token=$deviceToken&is_notification_allow=$value';

      log(apiUrl.toString());
      final response = await dio.get(apiUrl);
      log("is_notification_allow statusCode: ${response.statusCode}");
      log("is_notification_allow data: ${response.data}");
      if (response.statusCode == 200) {
        // Parse JSON response into NotificationStatus model
      } else {
        // Handle error
      }
      isLoading(false);
      update();
    } catch (e) {
      print("Error : ${e}");

      isLoading(false);
      update();
    }
  }
}
