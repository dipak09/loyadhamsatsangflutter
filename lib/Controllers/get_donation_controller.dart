import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/donation_model.dart';

class GetDonationControlloer extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;
  List<dynamic> getDonationList = [].obs;
  List<DonationModel> donationList =[];


  Future<void> getDonationData() async {
    try {
      isLoading(true);
      update();
      donationList = [];
      String apiUrl = "https://loyadham.in/api/webservice/donationForm";

      final response = await dio.get(apiUrl);

      final data = response.data["donation"];

      getDonationList.addAll(data);
      data.forEach((el) {
        DonationModel donation = DonationModel.fromJson(el);
        donationList.add(donation);
      });
      log("donationList${donationList.length}");
      log("donationList${donationList[0].id}");
      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
