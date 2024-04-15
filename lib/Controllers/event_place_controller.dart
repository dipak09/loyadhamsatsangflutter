// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/event_place_model.dart';

class EventsPlaceController extends GetxController {
  Dio dio = Dio();
  List<EventPlaceModel> eventPlaceList = [];


  RxBool isLoading = false.obs;
   List<String> eventPlaceItems = [];

  RxString selectedPlace = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }


  Future<void> getData() async {
    try {
      isLoading(true);
      update();
      eventPlaceList = [];
      eventPlaceItems = [];
      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/getEventPlaces';

      final response = await dio.get(
        apiUrl,
      );
      log("photosUrl${apiUrl}");
      final data = response.data;
      print(data.toString());
      data.forEach((el) {
        EventPlaceModel events = EventPlaceModel.fromJson(el);
        eventPlaceList.add(events);
      });
      log("eventPlaceList${eventPlaceList.length}");
      
      for(int i = 0 ; i<eventPlaceList.length ; i++){
        eventPlaceItems.add(eventPlaceList[i].eventTitle.toString());
      }
      selectedPlace.value = eventPlaceItems.first;
      log("selectedPlace${eventPlaceItems.first}");
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
