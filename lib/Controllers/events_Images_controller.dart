// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Events.dart';

class EventsImagesController extends GetxController {
  Dio dio = Dio();

  List<Events> imageList = [];

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getImages(String albumTitle) async {
    try {
      isLoading(true);
      update();

      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/eventalbum?album_title=${albumTitle}';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      print(data);
      data.forEach((el) {
        Events image = Events.fromJson(el);
        imageList.add(image);
      });

      print(imageList.length);

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      // Handle any errors
      print('Error: $error');
    }
  }
}
