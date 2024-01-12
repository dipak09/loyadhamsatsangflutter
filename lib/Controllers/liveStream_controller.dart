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
      final response = await dio.get(apiUrl);
      final data = response.data;
       final liveData = data['channel1'];
        liveData.forEach((el) {
        Channel1 slider = Channel1.fromJson(el);
        livestreamchannel.add(slider);
      });
 isLoading(false);
      update();
    } catch (e) {
      print("Error : ${e}");
    }
  }
}
