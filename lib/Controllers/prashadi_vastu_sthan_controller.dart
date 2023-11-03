// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Prashadi.dart';

class PrashadiVastuSthanController extends GetxController {
  Dio dio = Dio();
  List<Prashadi> prashadiList = [];

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getData();
  }

  void get(int? i) {
    if (i == 0) {
      getData("place");
    } else {
      getData("item");
    }
  }

  Future<void> getData(String type) async {
    try {
      isLoading(true);
      update();
      prashadiList = [];
      String apiUrl =
          'https://loyadham.in/api/webservice/loyadham?type=${type}';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      data.forEach((el) {
        Prashadi prashad = Prashadi.fromJson(el);
        prashadiList.add(prashad);
      });
      print(prashadiList.length);

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }

  Future<void> getSthan() async {
    try {
      isLoading(true);
      update();
      prashadiList = [];
      String apiUrl = 'https://loyadham.in/api/webservice/loyadham?type=item';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      data.forEach((el) {
        Prashadi prashad = Prashadi.fromJson(el);
        prashadiList.add(prashad);
      });
      print(prashadiList.length);

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
