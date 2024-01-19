// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:dio/dio.dart' as r;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:loyadhamsatsang/Models/Events.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io' as platform;

class EventsImagesController extends GetxController {
  Dio dio = Dio();

  List<Events> imageList = [];

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getImages(String albumTitle) async {
    try {
      isLoading(true);
      update();

      isLoading(true);
      update();
      String apiUrl =
          'https://loyadham.in/api/webservice/eventalbum?album_title=${albumTitle}';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      log(apiUrl);
      log(data.toString());
      data.forEach((el) {
        Events image = Events.fromJson(el);
        imageList.add(image);
      });

      print(imageList.length);

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      // Handle any errors
      print('Error: $error');
    }
  }

  void permission() async {
    print("object");
    var status = platform.Platform.isAndroid
        ? await Permission.storage.status
        : await Permission.manageExternalStorage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    }
  }

  Future<void> downloadAndSaveImage(String imageUrl) async {
    try {
      permission();
      // Send an HTTP GET request to the API to fetch the image.
      final r.Response<List<int>> response = await dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        // Get the response data as bytes.
        final List<int>? imageData = response.data;

        // Save the image to the device's gallery.
        final result =
            await ImageGallerySaver.saveImage(Uint8List.fromList(imageData!));

        if (result != null) {
          print('Image saved to gallery: $result');
        } else {
          print('Failed to save the image to the gallery.');
        }
      } else {
        // Handle the case when the image download fails.
        print('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
