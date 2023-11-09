// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Calander.dart';

class CalanderController extends GetxController {
  Dio dio = Dio();
  List<CalenderData> list = [];
  var calendarDataList = <CalenderData>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    try {
      isLoading(true);
      update();
      list = [];
      isLoading(true);
      update();
      String apiUrl =
          'https://cms.swaminarayanbhagwan.org/wp-json/sb/v1/calendar?start_date=2023-01-01&end_date=2023-12-31';

      final response = await dio.get(apiUrl);

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
