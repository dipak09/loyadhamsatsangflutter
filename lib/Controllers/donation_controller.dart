import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as formdata;
import 'package:dio/dio.dart%20' as data;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar_ui.dart';

class DonationController extends GetxController {
  formdata.Dio dio = formdata.Dio();
  RxBool isLoading = false.obs;
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final street_address1controller = TextEditingController();
  final street_address2controller = TextEditingController();
  final citycontroller = TextEditingController();
  final zipcontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final countrycontroller = TextEditingController();

  Future<void> getDonation(
      {required String donationData,
      required String totalAmount,
      required String txn_id,
      required String countryCode,
      required String payment_date,
      required String payment_status}) async {
    try {
      isLoading(true);
      update();
      // print(selectedLang);
      // print(search);
      const apiUrl = 'https://loyadham.in/api/webservice/donationSubmit';

      final response = await dio.post(apiUrl,
          options: formdata.Options(
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
          ),
          data: {
            "name": namecontroller.value.text.toString().trim(),
            "email": emailcontroller.value.text.toString().trim(),
            "country_code": "+$countryCode",
            "phone_number": phonecontroller.text.toString().trim(),
            "street_address1": street_address1controller.text.toString().trim(),
            "street_address2": street_address2controller.text.toString().trim(),
            "city": citycontroller.text.toString().trim(),
            "state": statecontroller.text.toString().trim(),
            "zip": zipcontroller.text.toString().trim(),
            "country": countrycontroller.text.toString().trim(),
            "total_amount": totalAmount,
            "txn_id": txn_id,
            "payment_status": payment_status,
            "payment_date": payment_date,
            "donation_data": donationData,
          }
          // data: formdata.FormData.fromMap({
          //   'name': 'Jash',
          //   'email_id': emailcontroller.value.text,
          //   'country_code': "+91",
          //   'mobile_number': phonecontroller.value.text.toString(),
          //   'street_1': addresscontroller.value.text,
          //   'city': citycontroller.value.text,
          //   'state': statecontroller.value.text,
          //   'zip': zipcontroller.value.text.toString(),
          //   'country': countrycontroller.value.text,
          //   'txn_id': tnx_id,
          //   'payment_gross': payment_gross,
          //   'mc_currency':"",
          //   'payment_status': paymentstatus,
          //   'payment_date': paymentdate,
          //   'sub_type': "1 Day Mukhya Yajman",
          //   'amount': amount.toString(),
          //   'thal_date': "13-12-2023",
          //   'thal_description': "Demo Test for the developer",
          //   'dropdown_name': "test"
          //
          // })
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        //  booksList = [];
        log("Data is successfully ------------------->${response.data}");
        Get.off(() => BottomNavigation(index: 2));
        isLoading(false);
        update();
      } else {
        log("Data is not sent on the database------------------->");
        isLoading(false);
        update();
      }

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
