import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/Models/live_stream.dart';
import 'package:loyadhamsatsang/Models/notificationModel.dart';

class NotificationController extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;
  List<Notification> notificationData = [];

  clearList(){
    notificationData.clear();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getDashboardData();
  }

  Future<void> getDashboardData() async {
    try {
      isLoading(true);
      notificationData.clear();
      update();
      String apiUrl = 'https://loyadham.in/api/webservice/notificationData?token=$deviceToken';
      log(apiUrl.toString());
      final response = await dio.get(apiUrl);
      final data = response.data["notification"];
      data.forEach((el) {
        print(el.toString());
        Notification slider = Notification.fromJson(el);
        notificationData.add(slider);
      });

      // liveData.forEach((el) {

      // });
      isLoading(false);
      update();
    } catch (e) {
      print("Error : ${e}");
      isLoading(false);
      update();
    }
  }
}
