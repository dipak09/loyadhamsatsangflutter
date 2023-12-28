import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Video.dart';

class VideoController extends GetxController {
  Dio dio = Dio();
  List<Video> videoList = [];
  var home_page = 1.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    get(0);
  }

  void get(int? i) {
    if (i == 0) {
      getData("US", "");
    } else {
      getData("IN", "");
    }
  }

  Future<void> getData(String type, String token) async {
    try {
      isLoading(true);
      update();
      videoList.clear();
      String apiUrl =
          'http://loyadham.in/api/webservice/getYoutubeChannellatest?youtube=${type.isEmpty ? "IN" : type}';
      //   http://loyadham.in/api/webservice/getYoutubeChannellatest?page=2&youtube=US&pageToken=CBQQAA
      // String apiUrl =
      //     'https://loyadham.in/api/webservice/getYoutubeChannellatest?youtube=';

      final response = await dio.get(apiUrl);

      final data = response.data;

      data.forEach((el) {
        Video video = Video.fromJson(el);
        videoList.add(video);
      });

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
