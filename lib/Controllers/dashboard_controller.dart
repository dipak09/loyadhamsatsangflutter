// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/helper.dart';
import 'package:loyadhamsatsang/Models/DailyDarshan.dart';
import 'package:loyadhamsatsang/Models/ImagesData.dart';
import 'package:loyadhamsatsang/Models/Video.dart';
import 'package:loyadhamsatsang/Models/featureMedia.dart';
import 'package:loyadhamsatsang/Models/live_stream.dart';
import 'package:loyadhamsatsang/Models/todays_bhajan_model.dart';
import 'package:loyadhamsatsang/Models/upcomingEvents.dart';

class DashboardController extends GetxController {
  Dio dio = Dio();
  String? dailyDarshan_title;
  String? dailyDarshan_date;

  List<Dashboardata> sliderList = [];
  List<Channel1> livestreamingList = [];
  List<DailyDarshan> dailyDarshanList = [];
  //List<UpcomingEvent> upcomingEventList = [];
  List<TodayBhajan> todayBhajanEventList = [];

  List<FeaturedMediaDetail> featureMediaList = [];
  RxBool isLoading = false.obs;
  RxBool isLoadingBhajan = false.obs;
  @override
  void onInit() {
    super.onInit();
    print("object>>>>>>>>>");
    getBhajans();
    getDashboardData();
  }

  Future<void> getDashboardData() async {
    try {
      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/home?token=$deviceToken';

      final response = await dio.get(
        apiUrl,
      );
      final data = response.data;
      dailyDarshan_title = data['dailydarshan_title'];
      print("Daily Darshan : ${dailyDarshan_title}");
      dailyDarshan_date = data['dailydarshan_date'];
      print("Daily Darshan : ${dailyDarshan_date}");

      final sliderData = data['slider'];
      if (sliderData == null || sliderData == []) {
        sliderList = [];
      } else {
        sliderData.forEach((el) {
          Dashboardata slider = Dashboardata.fromJson(el);
          sliderList.add(slider);
        });
      }

      final livestreamingData = data['livestreaming'];
      if (livestreamingData == null || livestreamingData == []) {
        livestreamingList = [];
      } else {
        livestreamingData.forEach((el) {
          Channel1 livestreaming = Channel1.fromJson(el);
          livestreamingList.add(livestreaming);
        });
      }
      final dailydarshansData = data['dailydarshans'];
      if (dailydarshansData == null || dailydarshansData == []) {
        dailyDarshanList = [];
      } else {
        dailydarshansData.forEach((el) {
          DailyDarshan dailydarshans = DailyDarshan.fromJson(el);
          dailyDarshanList.add(dailydarshans);
        });
      }

      final featureMediaData = data['featuredmedia'];
      if (featureMediaData == null || featureMediaData == []) {
        featureMediaList = [];
      } else {
        featureMediaData.forEach((el) {
          FeaturedMediaDetail featureMediaRse =
              FeaturedMediaDetail.fromJson(el);
          featureMediaList.add(featureMediaRse);
        });
      }

      // final todayBhajanData = data['todaysBhajan'];
      // if (todayBhajanData == null || todayBhajanData == []) {
      //   todayBhajanEventList = [];
      // } else {
      //   todayBhajanData.forEach((el) {
      //     TodaysBhajan todaysBhajanRes = TodaysBhajan.fromJson(el);
      //     todayBhajanEventList.add(todaysBhajanRes);
      //     print("today bhajan List#${todayBhajanEventList.length}");
      //   });
      // }
      log("liveStreamData!!!${livestreamingList.length}");

      isLoading(false);
      update();
    } catch (e) {
      isLoading(false);
      update();
      print("Error : ${e}");
    }
  }

  Future<void> getBhajans() async {
    try {
      isLoadingBhajan(true);
      update();

      String apiUrl =
          'https://loyadham.in/api/webservice/getBhajans?token=$deviceToken';

      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        final data = response.data;
        print('Data:::${data}');
        todayBhajanEventList.clear();
        for (var e in data) {
          todayBhajanEventList.add(TodayBhajan.fromJson(e));
        }
        isLoadingBhajan(false);
        update();
      } else {
        isLoadingBhajan(false);
        update();
      }
    } catch (e) {
      isLoadingBhajan(false);
      update();
      print("Error : ${e}");
    }
  }
}
