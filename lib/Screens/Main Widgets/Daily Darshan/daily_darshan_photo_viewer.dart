// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Models/DailyDarshan.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'dart:io' as platform;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Utilites/ToastNotification.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart' as r;

class DailyDarshanPhotoViewer extends StatefulWidget {
  String? title;
  List<DailyDarshan>? darshanList;

  DailyDarshanPhotoViewer({
    super.key,
    this.title,
    this.darshanList,
  });

  @override
  State<DailyDarshanPhotoViewer> createState() =>
      _DailyDarshanPhotoViewerState();
}

class _DailyDarshanPhotoViewerState extends State<DailyDarshanPhotoViewer> {
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  int currentIndex = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  void shareImage(String imageUrl) async {
    setState(() {
      isLoading = true; // Set loading state to true
    });
    try {
      var response = await HttpClient().getUrl(Uri.parse(imageUrl));
      var httpClient = await response.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(httpClient);

      // Save image to device's temporary directory
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/tempImage.png').create();
      await file.writeAsBytes(bytes);

      // Share the saved image via WhatsApp
      Share.shareFiles([file.path]);
      setState(() {
        isLoading = false; // Set loading state to false after sharing
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading state to false after sharing
      });
      print('Error sharing image: $e');
    }
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: widget.title),
      body: widget.darshanList!.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      PhotoViewGallery.builder(
                          pageController: pageController,
                          itemCount: widget.darshanList!.length,
                          backgroundDecoration:
                              BoxDecoration(color: Colors.black),
                          onPageChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });

                            scrollController.animateTo(
                              index *
                                  130, // Assuming each item has a height of 100
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            // log("pageIndex${index  * (MediaQuery.of(context).size.width * 0.3)}");
                            // log("pageIndexsecound${index  * 100}");
                          },
                          builder: (context, index) {
                            return PhotoViewGalleryPageOptions(
                                imageProvider: NetworkImage(
                                    widget.darshanList![index].source),
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered * 2);
                          }),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  downloadImage(
                                      widget.darshanList![currentIndex].source);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // print(
                                  //     widget.darshanList![currentIndex].source);
                                  shareImage(
                                      widget.darshanList![currentIndex].source);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isLoading) Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
                Container(
                    height: 100, // Adjust the height as needed
                    child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.darshanList!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    pageController.animateToPage(index,
                                        duration: Duration(milliseconds: 300),
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
                                          width: 130 - 20,
                                          imageUrl: widget
                                              .darshanList![index].source))));
                        }))
              ],
            ),
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
      //             if (currentIndex < widget.darshanList!.length - 1) {
      //               pageController.animateToPage(currentIndex + 1,
      //                   duration: Duration(milliseconds: 300),
      //                   curve: Curves.ease);
      //             }
      //           },
      //           child: Icon(Icons.arrow_forward)),
      //     ],
      //   ),
      // ),
    );
  }
}
