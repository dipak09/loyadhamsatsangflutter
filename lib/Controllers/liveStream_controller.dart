import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/live_stream.dart';

class LiveStreamController extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;
  List<Channel1> livestreamchannel = [];

  @override
  void onInit() {
    super.onInit();
    getDashboardData();
  }

  Future<void> getDashboardData() async {
    try {
      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/getYoutubeChannelsLatestLiveVideos';
      log(apiUrl.toString());
      final response = await dio.get(apiUrl);
      final data = response.data;
      final liveData = data[0]['channel1'];
      log(liveData.toString());
      Channel1 slider = Channel1.fromJson(liveData);
      livestreamchannel.add(slider);

      // liveData.forEach((el) {

      // });
      isLoading(false);
      update();
    } catch (e) {
      isLoading(false);
      update();
      print("Error : ${e}");
    }
  }
}
