// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        forceMaterialTransparency: true,
        elevation: 10,
        title: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: SizedBox(
                height: screenHeight(context) * 0.07,
                child: Stack(children: [
                  Image.asset(
                    AppImages.dasbboardMandirPic,
                    fit: BoxFit.cover,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomText("Loyadham Satsang",
                          fontSize: 20,
                          textAlign: TextAlign.center,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          wordSpacing: 2,
                          fontFamily: 'Black Chancery'))
                ]))),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(AppImages.appBarNotificationPic,
                  height: 25, width: 25)),
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(AppImages.appBarSearchPic,
                  height: 25, width: 25))
        ],
        flexibleSpace: Image(
            image: AssetImage(AppImages.appBarBackgroundPic),
            fit: BoxFit.cover));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
