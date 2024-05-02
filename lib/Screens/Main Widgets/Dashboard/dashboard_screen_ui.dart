// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, body_might_complete_normally_nullable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/dashboard_controller.dart';
import 'package:loyadhamsatsang/Controllers/featuremedia_Controller.dart';
import 'package:loyadhamsatsang/Controllers/liveStream_controller.dart';
import 'package:loyadhamsatsang/Controllers/video_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Daily%20Darshan/daily_darshan_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/Dashboard_Image_slider.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/dashboard_appbar.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Featured%20Media/featuredVideoID.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/video_screen.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/today%20bhajan/today_bhajan.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreenUI extends StatefulWidget {
  final GlobalKey<ScaffoldState>? drawer;

  const DashboardScreenUI({super.key, this.drawer});

  @override
  State<DashboardScreenUI> createState() => _DashboardScreenUIState();
}

class _DashboardScreenUIState extends State<DashboardScreenUI> {
  var Home = Get.put(DashboardController());
  var Video = Get.put(VideoController());

  //var LiveStream = Get.put(LiveStreamController());
  //var FeatureMedia = Get.put(FeaturedmediaController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FeatureMedia.getData();
    //  LiveStream.getDashboardData();
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        key: _drawerKey,
        backgroundColor: Colors.white54,
        appBar: DashboardAppBar(drawer: widget.drawer),
        body: SingleChildScrollView(
            child: Column(children: [
          Home.isLoading.value == true
              ? _loaderSlider()
              : DashBoardImageSlider(),
          liveStreamSection(),
          dailyDarshanSection(),
          featuredMediaSection(),
          todayBhajaneventSection(),
          //SizedBox(height: 10),
          upcomingeventSection()
        ]))));
  }

  Widget liveStreamSection() {
    return Home.livestreamingList.length == 0 && Home.livestreamingList.isEmpty
        ? SizedBox.shrink()
        : Column(children: [
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("Live Stream",
                          color: AppColors.apptheme,
                          fontWeight: FontWeight.bold)
                    ])),
            Obx(() => Home.isLoading.value == true
                ? _loader()
                : Container(
                    //height: screenHeight(context) * 0.22,
                    height: 180,
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: Home.livestreamingList.length == 1
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: Home.livestreamingList.map((item) {
                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => VideoScreen(
                                  url: item.youtubeLink,
                                  videoId: item.initialId,
                                  title: item.title,
                                  publishedDate: "",
                                  timeAgo: "",
                                  view: "",
                                  type: "",
                                ),
                              );
                            },
                            child: Container(
                              width: screenWidth(context, dividedBy: 1.2),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(item.thumbnail.toString()),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedImageWithShimmer(
                                  imageUrl: item.thumbnail.toString(),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // child: ListView.builder(
                    //     itemCount: Home.livestreamingList.length,
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (contex, index) {
                    //       log("livestreamingList${Home.livestreamingList[0].title}");
                    //       log("livestreamingList${Home.livestreamingList[0].initialId}");
                    //       log("livestreamingList${Home.livestreamingList[0].thumbnail}");
                    //       log("Home.livestreamingList${Home.livestreamingList[0]
                    //           .youtubeLink}");
                    //       return InkWell(
                    //           onTap: () {
                    //             Get.to(() =>
                    //                 VideoScreen(
                    //                   url: Home.livestreamingList[index].youtubeLink,
                    //                   videoId: Home.livestreamingList[index].initialId,
                    //                   title: Home.livestreamingList[index].title,
                    //                   publishedDate: "",
                    //                   timeAgo: "",
                    //                   view: "",
                    //                   type: "",
                    //                 ),);
                    //           },
                    //           child: Container(
                    //               height: 150,
                    //               width: 300,
                    //               margin: EdgeInsets.symmetric(
                    //                   horizontal: 10, vertical: 10),
                    //               decoration: BoxDecoration(
                    //                   color: Colors.grey,
                    //                   border: Border.all(
                    //                       color: Colors.white, width: 3),
                    //                   borderRadius: BorderRadius.circular(15),
                    //                   image: DecorationImage(
                    //                       image: NetworkImage(
                    //                           Home.livestreamingList[index]
                    //                               .thumbnail
                    //                               .toString()),
                    //                       fit: BoxFit.fill)),
                    //               child: ClipRRect(
                    //                   borderRadius: BorderRadius.circular(20),
                    //                   child: CachedImageWithShimmer(
                    //                       imageUrl: Home.livestreamingList[index]
                    //                           .thumbnail
                    //                           .toString()))));
                    //     })
                  ))
          ]);
  }

  Widget dailyDarshanSection() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomText("Daily Darshan",
                color: AppColors.apptheme, fontWeight: FontWeight.bold)
          ])),
      Obx(() => Home.isLoading.value == true
          ? _loader()
          : Container(
              color: Colors.transparent,
              //height: screenHeight(context) * 0.22,
              height: 200,
              child: ListView.builder(
                  itemCount: Home.dailyDarshanList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contex, index) {
                    return InkWell(
                        onTap: () {
                          // print(Home.dailyDarshanList[index].title);
                          print(Home.dailyDarshanList[index].createdAt
                              .toString());

                          // Get.back();
                          Get.to(() => DailyDarshanScreenUI(
                              title: Home.dailyDarshanList[index].title,
                              date: Home.dailyDarshanList[index].albumTitle));
                          setState(() {
                            isBottomSheet = false;
                          });
                          //  Get.to(() => BottomNavigation(
                          //   index: 3,
                          // ));
                        },
                        child: Container(
                            height: 125,
                            width: 250,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedImageWithShimmer(
                                    fit: BoxFit.fitHeight,
                                    imageUrl:
                                        Home.dailyDarshanList[index].source))));
                  })))
    ]);
  }

  Widget featuredMediaSection() {
    log("FeatureMediaList${Home.featureMediaList.length}");
    return Home.featureMediaList.isEmpty
        ? SizedBox.shrink()
        : Column(children: [
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        "Featured Media",
                        color: AppColors.apptheme,
                        fontWeight: FontWeight.bold,
                      ),
                    ])),
            Obx(() => Home.isLoading.value == true
                ? _loader()
                : Container(
                    //height: screenHeight(context) * 0.26,
                    height: 220,
                    color: Colors.transparent,
                    child: ListView.builder(
                        itemCount: Home.featureMediaList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contex, index) {
                          return InkWell(
                              onTap: () {
                                Get.to(() => FeaturedMediaVideoID(
                                      timeAgo:
                                          Home.featureMediaList[index].timeAgo,
                                      title: Home.featureMediaList[index].title,
                                      view: Home
                                          .featureMediaList[index].viewCount,
                                      publishedDate: Home
                                          .featureMediaList[index]
                                          .publishedDate,
                                      url: Home
                                          .featureMediaList[index].youtubeLink,
                                      videoId: Home
                                          .featureMediaList[index].initialId,
                                    ));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 140,
                                        width: 250,
                                        margin: EdgeInsets.only(left: 10),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15)),
                                            child: CachedImageWithShimmer(
                                                fit: BoxFit.fitHeight,
                                                imageUrl: Home
                                                    .featureMediaList[index]
                                                    .thumbnail!))),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: 250,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                179, 221, 218, 218),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15))),
                                        child: Column(children: [
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              width: 250,
                                              child: CustomText(
                                                  Home.featureMediaList[index]
                                                      .title!,
                                                  fontSize: 9,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              width: 250,
                                              child: CustomText(
                                                  Home.featureMediaList[index]
                                                      .publishedDate!
                                                      .toString(),
                                                  fontSize: 9,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                          Container(
                                              width: 250,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                        Home
                                                            .featureMediaList[
                                                                index]
                                                            .timeAgo!,
                                                        fontSize: 9),
                                                    CustomText(
                                                        Home
                                                            .featureMediaList[
                                                                index]
                                                            .viewCount!,
                                                        fontSize: 9)
                                                  ]))
                                        ]))
                                  ]));
                        })))

            // GetBuilder<FeaturedmediaController>(builder: (controller) {
            //   return FeatureMedia.isLoading.value == true
            //       ? _loader()
            //       : SizedBox(
            //       height: screenHeight(context) * 0.27,
            //       child: ListView.builder(
            //           itemCount: Home.featureMediaList.length,
            //           scrollDirection: Axis.horizontal,
            //           itemBuilder: (contex, index) {
            //             return InkWell(
            //                 onTap: () {
            //                   Get.to(() =>
            //                       FeaturedMediaVideoID(
            //                         timeAgo: Home.featureMediaList[index].timeAgo,
            //                         title: Home.featureMediaList[index].title,
            //                         view: Home.featureMediaList[index].viewCount,
            //                         publishedDate: FeatureMedia
            //                             .list[index].publishedDate,
            //                         url: Home.featureMediaList[index].youtubeLink,
            //                         videoId:
            //                         Home.featureMediaList[index].initialId,
            //                       ));
            //                 },
            //                 child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Container(
            //                           height: 140,
            //                           width: 250,
            //                           margin:
            //                           EdgeInsets.only(top: 10, left: 10),
            //                           child: ClipRRect(
            //                               borderRadius: BorderRadius.only(
            //                                   topLeft: Radius.circular(15),
            //                                   topRight: Radius.circular(15)),
            //                               child: CachedImageWithShimmer(
            //                                   fit: BoxFit.fitHeight,
            //                                   imageUrl: FeatureMedia
            //                                       .list[index].thumbnail!))),
            //                       Container(
            //                           margin: EdgeInsets.symmetric(
            //                               horizontal: 10),
            //                           width: 250,
            //                           padding:
            //                           EdgeInsets.symmetric(vertical: 5),
            //                           decoration: BoxDecoration(
            //                               color: Color.fromARGB(
            //                                   179, 221, 218, 218),
            //                               borderRadius: BorderRadius.only(
            //                                   bottomLeft: Radius.circular(15),
            //                                   bottomRight:
            //                                   Radius.circular(15))),
            //                           child: Column(children: [
            //                             Container(
            //                                 padding: EdgeInsets.symmetric(
            //                                     horizontal: 10),
            //                                 width: 250,
            //                                 child: CustomText(
            //                                     FeatureMedia
            //                                         .list[index].title!,
            //                                     fontSize: 9,
            //                                     overflow:
            //                                     TextOverflow.ellipsis)),
            //                             Container(
            //                                 padding: EdgeInsets.symmetric(
            //                                     horizontal: 10),
            //                                 width: 250,
            //                                 child: CustomText(
            //                                     Home.featureMediaList[index]
            //                                         .publishedDate!
            //                                         .toString(),
            //                                     fontSize: 9,
            //                                     overflow:
            //                                     TextOverflow.ellipsis)),
            //                             Container(
            //                                 width: 250,
            //                                 padding: EdgeInsets.symmetric(
            //                                     horizontal: 10),
            //                                 child: Row(
            //                                     mainAxisAlignment:
            //                                     MainAxisAlignment
            //                                         .spaceBetween,
            //                                     children: [
            //                                       CustomText(
            //                                           Home.featureMediaList[index]
            //                                               .timeAgo!,
            //                                           fontSize: 9),
            //                                       CustomText(
            //                                           Home.featureMediaList[index]
            //                                               .viewCount!,
            //                                           fontSize: 9)
            //                                     ]))
            //                           ]))
            //                     ]));
            //           }));
            // },)
          ]);
  }

  Widget upcomingeventSection() {
    return Home.upcomingEventList.isEmpty
        ? SizedBox.shrink()
        : Column(children: [
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("Upcoming Events",
                          color: AppColors.apptheme,
                          fontWeight: FontWeight.bold)
                    ])),
            Obx(() => Home.isLoading.value == true
                    ? _loader()
                    : Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        // height: screenHeight(context) * 0.25,
                        color: Colors.white,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: Home.upcomingEventList.length,
                            itemBuilder: (contex, index) {
                              DateTime monthDate = DateTime.parse(
                                  Home.upcomingEventList[index].eventDate);
                              String formattedDate =
                                  DateFormat('dd-MMM-yyyy').format(monthDate);
                              return Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    onTap: () {},
                                    leading: Container(
                                      padding: EdgeInsets.all(4),
                                      height: 60,
                                      width: 60,
                                      child: Home.upcomingEventList[index]
                                                  .icon ==
                                              null
                                          ? Image.asset(
                                              "assets/images/favicon.png",
                                            )
                                          : Image.network(
                                              Home.upcomingEventList[index].icon
                                                  .toString(),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    title: CustomText(
                                      Home.upcomingEventList[index]
                                          .vratUtsavNameEng,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    subtitle: CustomText(
                                      formattedDate,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    trailing:
                                        Icon(Icons.arrow_forward_ios_outlined),
                                    textColor: Colors.black,
                                  ),
                                ),
                              );
                              // return Column(
                              //   children: [
                              //     InkWell(
                              //         onTap: () {
                              //           Get.to(() => TodayBhajan(
                              //                 description: Home
                              //                     .todayBhajanEventList[index]
                              //                     .description
                              //                     .toString(),
                              //                 title: Home
                              //                     .todayBhajanEventList[index].title
                              //                     .toString(),
                              //               ));
                              //         },
                              //         child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Container(
                              //                   height: 140,
                              //                   width: 250,
                              //                   margin: EdgeInsets.only(
                              //                       top: 10, left: 10),
                              //                   // color: Colors.green,
                              //                   child: ClipRRect(
                              //                       borderRadius: BorderRadius.only(
                              //                           topLeft:
                              //                               Radius.circular(15),
                              //                           topRight:
                              //                               Radius.circular(15)),
                              //                       child: CachedImageWithShimmer(
                              //                           fit: BoxFit.fitHeight,
                              //                           imageUrl: Home
                              //                                   .todayBhajanEventList[
                              //                                       index]
                              //                                   .icon ??
                              //                               "https://cdn.crispedge.com/a7aeb4.png"))),
                              //               Container(
                              //                   margin: EdgeInsets.symmetric(
                              //                       horizontal: 10),
                              //                   width: 250,
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 5),
                              //                   decoration: BoxDecoration(
                              //                       color: Color.fromARGB(
                              //                           179, 221, 218, 218),
                              //                       borderRadius: BorderRadius.only(
                              //                           bottomLeft:
                              //                               Radius.circular(15),
                              //                           bottomRight:
                              //                               Radius.circular(15))),
                              //                   child: Column(children: [
                              //                     Container(
                              //                         padding: EdgeInsets.symmetric(
                              //                             horizontal: 10),
                              //                         width: 250,
                              //                         child: CustomText(
                              //                             Home
                              //                                 .todayBhajanEventList[
                              //                                     index]
                              //                                 .title
                              //                                 .toString(),
                              //                             fontSize: 9,
                              //                             overflow: TextOverflow
                              //                                 .ellipsis)),
                              //                     Container(
                              //                         padding: EdgeInsets.symmetric(
                              //                             horizontal: 10),
                              //                         width: 250,
                              //                         child: CustomText(
                              //                             Home
                              //                                 .todayBhajanEventList[
                              //                                     index]
                              //                                 .date
                              //                                 .toString(),
                              //                             fontSize: 9,
                              //                             overflow: TextOverflow
                              //                                 .ellipsis)),
                              //                     // Container(
                              //                     //     width: 250,
                              //                     //     padding: EdgeInsets.symmetric(
                              //                     //         horizontal: 10),
                              //                     //     child: Row(
                              //                     //         mainAxisAlignment:
                              //                     //             MainAxisAlignment
                              //                     //                 .spaceBetween,
                              //                     //         children: [
                              //                     //           CustomText(
                              //                     //               Home
                              //                     //                       .upcomingEventList[
                              //                     //                           index]
                              //                     //                       .utsavTime
                              //                     //                       .toString() ??
                              //                     //                   "---",
                              //                     //               fontSize: 9),
                              //                     //           // CustomText(
                              //                     //           //      Home.upcomingEventList[index].
                              //                     //           //   .toString(),
                              //                     //           //     fontSize: 9)
                              //                     //         ]))
                              //                   ]))
                              //             ]))
                              //   ],
                              // );
                            }))
                // : SizedBox(
                //     height: screenHeight(context) * 0.25,
                //     child: ListView.builder(
                //         itemCount: Home.upcomingEventList.length,
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: (contex, index) {
                //           return Container(
                //             // decoration: BoxDecoration(
                //             //     borderRadius: BorderRadius.circular(10),
                //             //     border: Border.all(color: Colors.black.withOpacity(0.3))
                //             // ),
                //             child: Column(
                //               children: [
                //                 InkWell(
                //                     onTap: () {},
                //                     child: Column(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           Home.upcomingEventList[index].icon ==
                //                                   null
                //                               ? Container(
                //                                   height: 140,
                //                                   width: 250,
                //                                   margin: EdgeInsets.only(
                //                                       top: 10, left: 10),
                //                                   child: ClipRRect(
                //                                       borderRadius: BorderRadius.only(
                //                                           topLeft:
                //                                               Radius.circular(
                //                                                   15),
                //                                           topRight:
                //                                               Radius.circular(
                //                                                   15)),
                //                                       child: Container(
                //                                         decoration: BoxDecoration(
                //                                             image: DecorationImage(
                //                                                 image: NetworkImage(
                //                                                     "https://cdn.crispedge.com/a7aeb4.png"))),
                //                                         child: Column(
                //                                           mainAxisAlignment:
                //                                               MainAxisAlignment
                //                                                   .center,
                //                                           children: [
                //                                             // CustomText(Home
                //                                             //     .upcomingEventList[
                //                                             //         index]
                //                                             //     .vratUtsavNameEng
                //                                             //     .toString(),
                //                                             // textAlign: TextAlign.center,),
                //                                             CustomText(
                //                                               Home
                //                                                   .upcomingEventList[
                //                                                       index]
                //                                                   .eventDate
                //                                                   .toString(),
                //                                               color:
                //                                                   Colors.white,
                //                                             )
                //                                           ],
                //                                         ),
                //                                       )))
                //                               : Container(
                //                                   height: 140,
                //                                   width: 250,
                //                                   margin: EdgeInsets.only(
                //                                       top: 10, left: 10),
                //                                   child: ClipRRect(
                //                                       borderRadius:
                //                                           BorderRadius.only(
                //                                               topLeft: Radius
                //                                                   .circular(15),
                //                                               topRight:
                //                                                   Radius.circular(
                //                                                       15)),
                //                                       child:
                //                                           CachedImageWithShimmer(
                //                                               //fit: BoxFit.cover,
                //                                               imageUrl: Home
                //                                                   .upcomingEventList[index]
                //                                                   .icon))),
                //                           Container(
                //                               margin: EdgeInsets.symmetric(
                //                                   horizontal: 10),
                //                               width: 250,
                //                               padding: EdgeInsets.symmetric(
                //                                   vertical: 5),
                //                               decoration: BoxDecoration(
                //                                   color: Color.fromARGB(
                //                                       179, 221, 218, 218),
                //                                   borderRadius:
                //                                       BorderRadius.only(
                //                                           bottomLeft:
                //                                               Radius.circular(
                //                                                   15),
                //                                           bottomRight:
                //                                               Radius.circular(
                //                                                   15))),
                //                               child: Column(children: [
                //                                 Container(
                //                                     padding:
                //                                         EdgeInsets.symmetric(
                //                                             horizontal: 10),
                //                                     width: 250,
                //                                     child: CustomText(
                //                                         Home
                //                                             .upcomingEventList[
                //                                                 index]
                //                                             .vratUtsavNameEng
                //                                             .toString(),
                //                                         fontSize: 9,
                //                                         overflow: TextOverflow
                //                                             .ellipsis)),
                //                                 Container(
                //                                     padding:
                //                                         EdgeInsets.symmetric(
                //                                             horizontal: 10),
                //                                     width: 250,
                //                                     child: CustomText(
                //                                         Home
                //                                             .upcomingEventList[
                //                                                 index]
                //                                             .eventDate
                //                                             .toString(),
                //                                         fontSize: 9,
                //                                         overflow: TextOverflow
                //                                             .ellipsis)),
                //                                 Container(
                //                                     width: 250,
                //                                     padding:
                //                                         EdgeInsets.symmetric(
                //                                             horizontal: 10),
                //                                     child: Row(
                //                                         mainAxisAlignment:
                //                                             MainAxisAlignment
                //                                                 .spaceBetween,
                //                                         children: [
                //                                           CustomText(
                //                                               Home.upcomingEventList[index].utsavTime
                //                                                           .toString() ==
                //                                                       "null"
                //                                                   ? ""
                //                                                   : Home.upcomingEventList[index]
                //                                                           .utsavTime
                //                                                           .toString() ??
                //                                                       "---",
                //                                               fontSize: 9),
                //                                           // CustomText(
                //                                           //      Home.upcomingEventList[index].
                //                                           //   .toString(),
                //                                           //     fontSize: 9)
                //                                         ]))
                //                               ]))
                //                         ]))
                //               ],
                //             ),
                //           );
                //         }))
                )
          ]);
  }

  Widget todayBhajaneventSection() {
    return Home.todayBhajanEventList.isEmpty
        ? SizedBox.shrink()
        : Container(
            color: Colors.transparent,
            child: Column(children: [
              Container(
                // margin: EdgeInsets.only(top: 10),
                child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText("Today's Bhajan",
                              color: AppColors.apptheme,
                              fontWeight: FontWeight.bold)
                        ])),
              ),
              Obx(() => Home.isLoading.value == true
                      ? _loader()
                      : Container(
                          height: 150,
                          width: screenWidth(context),
                          color: Colors.transparent,
                          padding: EdgeInsets.only(left: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: Home.todayBhajanEventList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 100,
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Home.todayBhajanEventList[index]
                                    //                               .icon ==
                                    //                           null
                                    //                       ? ClipOval(
                                    //                           child: Image.network(
                                    //                             "https://cdn.crispedge.com/a7aeb4.png",
                                    //                           ),
                                    //                         )
                                    //                       : ClipOval(
                                    //                           child: Image.network(
                                    //                             Home.todayBhajanEventList[index]
                                    //                                 .icon
                                    //                                 .toString(),
                                    //                             fit: BoxFit.cover,
                                    //                           ),
                                    //                         ),
                                    //                 ),
                                    ClipOval(
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 100,
                                        width: 100,
                                        child: Home.todayBhajanEventList[index]
                                                    .icon ==
                                                null
                                            ? Image.network(
                                                "https://cdn.crispedge.com/a7aeb4.png",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                Home.todayBhajanEventList[index]
                                                    .icon
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                        Home.todayBhajanEventList[index].title.toString(),maxLines: 1,fontSize: 12,)
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                  // : Container(
                  //     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  //     // height: screenHeight(context) * 0.25,
                  //     color: Colors.transparent,
                  //     child: ListView.builder(
                  //         padding: EdgeInsets.zero,
                  //         shrinkWrap: true,
                  //         scrollDirection: Axis.vertical,
                  //         itemCount: Home.todayBhajanEventList.length,
                  //         itemBuilder: (contex, index) {
                  //           return Card(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                   border: Border.all(
                  //                       color: Colors.black.withOpacity(0.2)),
                  //                   borderRadius: BorderRadius.circular(10)),
                  //               child: ListTile(
                  //                 onTap: () {
                  //                   Get.to(() => TodayBhajan(
                  //                         description: Home
                  //                             .todayBhajanEventList[index]
                  //                             .description
                  //                             .toString(),
                  //                         title: Home
                  //                             .todayBhajanEventList[index].title
                  //                             .toString(),
                  //                       ));
                  //                 },
                  //                 leading: Container(
                  //                   //padding: EdgeInsets.all(5),
                  //                   height: 60,
                  //                   width: 60,
                  //                   color: Colors.transparent,
                  //                   child: Home.todayBhajanEventList[index]
                  //                               .icon ==
                  //                           null
                  //                       ? ClipOval(
                  //                           child: Image.network(
                  //                             "https://cdn.crispedge.com/a7aeb4.png",
                  //                           ),
                  //                         )
                  //                       : ClipOval(
                  //                           child: Image.network(
                  //                             Home.todayBhajanEventList[index]
                  //                                 .icon
                  //                                 .toString(),
                  //                             fit: BoxFit.cover,
                  //                           ),
                  //                         ),
                  //                 ),
                  //                 title: CustomText(
                  //                   Home.todayBhajanEventList[index].title,
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //                 subtitle: CustomText(
                  //                   Home.todayBhajanEventList[index].date,
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //                 trailing:
                  //                     Icon(Icons.arrow_forward_ios_outlined),
                  //                 textColor: Colors.black,
                  //               ),
                  //             ),
                  //           );
                  //           // return Column(
                  //           //   children: [
                  //           //     InkWell(
                  //           //         onTap: () {
                  //           //           Get.to(() => TodayBhajan(
                  //           //                 description: Home
                  //           //                     .todayBhajanEventList[index]
                  //           //                     .description
                  //           //                     .toString(),
                  //           //                 title: Home
                  //           //                     .todayBhajanEventList[index].title
                  //           //                     .toString(),
                  //           //               ));
                  //           //         },
                  //           //         child: Column(
                  //           //             crossAxisAlignment:
                  //           //                 CrossAxisAlignment.start,
                  //           //             children: [
                  //           //               Container(
                  //           //                   height: 140,
                  //           //                   width: 250,
                  //           //                   margin: EdgeInsets.only(
                  //           //                       top: 10, left: 10),
                  //           //                   // color: Colors.green,
                  //           //                   child: ClipRRect(
                  //           //                       borderRadius: BorderRadius.only(
                  //           //                           topLeft:
                  //           //                               Radius.circular(15),
                  //           //                           topRight:
                  //           //                               Radius.circular(15)),
                  //           //                       child: CachedImageWithShimmer(
                  //           //                           fit: BoxFit.fitHeight,
                  //           //                           imageUrl: Home
                  //           //                                   .todayBhajanEventList[
                  //           //                                       index]
                  //           //                                   .icon ??
                  //           //                               "https://cdn.crispedge.com/a7aeb4.png"))),
                  //           //               Container(
                  //           //                   margin: EdgeInsets.symmetric(
                  //           //                       horizontal: 10),
                  //           //                   width: 250,
                  //           //                   padding: EdgeInsets.symmetric(
                  //           //                       vertical: 5),
                  //           //                   decoration: BoxDecoration(
                  //           //                       color: Color.fromARGB(
                  //           //                           179, 221, 218, 218),
                  //           //                       borderRadius: BorderRadius.only(
                  //           //                           bottomLeft:
                  //           //                               Radius.circular(15),
                  //           //                           bottomRight:
                  //           //                               Radius.circular(15))),
                  //           //                   child: Column(children: [
                  //           //                     Container(
                  //           //                         padding: EdgeInsets.symmetric(
                  //           //                             horizontal: 10),
                  //           //                         width: 250,
                  //           //                         child: CustomText(
                  //           //                             Home
                  //           //                                 .todayBhajanEventList[
                  //           //                                     index]
                  //           //                                 .title
                  //           //                                 .toString(),
                  //           //                             fontSize: 9,
                  //           //                             overflow: TextOverflow
                  //           //                                 .ellipsis)),
                  //           //                     Container(
                  //           //                         padding: EdgeInsets.symmetric(
                  //           //                             horizontal: 10),
                  //           //                         width: 250,
                  //           //                         child: CustomText(
                  //           //                             Home
                  //           //                                 .todayBhajanEventList[
                  //           //                                     index]
                  //           //                                 .date
                  //           //                                 .toString(),
                  //           //                             fontSize: 9,
                  //           //                             overflow: TextOverflow
                  //           //                                 .ellipsis)),
                  //           //                     // Container(
                  //           //                     //     width: 250,
                  //           //                     //     padding: EdgeInsets.symmetric(
                  //           //                     //         horizontal: 10),
                  //           //                     //     child: Row(
                  //           //                     //         mainAxisAlignment:
                  //           //                     //             MainAxisAlignment
                  //           //                     //                 .spaceBetween,
                  //           //                     //         children: [
                  //           //                     //           CustomText(
                  //           //                     //               Home
                  //           //                     //                       .upcomingEventList[
                  //           //                     //                           index]
                  //           //                     //                       .utsavTime
                  //           //                     //                       .toString() ??
                  //           //                     //                   "---",
                  //           //                     //               fontSize: 9),
                  //           //                     //           // CustomText(
                  //           //                     //           //      Home.upcomingEventList[index].
                  //           //                     //           //   .toString(),
                  //           //                     //           //     fontSize: 9)
                  //           //                     //         ]))
                  //           //                   ]))
                  //           //             ]))
                  //           //   ],
                  //           // );
                  //         }))
                  )
            ]),
          );
  }

  Widget _loaderSlider() {
    return Container(
        height: screenHeight(context) * 0.18,
        width: screenWidth(context),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[200]!,
                child:
                    Container(width: 200, height: 200, color: Colors.white))));
  }

  Widget _loader() {
    return SizedBox(
        height: screenHeight(context) * 0.2,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                  height: 125,
                  width: 250,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Shimmer.fromColors(
                          highlightColor: Colors.grey[300]!,
                          baseColor: Colors.grey[200]!,
                          child: Container(
                              width: 200, height: 200, color: Colors.white))));
            }));
  }
}
