// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart' as r;
import 'package:dio/dio.dart';
import 'dart:io' as platform;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:loyadhamsatsang/Models/Wallpaper.dart';

class WallpaperController extends GetxController {
  r.Dio dio = r.Dio();

  List<Wallpaper> imageList = [];

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getImages();
  }

  Future<void> getImages() async {
    try {
      isLoading(true);
      update();

      isLoading(true);
      update();
      String apiUrl = 'https://loyadham.in/api/webservice/Wallpaper';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      print(data);
      data.forEach((el) {
        Wallpaper image = Wallpaper.fromJson(el);
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
