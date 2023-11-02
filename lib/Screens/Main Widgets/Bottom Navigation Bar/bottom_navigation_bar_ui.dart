// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/Bottomsheet.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/Drawer.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/dashboard_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Events/event_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Music/music_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/video_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';

class BottomNavigation extends StatefulWidget {
  int index;
  BottomNavigation({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 2;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
            drawer: Drawer(
              width: MediaQuery.of(context).size.width * .9,
              child: DrawerData(),
            ),
            body: IndexedStack(
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
                });
              }),
          card(
              title: "Music",
              imageName: AppImages.audioBottombar,
              onTap: () {
                setState(() {
                  widget.index = 1;
                });
              }),
          card(
              title: "Home",
              imageName: AppImages.homeBottombar,
              onTap: () {
                setState(() {
                  widget.index = 2;
                });
              }),
          card(
              title: "Photos",
              imageName: AppImages.photosBottombar,
              onTap: () {
                setState(() {
                  widget.index = 3;
                });
              }),
          card(
              title: "More",
              imageName: AppImages.moreBottomBar,
              onTap: () {
                setState(() {
                  widget.index = 4;
                  showModalBottomSheet(
                      barrierColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetUI();
                      });
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
}
