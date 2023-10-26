// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Music/kirtan&katha_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';

class MusicScreenUI extends StatefulWidget {
  const MusicScreenUI({super.key});

  @override
  State<MusicScreenUI> createState() => _MusicScreenUIState();
}

class _MusicScreenUIState extends State<MusicScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Music", isBack: false),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cards(
                      title: "ALL KIRTANS",
                      onTap: () {
                        Get.to(() => KirtanKathaScreenUI(
                            title: "ALL KIRTANS", type: 'kirtan'));
                      }),
                  cards(
                      title: "ALL KATHA",
                      onTap: () {
                        Get.to(() => KirtanKathaScreenUI(
                            title: "ALL KATHA", type: 'katha'));
                      })
                ])));
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
