// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Utilites/ToastNotification.dart';

class ContactUSController extends GetxController {
  Dio dio = Dio();

  final nameController = TextEditingController();
  final emailidController = TextEditingController();
  final msgController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> sendFeedback() async {
    try {
      isLoading(true);
      update();
      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/contact?name=${nameController.text.trim()}&email_id=${emailidController.text.trim()}&message=${msgController.text.trim()}';

      final response = await dio.post(apiUrl);
      final data = response.data;
      print(data);
      if (data['validation'] == true) {
        nameController.clear();
        emailidController.clear();

        msgController.clear();
        ToastNotifications.showSuccess(msg: data['msg']);
      } else {
        ToastNotifications.showError(msg: data['msg']);
      }
      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      // Handle any errors
      print('Error: $error');
    }
  }
}
