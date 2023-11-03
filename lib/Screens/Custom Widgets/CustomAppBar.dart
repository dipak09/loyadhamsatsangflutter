// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBack;
  final List<Widget>? actions;

  CustomAppBar({Key? key, this.title, this.isBack = true, this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        elevation: 10,
        actions: actions,
        title: CustomText(
          title!,
          fontSize: 15,
          textAlign: TextAlign.center,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        leading: isBack!
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ))
            : SizedBox.shrink(),
        flexibleSpace: Container(
          color: AppColors.apptheme,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
