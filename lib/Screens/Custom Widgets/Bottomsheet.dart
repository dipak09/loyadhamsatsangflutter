// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Books%20Screen/books_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Daily%20Darshan/daily_darshan_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';

class BottomSheetUI extends StatelessWidget {
  const BottomSheetUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenHeight(context) * 0.35,
        width: screenWidth(context),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(children: [
            CustomText("My Satsang", fontSize: 40),
            CustomText("Version 3.0", fontSize: 15, color: Colors.black)
          ]),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomText("Privacy Policy", fontSize: 15, color: Colors.black),
            SizedBox(width: 5),
            CustomText("|", fontSize: 15, color: Colors.black),
            SizedBox(width: 5),
            CustomText("Term & Conditions", fontSize: 15, color: Colors.black)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            card(title: "Calendar", imageName: AppImages.calenderBottomSheet),
            card(
                title: "Books",
                imageName: AppImages.booksBottomSheet,
                onTap: () {
                  Get.to(() => BooksScreenUI());
                }),
            card(
                title: "Sant Mandal",
                imageName: AppImages.santmandalBottomSheet),
            card(
                title: "Daily Darshan",
                imageName: AppImages.dailyDarshanBottomSheet,
                onTap: () {
                  Get.to(() => DailyDarshanScreenUI());
                }),
            card(title: "Setting", imageName: AppImages.settingBottomSheet)
          ])
        ]));
  }

  Widget card({String? title, String? imageName, Function? onTap}) {
    return GestureDetector(
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
