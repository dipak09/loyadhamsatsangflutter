// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:io' as platform;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:loyadhamsatsang/Controllers/events_Images_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Utilites/ToastNotification.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart' as r;

class EventsPhotosScreenUI extends StatefulWidget {
  String? title, name, date;
  EventsPhotosScreenUI({super.key, this.title, this.name, this.date});

  @override
  State<EventsPhotosScreenUI> createState() => _EventsPhotosScreenUIState();
}

class _EventsPhotosScreenUIState extends State<EventsPhotosScreenUI> {
  var Events = Get.put(EventsImagesController());
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    Events.getImages(widget.title!);
  }

  void shareImage(String imageUrl) {
    Share.share(imageUrl);
  }

  Future<void> downloadImage(String imageUrl) async {
    Dio dio = Dio();
    try {
      var status = platform.Platform.isAndroid
          ? await Permission.storage.status
          : await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
        await Permission.manageExternalStorage.request();
      }

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
          ToastNotifications.showSuccess(msg: "Image saved to gallery");
          print('Image saved to gallery: $result');
        } else {
          ToastNotifications.showError(
              msg: "Failed to save the image to the gallery");
          print('Failed to save the image to the gallery.');
        }
      } else {
        ToastNotifications.showError(msg: "Failed to download image");
        // Handle the case when the image download fails.
        print('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: Events.isLoading.value,
        color: Colors.white,
        opacity: 0.9,
        // progressIndicator: Center(child: CircularProgressIndicator()),
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: CustomAppBar(title: widget.name),
            body: Events.imageList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Column(children: [
                    Expanded(
                        child: Stack(children: [
                      PhotoViewGallery.builder(
                          pageController: pageController,
                          itemCount: Events.imageList.length,
                          backgroundDecoration:
                              BoxDecoration(color: Colors.black),
                          onPageChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          builder: (context, index) {
                            return PhotoViewGalleryPageOptions(
                                imageProvider: NetworkImage(
                                    Events.imageList[index].source!),
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered * 2);
                          }),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.download,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        downloadImage(Events
                                            .imageList[currentIndex].source!);
                                      },
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          shareImage(Events
                                              .imageList[currentIndex].source!);
                                        })
                                  ])))
                    ])),
                    Container(
                        height: 100, // Adjust the height as needed
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Events.imageList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        pageController.animateToPage(index,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.ease);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: index == currentIndex
                                                  ? Colors.blue
                                                  : Colors.transparent,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: CachedImageWithShimmer(
                                              width: 100,
                                              imageUrl: Events
                                                  .imageList[index].source!))));
                            }))
                  ])
            // bottomNavigationBar: BottomAppBar(
            //   color: Colors.black,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       ElevatedButton(
            //           onPressed: () {
            //             if (currentIndex > 0) {
            //               pageController.animateToPage(currentIndex - 1,
            //                   duration: Duration(milliseconds: 300),
            //                   curve: Curves.ease);
            //             }
            //           },
            //           child: Icon(Icons.arrow_back)),
            //       ElevatedButton(
            //           onPressed: () {
            //             if (currentIndex < Events.imageList.length - 1) {
            //               pageController.animateToPage(currentIndex + 1,
            //                   duration: Duration(milliseconds: 300),
            //                   curve: Curves.ease);
            //             }
            //           },
            //           child: Icon(Icons.arrow_forward)),
            //     ],
            //   ),
            // ),
            )));
  }
}