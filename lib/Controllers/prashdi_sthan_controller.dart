// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Prashadi.dart';

class PrashadiSthanController extends GetxController {
  Dio dio = Dio();
  List<Prashadi> prashadiList = [];

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    get();
  }

  // void get(int? i) {
  //   if (i == 0) {
  //     getData("place");
  //   } else {
  //     getData("item");
  //   }
  // }
  void get() {
    // Check if data has already been loaded for the selected tab
    if (prashadiList.isEmpty)  {
      // If data hasn't been loaded, fetch the data
      prashadiList.clear();
      getData("place");
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
}
