import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../Models/featureMedia.dart';

class FeaturedmediaController extends GetxController {
  Dio dio = Dio();
  List<FeaturedMediaDetail> list = [];
  //.var calendarDataList = <Calender>[].obs;
  RxBool isLoading = false.obs;
  var startdate, enddate;
  @override
  void onInit() {
    super.onInit();
     getData();
  }

  Future<void> getData() async {
    try {
      isLoading(true);
      update();
      //  list = [];
      isLoading(true);
      update();
      //2023-12-31
      String apiUrl =
          'https://loyadham.in/api/webservice/getYoutubeFeaturedMedia';

      final response = await dio.get(apiUrl);
      log(apiUrl);

      final data = response.data;

      data['featured_media'].forEach((el) {
        FeaturedMediaDetail featuredMediaDetail =
            FeaturedMediaDetail.fromJson(el);
        list.add(featuredMediaDetail);
        print("Featured Media--------->" + list.toString());
        // Calender calander = Calender.fromJson(el);
        // list.add(calander);
      });
      //calendarDataList.value = list;
      // print(list.length);
      // print("Calander list.length : ${list.length}");
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
