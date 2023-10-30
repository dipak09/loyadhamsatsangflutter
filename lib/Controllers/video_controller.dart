import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Video.dart';

class VideoController extends GetxController {
  Dio dio = Dio();
  List<Video> videoList = [];

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

      String apiUrl =
          'https://loyadham.in/api/webservice/getYoutubeChannellatest';

      final response = await dio.get(apiUrl);

      final data = response.data;

      data.forEach((el) {
        Video video = Video.fromJson(el);
        videoList.add(video);
      });
      print(videoList.length);

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
