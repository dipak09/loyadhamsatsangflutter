import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/search.dart';

class SearchControllerList extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;
  List<Book>? book = [];
  List<YoutubeUs>? youtubeUs = [];
  List<YoutubeIn>? youtubeIn = [];
  List<KathaAudio>? kathaAudio = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> getSearchData(String stringtext) async {
    try {
      isLoading(true);
      book!.clear();
      youtubeUs!.clear();
      youtubeIn!.clear();
      kathaAudio!.clear();
      update();
      String apiurl =
          "https://loyadham.in/api/webservice/search?query=${stringtext}";
      final response = await dio.get(apiurl);
      final data = response.data;

//* Books ForEach Loop------------->
      final bookData = data['book'];
      if (bookData == null) {
        book = [];
      } else {
        bookData.forEach((el) {
          Book booksData = Book.fromJson(el);
          book!.add(booksData);
        });
      }
      //* YouTubeUS ForEach Loop--------------------->
      final youTubeUSList = data['youtube_us'];
      if (youTubeUSList == null) {
        youtubeUs = [];
      } else {
        youTubeUSList.forEach((el) {
          YoutubeUs youtubeus = YoutubeUs.fromJson(el);
          youtubeUs!.add(youtubeus);
        });
      }
//* YouTubeIN ForEachLoop-------------->
      final youTubeINList = data['youtube_in'];
      if (youTubeINList == null) {
        youtubeIn = [];
      } else {
        youTubeINList.forEach((el) {
          YoutubeIn youtubein = YoutubeIn.fromJson(el);
          youtubeIn!.add(youtubein);
        });
      }
      //* KathaAudio ForEach Loop------------>
      final kathaAudioList = data['katha_audio'];
      kathaAudioList.forEach((el) {
        KathaAudio kathaAudioData = KathaAudio.fromJson(el);
        kathaAudio!.add(kathaAudioData);
      });
      isLoading(false);
      update();
    } catch (e) {
      print("Error : ${e}");
    }
  }
}
