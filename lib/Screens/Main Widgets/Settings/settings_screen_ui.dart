// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class SettingScreenUI extends StatefulWidget {
  const SettingScreenUI({super.key});

  @override
  State<SettingScreenUI> createState() => _SettingScreenUIState();
}

class _SettingScreenUIState extends State<SettingScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cards(title: "SHARE THIS APP"),
            cards(title: "RATE APPLICATION"),
            cards(title: "VISIT OUR WEBSITE"),
            cards(title: "FEEDBACK"),
            cards(title: "CONTACT US"),
            cards(title: "ABOUT US"),
          ],
        ),
      ),
    );
  }

  Widget cards({String? title, Function? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: screenWidth(context),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: AppColors.apptheme,
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                topEnd: Radius.circular(5),
                bottomStart: Radius.circular(5),
                bottomEnd: Radius.circular(20))),
        child: CustomText(
          title!,
          color: Colors.white,
        ),
      ),
    );
  }
}
