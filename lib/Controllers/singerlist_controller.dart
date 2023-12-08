import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:loyadhamsatsang/Models/Singer_list.dart';

class SingerListController extends GetxController {
  Dio dio = Dio();
  List<SingerList> singerList = [];
  RxBool isLoading = false.obs;
  Future<void> getData() async {
    try {
      isLoading(true);
      update();

      String apiUrl = 'https://loyadham.in/api/webservice/singerList';

      final response = await dio.get(apiUrl);

      final data = response.data;
      singerList = [];
      data.forEach((el) {
        SingerList singerlistdata = SingerList.fromJson(el);
        singerList.add(singerlistdata);
      });
      print(response.data);

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
