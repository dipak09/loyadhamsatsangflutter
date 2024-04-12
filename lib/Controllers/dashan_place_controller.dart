// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/darshan_place_res_model.dart';
import 'package:loyadhamsatsang/Models/event_place_model.dart';

class DarshanPlaceController extends GetxController {
  Dio dio = Dio();
  List<DarshanPlaceResModel> darshanPlaceList = [];

  RxBool isLoading = false.obs;
  List<String> darshanPlaceItems = [];

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    try {
      isLoading(true);
      update();
      darshanPlaceList = [];
      darshanPlaceItems = [];
      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/getDailyDarshanPlaces';

      final response = await dio.get(
        apiUrl,
      );
      log("photosUrl${apiUrl}");
      final data = response.data;
      print(data.toString());
      data.forEach((el) {
        DarshanPlaceResModel events = DarshanPlaceResModel.fromJson(el);
        darshanPlaceList.add(events);
      });
      log("eventPlaceList${darshanPlaceList.length}");

      for (int i = 0; i < darshanPlaceList.length; i++) {
        darshanPlaceItems.add(darshanPlaceList[i].title.toString());
      }
      log("eventPlaceItems${darshanPlaceItems.length}");
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
