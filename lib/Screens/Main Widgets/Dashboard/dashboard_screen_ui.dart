// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/dashboard_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Daily%20Darshan/daily_darshan_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/Dashboard_Image_slider.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/dashboard_appbar.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/video_screen.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DashboardScreenUI extends StatefulWidget {
  const DashboardScreenUI({super.key});

  @override
  State<DashboardScreenUI> createState() => _DashboardScreenUIState();
}

class _DashboardScreenUIState extends State<DashboardScreenUI> {
  var Home = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: Home.isLoading.value,
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: Scaffold(
          backgroundColor: Colors.white54,
          appBar: DashboardAppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                DashBoardImageSlider(),
                liveStreamSection(),
                dailyDarshanSection(),
                featuredMediaSection(),
                upcomingeventSection()
              ],
            ),
          ),
        )));
    // )));
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
                      CustomText(
                        "Live Streaming",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ])),
            SizedBox(
                height: screenHeight(context) * 0.2,
                child: ListView.builder(
                    itemCount: Home.livestreamingList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contex, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => VideoScreen(
                                url: Home.livestreamingList[index].youtubeLink,
                                videoId:
                                    Home.livestreamingList[index].initialId,
                              ));
                        },
                        child: Container(
                            height: 125,
                            width: 250,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(Home
                                        .livestreamingList[index].thumbnail!),
                                    fit: BoxFit.fill))),
                      );
                    }))
          ]);
  }

  Widget dailyDarshanSection() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomText(
              "Daily Darshan",
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ])),
      SizedBox(
          height: screenHeight(context) * 0.2,
          child: ListView.builder(
              itemCount: Home.dailyDarshanList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (contex, index) {
                return InkWell(
                  onTap: () {
                    // print(Home.dailyDarshanList[index].title);
                    // //print(Home.dailyDarshanList[index].albumTitle.toString());

                    Get.to(() => DailyDarshanScreenUI(
                        title: Home.dailyDarshanList[index].title,
                        date: Home.dailyDarshanList[index].albumTitle));
                  },
                  child: Container(
                      height: 125,
                      width: 250,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                  Home.dailyDarshanList[index].source),
                              fit: BoxFit.contain))),
                );
              }))
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
      SizedBox(
          height: screenHeight(context) * 0.2,
          child: ListView.builder(
              itemCount: Home.featuredMediaList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (contex, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => VideoScreen(
                          url: Home.featuredMediaList[index].youtubeLink,
                          videoId: Home.featuredMediaList[index].initialId,
                        ));
                  },
                  child: Container(
                      height: 125,
                      width: 250,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                  Home.featuredMediaList[index].thumbnail!),
                              fit: BoxFit.fill))),
                );
              }))
    ]);
  }

  Widget upcomingeventSection() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomText(
              "Upcoming Events",
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ])),
      SizedBox(
          height: screenHeight(context) * 0.2,
          child: ListView.builder(
              itemCount: Home.upcomingEventList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (contex, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => VideoScreen(
                          url: Home.upcomingEventList[index].youtubeLink,
                          videoId: Home.upcomingEventList[index].initialId,
                        ));
                  },
                  child: Container(
                      height: 125,
                      width: 250,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                  Home.upcomingEventList[index].thumbnail!),
                              fit: BoxFit.fill))),
                );
              }))
    ]);
  }
}


// Widget statusSection() {
//   return Column(children: [
//     Padding(
//         padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//         child:
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           CustomText("Stories",
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Open Sans'),
//           Row(children: [
//             Icon(Icons.arrow_right),
//             CustomText("Watch all",
//                 color: Colors.black,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'Open Sans')
//           ])
//         ])),
//     SizedBox(
//       height: screenHeight(context) * 0.13,
//       child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: Home.publicationList.length,
//           itemBuilder: (context, index) {
//             return statusCircleCard(
//                 onTap: () {
//                   Get.toNamed('/${Home.publicationList[index].routename}');
//                 },
//                 title: Home.publicationList[index].name,
//                 img: Home.publicationList[index].image);
//           }),
//     )
//   ]);
// }

// Widget statusCircleCard({String? title, String? img, Function? onTap}) {
//   return GestureDetector(
//     onTap: () {
//       if (onTap != null) onTap();
//     },
//     child: SizedBox(
//         height: screenHeight(context) * 0.13,
//         child: Column(children: [
//           Container(
//               height: 75,
//               width: 75,
//               margin: EdgeInsets.all(5),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(AppImages.statusCircle),
//                       fit: BoxFit.fill)),
//               child: ClipOval(
//                   child: Container(
//                       width: 60.0,
//                       height: 60.0,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           image: DecorationImage(
//                               image: NetworkImage(img!),
//                               fit: BoxFit.fill))))),
//           CustomText(title!,
//               color: Colors.black,
//               fontSize: 10,
//               overflow: TextOverflow.ellipsis,
//               fontWeight: FontWeight.w400,
//               fontFamily: 'Open Sans')
//         ])),
//   );
// }

// Widget branchesSection() {
//   return Column(children: [
//     Padding(
//         padding: EdgeInsets.only(left: 25, right: 25),
//         child:
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           CustomText("Branches",
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Open Sans'),
//           GestureDetector(
//             onTap: () {
//               Get.to(() => BranchesScreenUI());
//             },
//             child: Row(children: [
//               Icon(Icons.arrow_right),
//               CustomText("View all",
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'Open Sans')
//             ]),
//           )
//         ])),
//     SizedBox(
//       height: screenHeight(context) * 0.24,
//       child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: Home.branchesList.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Get.to(() => BranchesScreenUI());
//               },
//               child: dailyNiyamCard(
//                   title: Home.branchesList[index].name,
//                   img: Home.branchesList[index].image),
//             );
//           }),
//     ),
//   ]);
// }

// Widget dailyNiyamCard({String? title, String? img}) {
//   return Container(
//       height: 100,
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       child: Column(children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: Container(
//               width: 120.0,
//               height: 130.0,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   image: DecorationImage(
//                       image: NetworkImage(img!), fit: BoxFit.fill))),
//         ),
//         SizedBox(height: 10),
//         CustomText(title!,
//             fontSize: 10, color: Colors.black, textAlign: TextAlign.start)
//       ]));
// }


