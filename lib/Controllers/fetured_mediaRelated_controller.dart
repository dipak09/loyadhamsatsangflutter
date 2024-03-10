import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Video.dart';

class FeatureMediaRelatedController extends GetxController {
  Dio dio = Dio();
  List<Video> videoList = [];

  RxBool isLoading = false.obs;

  var timeAgo = "".obs;
  var title = "".obs;
  var view = "".obs;
  var publishedDate = "".obs;
  var url = "".obs;
  var videoId = "".obs;

  assignData(
      {String? agoTime,
      String? videoTitle,
      String? videoView,
      String? videopublishedDate,
      String? videourl,
      String? videovideoId}) {
    timeAgo.value = agoTime!;
    title.value = videoTitle!;
    view.value = videoView!;
    publishedDate.value = videopublishedDate!;
    url.value = videourl!;
    videoId.value = videovideoId!;
    print("here");
  }

  Future<void> getData(String id) async {
    try {
      isLoading(true);
      update();

      String apiUrl =
          'https://loyadham.in/api/webservice/getFeatureMediaRelatedVideos_get?videoId==${id}';

      final response = await dio.get(apiUrl);

      final data = response.data;
      print("Throwing----------->" + response.data.toString());
      videoList = [];

      data.forEach((el) {
        Video video = Video.fromJson(el);
        videoList.add(video);
      });
      print("Related Video : ${videoList}");

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
