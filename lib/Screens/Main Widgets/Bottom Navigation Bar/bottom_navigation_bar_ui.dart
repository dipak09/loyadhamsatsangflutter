// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/dashboard_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';

class BottomNavigation extends StatefulWidget {
  int index;
  BottomNavigation({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  List<Widget> screens = [
    DashboardScreenUI(),
    DashboardScreenUI(),
    DashboardScreenUI(),
    DashboardScreenUI(),
    DashboardScreenUI(),
  ];
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
                          side:
                              BorderSide(width: 2, color: AppColors.apptheme)),
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
                          side: BorderSide(width: 2, color: AppColors.apptheme),
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
          body: screens[widget.index],
          bottomNavigationBar: buildMyNavBar(context)),
    );
  }

  buildMyNavBar(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.white, //New
            blurRadius: 25.0,
          )
        ]),
        height: screenHeight(context) * 0.08,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          widget.index == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 0;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25))
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 0;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25)),
          widget.index == 1
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 1;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25))
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 1;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25)),
          widget.index == 2
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 2;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25))
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 2;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25)),
          widget.index == 3
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 3;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25))
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 3;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25)),
          widget.index == 4
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 4;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25))
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.index = 4;
                    });
                  },
                  child: SvgPicture.asset(AppImages.eventBottomBar,
                      height: 25, width: 25))
        ]));
  }
}
