import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';


import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/Controllers/notification_controller.dart';

class ClearNotificationController extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;
  var Notificationlist = Get.put(NotificationController());
  Future<void> postClearAllNotification({required BuildContext context}) async {
    try {
      isLoading(true);
      update();
      String apiUrl = 'https://loyadham.in/api/webservice/clearAllNotification?token=$deviceToken';

      log(apiUrl.toString());
      final response = await dio.get(apiUrl);
      log("Notification statusCode: ${response.statusCode}");
      log("Notification data: ${response.data}");
      if (response.statusCode == 200) {
        // Success
        if(response.data['result' ] == true){
          Get.snackbar(
            'Success',
            response.data['msg'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          );
          Notificationlist.getDashboardData();
          isLoading(false);
          update();
        }else{
          Get.snackbar(
            'Success',
            response.data['msg'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          );
          isLoading(false);
          update();
        }
      } else {
        // Error
        Get.snackbar(
          'Error',
          'Failed to clear notifications.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        );
        isLoading(false);
        update();
      }
      isLoading(false);
      update();
      Navigator.pop(context);
    } catch (e) {
      print("Error : ${e}");
      Get.snackbar(
        'Error',
        'An error occurred while clearing notifications.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
      isLoading(false);
      update();
      Navigator.pop(context);
    }
  }
}
