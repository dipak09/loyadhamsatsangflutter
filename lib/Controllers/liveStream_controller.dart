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
      log("livestreamchannel123${response}");
      final data = response.data;

      data['livestreaming'].forEach((el) {
        Channel1 liveStreamData = Channel1.fromJson(el);
        livestreamchannel.add(liveStreamData);
      });
      // final liveData = data[0]['channel1'];
      // log(liveData.toString());
     // Channel1 slider = Channel1.fromJson(liveData);
      //Channel1 slider = Channel1.fromJson(liveData);
      // livestreamchannel.add(Channel1(
      //   initialId: "4LflXoYsQq4",
      //   thumbnail: "https://i.ytimg.com/vi/4LflXoYsQq4/mqdefault_live.jpg",
      //   title: "🔴Live Swaminarayan Aarti | 04-03-2024 | Loyadham Mandir",
      //   youtubeLink:"https://youtu.be/2YaXl9pc5is"
      // ));
      log("livestreamchannel123${livestreamchannel.length}");
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
