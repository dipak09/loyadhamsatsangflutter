// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  Dio dio = Dio();

  String? description;
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

      String apiUrl = 'https://loyadham.in/api/webservice/privacy';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;

      print(data['description']);
      description = data['description'];

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
