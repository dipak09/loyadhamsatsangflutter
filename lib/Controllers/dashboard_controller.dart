// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/ImagesData.dart';

class DashboardController extends GetxController {
  Dio dio = Dio();
  List<Dashboardata> sliderList = [];
  List<Dashboardata> livestreamingList = [];
  List<Dashboardata> dailyDarshanList = [];
  List<Dashboardata> featuredMediaList = [];
  List<Dashboardata> upcomingEventList = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getDashboardData();
  }

  Future<void> getDashboardData() async {
    try {
      isLoading(true);
      update();

      String apiUrl = 'https://loyadham.in/api/webservice/home';

      final response = await dio.get(
        apiUrl,
      );
      final data = response.data;

      final sliderData = data['slider'];
      sliderData.forEach((el) {
        Dashboardata slider = Dashboardata.fromJson(el);
        sliderList.add(slider);
      });
      final livestreamingData = data['livestreaming'];

      livestreamingData.forEach((el) {
        Dashboardata livestreaming = Dashboardata.fromJson(el);
        livestreamingList.add(livestreaming);
      });

      final dailydarshansData = data['dailydarshans'];
      dailydarshansData.forEach((el) {
        Dashboardata dailydarshans = Dashboardata.fromJson(el);
        dailyDarshanList.add(dailydarshans);
      });
      final featuredMediaData = data['featuredmedia'];

      featuredMediaData.forEach((el) {
        Dashboardata featuredMedia = Dashboardata.fromJson(el);
        featuredMediaList.add(featuredMedia);
      });
      final upcomingEventData = data['upcomingevent'];

      upcomingEventData.forEach((el) {
        Dashboardata upcomingEvent = Dashboardata.fromJson(el);
        upcomingEventList.add(upcomingEvent);
      });

      isLoading(false);
      update();
    } catch (e) {
      print("Error : ${e}");
    }
  }
}
