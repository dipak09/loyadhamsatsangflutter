// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/AboutUS.dart';

class AboutUSController extends GetxController {
  Dio dio = Dio();
  List<AboutUs> list = [];

  RxString selectedTitle = 'Lord Swaminarayan'.obs;

  RxBool isLoading = false.obs;
  final List<String> items = [
    'Lord Swaminarayan',
    'Sadguru Muktanand Swami',
    'Sadguru Adharanand Swami',
    'Sadguru Haripriyadasji Swami',
    'Sadguru Vaikunthcharandasji Swami',
    'Sadguru Narayanswarupdasji Swami',
    'Sadguru Nandkishordasji Swami',
    'Pujya Guruji',
  ];

  void selectItem(String item) {
    selectedTitle.value = item;
    getValue();
  }

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
      String apiUrl = 'https://loyadham.in/api/webservice/about?name=${title}';

      final response = await dio.get(apiUrl);

      final data = response.data;

      data.forEach((el) {
        AboutUs aboutUs = AboutUs.fromJson(el);
        list.add(aboutUs);
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
