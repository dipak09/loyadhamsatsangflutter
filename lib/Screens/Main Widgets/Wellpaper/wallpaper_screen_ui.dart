// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/wallpaper_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Utilites/ToastNotification.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class WallpaperScreenUI extends StatefulWidget {
  const WallpaperScreenUI({super.key});

  @override
  State<WallpaperScreenUI> createState() => _WallpaperScreenUIState();
}

class _WallpaperScreenUIState extends State<WallpaperScreenUI> {
  var Wallpaper = Get.put(WallpaperController());
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: Wallpaper.isLoading.value,
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: CustomAppBar(
              title: "Wallpapers",
              fontsize: 12.0,
            ),
            body: Column(children: [
              Expanded(
                  child: Stack(children: [
                PhotoViewGallery.builder(
                    pageController: pageController,
                    itemCount: Wallpaper.imageList.length,
                    backgroundDecoration: BoxDecoration(color: Colors.black),
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(
                              Wallpaper.imageList[index].image.toString()),
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
                                  // downloadImage(Events
                                  //     .imageList[currentIndex].source!);
                                },
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // shareImage(Events
                                    //     .imageList[currentIndex].source!);
                                  })
                            ])))
              ])),
              Container(
                  height: 100, // Adjust the height as needed
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Wallpaper.imageList.length,
                      itemBuilder: (context, index) {
                        var data = Wallpaper.imageList[index];
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
                                        width: 100,
                                        imageUrl: data.image.toString()))));
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

    // Scaffold(
    //     appBar: CustomAppBar(
    //       title: "Wallpapers",
    //     ),
    //     body: GridView.builder(
    //         shrinkWrap: true,
    //         padding: const EdgeInsets.all(4.0),
    //         scrollDirection: Axis.vertical,
    //         itemCount: Wallpaper.imageList.length,
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2, childAspectRatio: 0.7),
    //         itemBuilder: (BuildContext context, int index) {
    //           var data = Wallpaper.imageList[index];
    //           return GestureDetector(
    //               onTap: () {
    //                 Get.dialog(Padding(
    //                   padding: const EdgeInsets.only(top: 10),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Container(
    //                         width: screenWidth(context) * 0.9,
    //                         height: screenHeight(context) * 0.7,
    //                         margin: EdgeInsets.all(10),
    //                         decoration: BoxDecoration(
    //                             color: Colors.grey.withOpacity(0.2),
    //                             image: DecorationImage(
    //                                 image: NetworkImage(data.image!),
    //                                 fit: BoxFit.fill),
    //                             border: Border.all(),
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(15))),
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Align(
    //                               alignment: Alignment.topRight,
    //                               child: GestureDetector(
    //                                 onTap: () {
    //                                   print("object");
    //                                   Get.back();
    //                                   ToastNotifications.showSuccess(
    //                                       msg: "Image saved to gallery");

    //                                   Wallpaper.downloadAndSaveImage(
    //                                       data.image!);
    //                                 },
    //                                 child: Icon(Icons.download,
    //                                     color: Colors.white, size: 40),
    //                               )),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ));
    //               },
    //               child: Container(
    //                 width: screenWidth(context) * 0.32,
    //                 height: screenHeight(context) * 0.2,
    //                 margin: EdgeInsets.all(10),
    //                 child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(10),
    //                     child:
    //                         CachedImageWithShimmer(imageUrl: data.image!)),
    //               ));
    //         }))));
  }
}
