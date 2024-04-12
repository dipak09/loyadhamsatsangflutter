import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Video.dart';
import 'package:loyadhamsatsang/Models/youtubevideo.dart';

var apitoken;

class IndiaChannelController extends GetxController {
  Dio dio = Dio();
  List<ListYoutubeVideo> videoList = [];
  var isLoading = false.obs;
  var token = "".obs;
  var pageno = 1.obs;

  @override
  void onInit() {
    super.onInit();
    get(0);
  }

  // void get(int? i) {
  //   if (i == 0) {
  //     videoList.clear();
  //     pageno = 1.obs;
  //     getData("US", "", "");
  //   } else {
  //     videoList.clear();
  //     pageno = 1.obs;
  //     getData("IN", "", "");
  //   }
  // }

  void get(int? i) {
    // Check if data has already been loaded for the selected tab
    if ((i == 0 && videoList.isEmpty) || (i == 1 && videoList.isEmpty)) {
      // If data hasn't been loaded, fetch the data
      videoList.clear();
      pageno = 1.obs;
      getData(i == 0 ? "US" : "IN", "", "");
    }
  }

  Future<void> getData(String type, String token, String pageno) async {
    try {
      isLoading(true);
      update();

      String apiUrl =
          "http://loyadham.in/api/webservice/getYoutubeChannellatest?page=${1}&youtube=${"IN"}&pageToken=${token ?? ""}";

      final response = await dio.get(apiUrl);

      final data = response.data['youtube_video'];
      log("IndiaScreen Base url first${apiUrl}");
      apitoken = response.data['pageToken'].toString();

      List<ListYoutubeVideo> newVideos = [];
      data.forEach((el) {
        ListYoutubeVideo video = ListYoutubeVideo.fromJson(el);
        newVideos.add(video);
      });

      videoList.addAll(newVideos);
      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
