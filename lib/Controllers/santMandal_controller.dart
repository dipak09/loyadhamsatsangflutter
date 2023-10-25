// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/SantMandal.dart';

class SantMandalController extends GetxController {
  Dio dio = Dio();
  TextEditingController searchController = TextEditingController();
  List<SantMandal> santMandalList = [];

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    try {
      isLoading(true);
      update();

      String apiUrl = 'https://loyadham.in/api/webservice/sant';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      santMandalList = [];
      print(data);
      data.forEach((el) {
        SantMandal santMandal = SantMandal.fromJson(el);
        santMandalList.add(santMandal);
      });

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
