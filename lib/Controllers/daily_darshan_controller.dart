// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Models/DailyDarshan.dart';

class DailyDarshanController extends GetxController {
  Dio dio = Dio();
  List<DailyDarshan> dailyDarshanList = [];
  RxString selectedTitle = 'Thakorji Maharaj'.obs;
  final List<String> items = [
    'Thakorji Maharaj',
    'Loyadham NJ',
    'Loyadham Kandari',
    'Loyadham India',
    'Loyadham Surat',
    'Loyadham Canada',
  ];
  RxBool isLoading = false.obs;
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  @override
  void onInit() {
    super.onInit();
    getValue();
  }

  getValue() {
    final formattedDate = DateFormat('dd-MMMM-yyyy').format(selectedDate.value);
    getData(title: selectedTitle.toString(), date: formattedDate.toString());
  }

  void selectItem(String item) {
    selectedTitle.value = item;
  }

  var currentIndex = 0.obs;

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    print(index);
    update();
    currentIndex.value = index;
  }

  void goToPrevious() {
    update();
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }

  void goToNext(int itemCount) {
    print("here");
    update();
    if (currentIndex.value < itemCount - 1) {
      currentIndex.value++;
    }
  }

  final List<String> imageList = [
    AppImages.slider1,
    AppImages.slider3,
    AppImages.slider2,
    // Add your image paths here
  ];

  Future<void> pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      getValue();
    }
  }

  Future<void> getData({String? title, String? date}) async {
    try {
      isLoading(true);
      update();
      print(date);
      print(title);
      dailyDarshanList = [];
      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/dailydarshan/?title=${title}&album_title=${date}';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      print(data);
      data.forEach((el) {
        DailyDarshan dailyDarshan = DailyDarshan.fromJson(el);
        dailyDarshanList.add(dailyDarshan);
      });

      print(dailyDarshanList.length);

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
