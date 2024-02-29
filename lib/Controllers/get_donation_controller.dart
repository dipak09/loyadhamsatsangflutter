import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/get_donationModel.dart';

class GetDonationControlloer extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;
  List<dynamic> getDonationList = [].obs;

  Future<void> getData() async {
    try {
      isLoading(true);
      update();

      String apiUrl = "https://loyadham.in/api/webservice/donationForm";

      final response = await dio.get(apiUrl);

      final data = response.data["donation"];
      log(data.toString());
      getDonationList.addAll(data);
      // data.forEach((el) {
      //   Donation subDonation = Donation.fromJson(el);

      //   log(el.toString());
      //   // log(el.toString());
      // });

      //  print(kirtankathaList.length);

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
