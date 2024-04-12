import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/Models/notification_status_model.dart';

class GetNotificationStatusController extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;
  RxBool notification = true.obs;
  Rx<NotificationStatus?> notificationStatus = Rx<NotificationStatus?>(null); // Initialize with null

  Future<void> getNotificationStatus() async {
    try {
      isLoading(true);
      update();
      String apiUrl = 'https://loyadham.in/api/webservice/userNotificationSetting?token=$deviceToken';

      log(apiUrl.toString());
      final response = await dio.get(apiUrl);
      log("Notification statusCode: ${response.statusCode}");
      log("Notification data: ${response.data}");
      if (response.statusCode == 200) {
        // Parse JSON response into NotificationStatus model
        final jsonData = response.data;
        if (jsonData != null) {
          notificationStatus.value = NotificationStatus.fromJson(jsonData);
          notification(notificationStatus.value!.isNotificationAllowed);
        }
      } else {
        // Handle error
        // For now, let's set notificationStatus to null
        notificationStatus.value = null;
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
