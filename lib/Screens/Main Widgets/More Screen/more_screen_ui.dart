// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/globals.dart';

import '../../Custom Widgets/CustomText.dart';

class MoreScreenUI extends StatefulWidget {
  const MoreScreenUI({super.key});

  @override
  State<MoreScreenUI> createState() => _MoreScreenUIState();
}

class _MoreScreenUIState extends State<MoreScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.backgroundImage,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              AppImages.dasbboardBottomPic,
              fit: BoxFit.fill,
              height: 200,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  SizedBox(height: screenHeight(context) * 0.05),
                  headingTitle(),
                  SizedBox(height: screenHeight(context) * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageBox(
                          imageName: AppImages.dashboardImage1,
                          title: "Daily Darshan"),
                      imageBox(
                          imageName: AppImages.dashboardImage2,
                          title: "Daily Katha"),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageBox(
                          imageName: AppImages.dashboardImage3, title: "Video"),
                      imageBox(
                          imageName: AppImages.dashboardImage4,
                          title: "E-Books"),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.03),
                  Row(
                    children: [
                      imageBox(
                          imageName: AppImages.dashboardImage5, title: "More"),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget headingTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: SizedBox(
        height: screenHeight(context) * 0.12,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                AppImages.dasbboardMandirPic,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: CustomText(
                "Loyadham Satsang",
                fontSize: 30,
                textAlign: TextAlign.center,
                color: AppColors.apptheme,
                fontWeight: FontWeight.w500,
                wordSpacing: 2,
                fontFamily: 'Black Chancery',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageBox({String? imageName, String? title}) {
    return Column(children: [
      Image.asset(
        imageName!,
        fit: BoxFit.cover,
        width: screenWidth(context) * 0.3,
      ),
      SizedBox(height: 5),
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            AppImages.textLine,
            fit: BoxFit.cover,
            width: screenWidth(context) * 0.35,
          ),
          CustomText(
            title!,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    ]);
  }
}
