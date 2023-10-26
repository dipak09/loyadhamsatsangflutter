import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loyadhamsatsang/Models/KirtanKathAudio.dart';

class KirtanKathaAudioController extends GetxController {
  Dio dio = Dio();
  final AudioPlayer audioPlayer = AudioPlayer();
  List<KirtanKathaAudio> kirtankathaAudioList = [];

  RxBool isLoading = false.obs;
  Future<void> playAudio(String audioUrl) async {
    await audioPlayer.setUrl(audioUrl);
    audioPlayer.play();
  }

  Future<void> getAudio(String type, String event_id, String singer_id) async {
    try {
      isLoading(true);
      update();

      String apiUrl =
          'https://loyadham.in/api/webservice/kirtanaudio?type=${type}&event_id=${event_id}&singer_id=${singer_id}';

      final response = await dio.get(apiUrl);
      kirtankathaAudioList = [];
      final data = response.data;

      data.forEach((el) {
        KirtanKathaAudio kirtankathaAudio = KirtanKathaAudio.fromJson(el);
        kirtankathaAudioList.add(kirtankathaAudio);
      });
      print(kirtankathaAudioList.length);

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
