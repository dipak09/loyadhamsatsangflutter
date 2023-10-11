// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/ImagesData.dart';

class DashboardController extends GetxController {
  Dio dio = Dio();
  List<Dashboardata> publicationList = [];
  List<Dashboardata> sliderList = [];
  List<Dashboardata> branchesList = [];
  List<Dashboardata> livestreamingList = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getDashboardData();
  }

  Future<void> getDashboardData() async {
    try {
      isLoading(true);
      update();

      String apiUrl = 'https://loyadham.in/api/webservice/home';

      final response = await dio.get(
        apiUrl,
      );
      final data = response.data;

      final publicationsData = data['publication'];
      publicationsData.forEach((el) {
        Dashboardata publications = Dashboardata.fromJson(el);
        publicationList.add(publications);
      });
      final sliderData = data['slider'];
      sliderData.forEach((el) {
        Dashboardata slider = Dashboardata.fromJson(el);
        sliderList.add(slider);
      });

      final branchesData = data['branches'];

      branchesData.forEach((el) {
        Dashboardata branches = Dashboardata.fromJson(el);
        branchesList.add(branches);
      });
      final livestreamingData = data['livestreaming'];

      livestreamingData.forEach((el) {
        Dashboardata livestreaming = Dashboardata.fromJson(el);
        livestreamingList.add(livestreaming);
      });

      isLoading(false);
      update();
    } catch (e) {
      print("Error : ${e}");
    }
  }
}
