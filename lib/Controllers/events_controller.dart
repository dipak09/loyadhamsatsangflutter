// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Events.dart';

class EventsController extends GetxController {
  Dio dio = Dio();
  List<Events> eventList = [];
  List<Events> imageList = [];
  RxString selectedTitle = 'Loyadham Canada'.obs;
  RxString selectedYear = '2023'.obs;
  List<String> years = List.generate(3, (index) => (2024 - index).toString());
  RxBool isLoading = false.obs;
  final List<String> items = [
    'Loyadham Canada',
    'Loyadham Vadodara',
    'Loyadham FL',
    'Loyadham Macon',
    'Loyadham NJ',
    'Loyadham Kandari',
    'Loyadham India',
    'Loyadham Surat',
  ];

  void selectItem(String item) {
    selectedTitle.value = item;
    getValue();
  }

  void selectYear(String item) {
    selectedYear.value = item;
    getValue();
  }

  @override
  void onInit() {
    super.onInit();
    getValue();
  }

  getValue() {
    getData(title: selectedTitle.toString(), year: selectedYear.toString());
  }

  Future<void> getData({String? title, String? year}) async {
    try {
      isLoading(true);
      update();
      eventList = [];
      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/event?event_title=${title}&year_title=${year}';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      print(data.toString());
      data.forEach((el) {
        Events events = Events.fromJson(el);
        eventList.add(events);
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

  Future<void> getImages({String? albumTitle}) async {
    try {
      isLoading(true);
      update();

      eventList = [];
      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/eventalbum?album_title=${albumTitle}';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;

      data.forEach((el) {
        Events image = Events.fromJson(el);
        imageList.add(image);
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
