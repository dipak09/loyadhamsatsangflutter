// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Controllers/dashboard_controller.dart';
import 'package:loyadhamsatsang/Controllers/firebase_notification_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/Drawer.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/animation.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Books%20Screen/books_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Calendar/calender_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Daily%20Darshan/daily_darshan_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/dashboard_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Events/event_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Music/music_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Privacy%20Policy/privacypolicy_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Sant%20Mandal/sant_mandal_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Settings/settings_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Term%20&%20Conditions/termandconditons_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/video_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';

import 'package:intl/intl.dart';

bool? isBottomSheet = false;

class BottomNavigation extends StatefulWidget {
  int index;

  BottomNavigation({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 2;
  @override
  void initState() {
    super.initState();
    isBottomSheet = false;
    setState(() {});
  }
  var firebaseNotificationController = Get.put(FirebaseNotificationController());
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  var DailyDarshan = Get.put(DashboardController());
  @override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: Text('Are you sure you want to exit?'),
                    actions: <Widget>[
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            side: BorderSide(
                                width: 2, color: AppColors.apptheme)),
                        child: CustomText("No"),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            side:
                                BorderSide(width: 2, color: AppColors.apptheme),
                          ),
                          child: CustomText("Yes,exit"),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          })
                    ]);
              });

          return value == true;
        },
        child: Scaffold(
            key: _drawerKey,
            bottomSheet: isBottomSheet!
                ? CustomSlidetransition(dx: 400, dy: 1, child: bottomSheet())
                : SizedBox.shrink(),
            drawer: Drawer(
              width: MediaQuery.of(context).size.width * .9,
              child: DrawerData(),
            ),
            body: Stack(
              children: [
                IndexedStack(
                  index: widget.index,
                  children: <Widget>[
                    VideoScreenUI(),
                    MusicScreenUI(),
                    DashboardScreenUI(
                      drawer: _drawerKey,
                    ),
                    EventScreenUI(),
                    DashboardScreenUI(
                      drawer: _drawerKey,
                    )
                  ],
                ),
              ],
            ),
            bottomNavigationBar: buildMyNavBar(context)));
  }

  buildMyNavBar(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.white, //New
              blurRadius: 25.0)
        ]),
        alignment: Alignment.center,
        height: screenHeight(context) * 0.08,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          card(
              title: "Video",
              imageName: AppImages.videoBottombar,
              onTap: () {
                setState(() {
                  widget.index = 0;
                  isBottomSheet = false;
                });
              }),
          card(
              title: "Music",
              imageName: AppImages.audioBottombar,
              onTap: () {
                setState(() {
                  widget.index = 1;
                  isBottomSheet = false;
                });
              }),
          card(
              title: "Home",
              imageName: AppImages.homeBottombar,
              onTap: () {
                setState(() {
                  widget.index = 2;
                  isBottomSheet = false;
                });
              }),
          card(
              title: "Photos",
              imageName: AppImages.photosBottombar,
              onTap: () {
                setState(() {
                  widget.index = 3;
                  isBottomSheet = false;
                });
              }),
          card(
              title: "More",
              imageName: AppImages.moreBottomBar,
              onTap: () {
                setState(() {
                  widget.index = 4;
                  if (isBottomSheet == true) {
                    isBottomSheet = false;
                  } else {
                    isBottomSheet = true;
                  }
                });
              })
        ]));
  }

  Widget card({String? title, String? imageName, Function? onTap}) {
    return InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(children: [
              Image.asset(imageName!, height: 20, width: 20),
              SizedBox(height: 5),
              CustomText(title!, fontSize: 10)
            ])));
  }

  Widget bottomSheet() {
    return Container(
        height: screenHeight(context) * 0.35,
        width: screenWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white,
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(children: [
            CustomText("Loyadham Satsang", fontSize: 30),
            CustomText("Version 3.0", fontSize: 15, color: Colors.black)
          ]),
          SizedBox(height: 20),
          // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //   InkWell(
          //       onTap: () {
          //         setState(() {
          //           isBottomSheet = false;
          //         });
          //       //  Get.to(() => PrivacyPolicyScreenUI());
          //       },
          //       child: CustomText("Privacy Policy",
          //           fontSize: 15, color: Colors.black)),
          //   SizedBox(width: 5),
          //   CustomText("|", fontSize: 15, color: Colors.black),
          //   SizedBox(width: 5),
          //   InkWell(
          //       onTap: () {
          //         setState(() {
          //           isBottomSheet = false;
          //         });
          //       //  Get.to(() => TermAndConditonsScreenUI());
          //       },
          //       child: CustomText("Term & Conditions",
          //           fontSize: 15, color: Colors.black))
          // ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            cardBottomSheet(
                title: "Calendar",
                imageName: AppImages.calenderBottomSheet,
                onTap: () {
                  setState(() {
                    isBottomSheet = false;
                  });
                  Get.to(() => CalenderScreenUI());
                }),
            cardBottomSheet(
                title: "Books",
                imageName: AppImages.booksBottomSheet,
                onTap: () {
                  setState(() {
                    isBottomSheet = false;
                  });
                  Get.to(() => BooksScreenUI());
                }),
            cardBottomSheet(
                title: "Sant Mandal",
                imageName: AppImages.santmandalBottomSheet,
                onTap: () {
                  setState(() {
                    isBottomSheet = false;
                  });
                  Get.to(() => SantMandalScreenUI());
                }),
            cardBottomSheet(
                title: "Daily Darshan",
                imageName: AppImages.dailyDarshanBottomSheet,
                onTap: () {
                  setState(() {
                    isBottomSheet = false;
                  });
                  final selectedDate = DateFormat("yyyy-MM-dd hh:mm:ss")
                      .parse(DailyDarshan.dailyDarshan_date.toString());

                  Get.to(() => DailyDarshanScreenUI(
                      title: DailyDarshan.dailyDarshan_title.toString(),
                      date: selectedDate));
                }),
            cardBottomSheet(
                title: "Setting",
                imageName: AppImages.settingBottomSheet,
                onTap: () {
                  setState(() {
                    isBottomSheet = false;
                  });
                  Get.to(() => SettingScreenUI());
                }),
          ]),
        ]));
  }

  Widget cardBottomSheet({String? title, String? imageName, Function? onTap}) {
    return InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(children: [
              Image.asset(imageName!, height: 20, width: 20),
              SizedBox(height: 5),
              CustomText(title!, fontSize: 10)
            ])));
  }
}
