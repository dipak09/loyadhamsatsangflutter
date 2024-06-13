// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/Models/upcomingEvents.dart';

class UpComingEventController extends GetxController {
  Dio dio = Dio();


  List<UpcomingEvent> upcomingEventList = [];

  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getUpcomingEventData();
  }

  Future<void> getUpcomingEventData() async {
    try {
      isLoading(true);
      update();

      String apiUrl = 'https://loyadham.in/api/webservice/getUpcomingCalenderEvent?token=$deviceToken';

      final response = await dio.get(
        apiUrl,
      );
      final data = response.data;

      final upcomingEventData = data['upcoming_event'];
      if (upcomingEventData == null || upcomingEventData == []) {
        upcomingEventList = [];
      } else {
        upcomingEventData.forEach((el) {
          UpcomingEvent upcomingEvent = UpcomingEvent.fromJson(el);
          upcomingEventList.add(upcomingEvent);
        });
      }

      isLoading(false);
      update();
    } catch (e) {
      isLoading(false);
      update();
      print("Error : ${e}");
    }
  }
}
