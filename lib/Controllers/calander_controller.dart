// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Calander.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Calendar/calender_screen_ui.dart';

class CalanderController extends GetxController {
  Dio dio = Dio();
  List<CalenderData> list = [];
  var calendarDataList = <CalenderData>[].obs;
  RxBool isLoading = false.obs;
  var startdate, enddate;
  @override
  void onInit() {
    super.onInit();
    getData(startdate, enddate);
  }

  Future<void> getData(var startdate, var enddate) async {
    try {
      isLoading(true);
      update();
      list = [];
      isLoading(true);
      update();
      //2023-12-31
      String apiUrl =
          'https://cms.swaminarayanbhagwan.org/wp-json/sb/v1/calendar?start_date=${startdate == null ? "2024-01-01" : startdate}&end_date=${enddate == null ? "2024-12-31" : enddate}';

      final response = await dio.get(apiUrl);
      log(apiUrl);

      final data = response.data;
      print("Calander Data : ${data['data']}");
      data['data'].forEach((el) {
        CalenderData calander = CalenderData.fromJson(el);
        list.add(calander);
      });
      calendarDataList.value = list;
      print(list.length);
      print("Calander list.length : ${list.length}");
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
