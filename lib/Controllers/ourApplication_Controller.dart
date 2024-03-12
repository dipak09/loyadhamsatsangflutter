// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/AboutUS.dart';
import 'package:loyadhamsatsang/Models/ourApplicationModel.dart';

class OurApplicationController extends GetxController {
  Dio dio = Dio();
  List<OurApplicationModel> list = [];

  RxString selectedTitle = 'Lord Swaminarayan'.obs;

  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    getValue();
  }

  getValue() {
    getData(title: selectedTitle.toString());
  }

  Future<void> getData({String? title}) async {
    try {
      isLoading(true);
      update();
      list = [];
      isLoading(true);
      update();
      String apiUrl = 'https://loyadham.in/api/webservice/getOurApplication';

      final response = await dio.get(apiUrl);

      final data = response.data["our_application"];

      data.forEach((el) {
        OurApplicationModel ourapplication = OurApplicationModel.fromJson(el);
        list.add(ourapplication);
      });

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
