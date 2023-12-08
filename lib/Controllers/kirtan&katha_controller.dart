import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/KirtanKatha.dart';

class KirtanKathaController extends GetxController {
  Dio dio = Dio();
  List<KirtanKatha> kirtankathaList = [];

  RxBool isLoading = false.obs;
  void get(int? i) {
    if (i == 0) {
      getData("kirtan","All");
    } else {
      getData("katha","All");
    }
  }

  Future<void> getData(String type,String singer_name) async {
    try {
      isLoading(true);
      update();

      String apiUrl = "https://loyadham.in/api/webservice/kirtan?singer_name=${singer_name}&type=${type}";

      final response = await dio.get(apiUrl);

      final data = response.data;
      kirtankathaList = [];
      data.forEach((el) {
        KirtanKatha kirtanKatha = KirtanKatha.fromJson(el);
        kirtankathaList.add(kirtanKatha);
      });
      print(kirtankathaList.length);

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }

}
