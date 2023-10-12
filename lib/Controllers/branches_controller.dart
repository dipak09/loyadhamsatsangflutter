// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Branches.dart';

class BranchesController extends GetxController {
  Dio dio = Dio();
  List<Branches> branchesList = [];

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

      String apiUrl = 'https://loyadham.in/api/webservice/branche';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      data.forEach((el) {
        Branches branches = Branches.fromJson(el);
        branchesList.add(branches);
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
