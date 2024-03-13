// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
  var LiveStream = Get.put(LiveStreamController());
  var FeatureMedia = Get.put(FeaturedmediaController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FeatureMedia.getData();
    //  LiveStream.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white54,
        appBar: DashboardAppBar(drawer: widget.drawer),
        body: SingleChildScrollView(
            child: Column(children: [
          Obx(() => Home.isLoading.value == true
              ? _loaderSlider()
              : DashBoardImageSlider()),
          liveStreamSection(),
          dailyDarshanSection(),
          featuredMediaSection(),

              todayBhajaneventSection(),
          //SizedBox(height: 10),
          upcomingeventSection()
        ])));
  }

  Widget liveStreamSection() {
    return LiveStream.livestreamchannel.length == 0 &&
            LiveStream.livestreamchannel.isEmpty
        ? SizedBox.shrink()
        : Column(children: [
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("Live Streaming",
                          color: Colors.black, fontWeight: FontWeight.bold)
                    ])),
            Obx(() => LiveStream.isLoading.value == true
                ? _loader()
                : SizedBox(
                    height: screenHeight(context) * 0.2,
                    child: ListView.builder(
                        itemCount: LiveStream.livestreamchannel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contex, index) {
                          return InkWell(
                              onTap: () {
                                Get.to(() => VideoScreen(
                                    url: LiveStream
                                        .livestreamchannel[index].youtubeLink,
                                    videoId: LiveStream
                                        .livestreamchannel[index].initialId));
                              },
                              child: Container(
                                  height: 125,
                                  width: 250,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(LiveStream
                                              .livestreamchannel[index]
                                              .thumbnail
                                              .toString()),
                                          fit: BoxFit.fill)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedImageWithShimmer(
                                          imageUrl: LiveStream
                                              .livestreamchannel[index]
                                              .thumbnail
                                              .toString()))));
                        })))
          ]);
  }

  Widget dailyDarshanSection() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText("Daily Darshan",
                    color: Colors.black, fontWeight: FontWeight.bold)
              ])),
      Obx(() => Home.isLoading.value == true
          ? _loader()
          : SizedBox(
              height: screenHeight(context) * 0.2,
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
                                horizontal: 5, vertical: 10),
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
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomText(
              "Featured Media",
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ])),
      Obx(() => FeatureMedia.isLoading.value == true
          ? _loader()
          : SizedBox(
              height: screenHeight(context) * 0.27,
              child: ListView.builder(
                  itemCount: FeatureMedia.list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contex, index) {
                    return InkWell(
                        onTap: () {
                          Get.to(() => FeaturedMediaVideoID(
                                timeAgo: FeatureMedia.list[index].timeAgo,
                                title: FeatureMedia.list[index].title,
                                view: FeatureMedia.list[index].viewCount,
                                publishedDate:
                                    FeatureMedia.list[index].publishedDate,
                                url: FeatureMedia.list[index].youtubeLink,
                                videoId: FeatureMedia.list[index].initialId,
                              ));
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 140,
                                  width: 250,
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      child: CachedImageWithShimmer(
                                          fit: BoxFit.fitHeight,
                                          imageUrl: FeatureMedia
                                              .list[index].thumbnail!))),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  width: 250,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(179, 221, 218, 218),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                                  child: Column(children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: 250,
                                        child: CustomText(
                                            FeatureMedia.list[index].title!,
                                            fontSize: 9,
                                            overflow: TextOverflow.ellipsis)),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: 250,
                                        child: CustomText(
                                            FeatureMedia
                                                .list[index].publishedDate!
                                                .toString(),
                                            fontSize: 9,
                                            overflow: TextOverflow.ellipsis)),
                                    Container(
                                        width: 250,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                  FeatureMedia
                                                      .list[index].timeAgo!,
                                                  fontSize: 9),
                                              CustomText(
                                                  FeatureMedia
                                                      .list[index].viewCount!,
                                                  fontSize: 9)
                                            ]))
                                  ]))
                            ]));
                  })))
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
                          color: Colors.black, fontWeight: FontWeight.bold)
                    ])),
            Obx(() => Home.isLoading.value == true
                ? _loader()
                : SizedBox(
                    height: screenHeight(context) / 2,
                    child: ListView.builder(
                        itemCount: Home.upcomingEventList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contex, index) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 140,
                                            width: 250,
                                            margin: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15)),
                                                child: CachedImageWithShimmer(
                                                    fit: BoxFit.fitHeight,
                                                    imageUrl: Home
                                                            .upcomingEventList[
                                                                index]
                                                            .icon ??
                                                        "https://cdn.crispedge.com/a7aeb4.png"))),
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 250,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    179, 221, 218, 218),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15))),
                                            child: Column(children: [
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  width: 250,
                                                  child: CustomText(
                                                      Home
                                                          .upcomingEventList[
                                                              index]
                                                          .vratUtsavNameEng
                                                          .toString(),
                                                      fontSize: 9,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  width: 250,
                                                  child: CustomText(
                                                      Home
                                                          .upcomingEventList[
                                                              index]
                                                          .eventDate
                                                          .toString(),
                                                      fontSize: 9,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
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
                                                                    .upcomingEventList[
                                                                        index]
                                                                    .utsavTime
                                                                    .toString() ??
                                                                "---",
                                                            fontSize: 9),
                                                        // CustomText(
                                                        //      Home.upcomingEventList[index].
                                                        //   .toString(),
                                                        //     fontSize: 9)
                                                      ]))
                                            ]))
                                      ]))
                            ],
                          );
                        })))
          ]);
  }

  Widget todayBhajaneventSection() {
    return Home.todayBhajanEventList.isEmpty
        ? SizedBox.shrink()
        : Column(children: [
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("Todays Bhajan",
                          color: Colors.black, fontWeight: FontWeight.bold)
                    ])),
            Obx(() => Home.isLoading.value == true
                ? _loader()
                : Container(
                    height: screenHeight(context) *0.25,
                    color: Colors.transparent,
                    child: ListView.builder(
                        itemCount: Home.todayBhajanEventList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contex, index) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 140,
                                            width: 250,
                                            margin: EdgeInsets.only(
                                                top: 10, left: 10),
                                           // color: Colors.green,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15)),
                                                child: CachedImageWithShimmer(
                                                    fit: BoxFit.fitHeight,
                                                    imageUrl:
                                                        "https://cdn.crispedge.com/a7aeb4.png"))
                                        ),
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 250,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    179, 221, 218, 218),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15))),
                                            child: Column(children: [
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  width: 250,
                                                  child: CustomText(
                                                      Home
                                                          .todayBhajanEventList[
                                                              index]
                                                          .title
                                                          .toString(),
                                                      fontSize: 9,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  width: 250,
                                                  child: CustomText(
                                                      Home
                                                          .todayBhajanEventList[
                                                              index]
                                                          .date
                                                          .toString(),
                                                      fontSize: 9,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                              // Container(
                                              //     width: 250,
                                              //     padding: EdgeInsets.symmetric(
                                              //         horizontal: 10),
                                              //     child: Row(
                                              //         mainAxisAlignment:
                                              //             MainAxisAlignment
                                              //                 .spaceBetween,
                                              //         children: [
                                              //           CustomText(
                                              //               Home
                                              //                       .upcomingEventList[
                                              //                           index]
                                              //                       .utsavTime
                                              //                       .toString() ??
                                              //                   "---",
                                              //               fontSize: 9),
                                              //           // CustomText(
                                              //           //      Home.upcomingEventList[index].
                                              //           //   .toString(),
                                              //           //     fontSize: 9)
                                              //         ]))
                                            ]))
                                      ]))
                            ],
                          );
                        })))
          ]);
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
