// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  Dio dio = Dio();

  String? image;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    try {
      update();
      isLoading(true);

      String apiUrl = 'https://loyadham.in/api/Webservice/splashscreen';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;

      //print(data['image']);
      image = data['image'];

      update();
      isLoading(false);
    } catch (error) {
      update();
      isLoading(false);
      // Handle any errors
      print('Error: $error');
    }
  }
}
