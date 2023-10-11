// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleImage;
  final Function? mycartTap;
  CustomAppBar({Key? key, required this.titleImage, this.mycartTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        forceMaterialTransparency: true,
        elevation: 10,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: SizedBox(
          height: 100,
          child: Image.asset(
            titleImage!,
            fit: BoxFit.fill,
          ),
        ),
        flexibleSpace: Image(
            image: AssetImage(AppImages.appBarBackgroundPic),
            fit: BoxFit.cover));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
