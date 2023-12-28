// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/DailyDarshan.dart';
import 'package:loyadhamsatsang/Models/ImagesData.dart';
import 'package:loyadhamsatsang/Models/Video.dart';

class DashboardController extends GetxController {
  Dio dio = Dio();
  String? dailyDarshan_title;
  String? dailyDarshan_date;

  List<Dashboardata> sliderList = [];
  List<Video> livestreamingList = [];
  List<DailyDarshan> dailyDarshanList = [];
  List<Video> upcomingEventList = [];
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
      dailyDarshan_title = data['dailydarshan_title'];
      print("Daily Darshan : ${dailyDarshan_title}");
      dailyDarshan_date = data['dailydarshan_date'];
      print("Daily Darshan : ${dailyDarshan_date}");

      final sliderData = data['slider'];
      sliderData.forEach((el) {
        Dashboardata slider = Dashboardata.fromJson(el);
        sliderList.add(slider);
      });
      final livestreamingData = data['livestreaming'];
      if (livestreamingData == null || livestreamingData == []) {
        livestreamingList = [];
      } else {
        livestreamingData.forEach((el) {
          Video livestreaming = Video.fromJson(el);
          livestreamingList.add(livestreaming);
        });
      }
      final dailydarshansData = data['dailydarshans'];
      dailydarshansData.forEach((el) {
        DailyDarshan dailydarshans = DailyDarshan.fromJson(el);
        dailyDarshanList.add(dailydarshans);
      });

      final upcomingEventData = data['upcomingevent'];
      if (upcomingEventData == null || upcomingEventData == []) {
        upcomingEventList = [];
      } else {
        upcomingEventData.forEach((el) {
          Video upcomingEvent = Video.fromJson(el);
          upcomingEventList.add(upcomingEvent);
        });
      }

      isLoading(false);
      update();
    } catch (e) {
      print("Error : ${e}");
    }
  }
}
