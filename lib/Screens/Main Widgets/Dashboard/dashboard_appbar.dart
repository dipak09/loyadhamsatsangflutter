// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/search_bar.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Notification/notification_screen_ui.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? drawerOnTap;
  final GlobalKey<ScaffoldState>? drawer;
  DashboardAppBar({this.drawerOnTap, this.drawer});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        forceMaterialTransparency: true,
        elevation: 10,
        leading: IconButton(
            onPressed: () {
              drawer!.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu, color: Colors.white)),
        title: CustomText("Loyadham Satsang",
            fontSize: 15,
            textAlign: TextAlign.center,
            color: Colors.white,
            fontWeight: FontWeight.w700),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => NotificationScreenUI());
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(AppImages.appBarNotificationPic,
                    height: 20, width: 20)),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SearchAppBar()));
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(AppImages.appBarSearchPic,
                    height: 20, width: 20)),
          )
        ],
        flexibleSpace: Container(color: AppColors.apptheme));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
