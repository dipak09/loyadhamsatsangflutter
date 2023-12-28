import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as formdata;
import 'package:dio/dio.dart%20' as data;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationController extends GetxController {
  formdata.Dio dio = formdata.Dio();
  RxBool isLoading = false.obs;
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final zipcontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final countrycontroller = TextEditingController();
  Future<void> getDonation({String? amount, String ? tnx_id,String ?paymentstatus, String? payment_gross, String ? paymentdate }) async {
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
          data: formdata.FormData.fromMap({
            'name': 'Jash',
            'email_id': emailcontroller.value.text,
            'country_code': "+91",
            'mobile_number': phonecontroller.value.text.toString(),
            'street_1': addresscontroller.value.text,
            'city': citycontroller.value.text,
            'state': statecontroller.value.text,
            'zip': zipcontroller.value.text.toString(),
            'country': countrycontroller.value.text,
            'txn_id': tnx_id,
            'payment_gross': payment_gross,
            'mc_currency':"",
            'payment_status': paymentstatus,
            'payment_date': paymentdate,
            'sub_type': "1 Day Mukhya Yajman",
            'amount': amount.toString(),
            'thal_date': "13-12-2023",
            'thal_description': "Demo Test for the developer",
            'dropdown_name': "test"

          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        //  booksList = [];
        log(response.toString());
      } else {
        log("Data is not sent on the database------------------->");
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
