// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Controllers/daily_darshan_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:intl/intl.dart';

class DailyDarshanScreenUI extends StatefulWidget {
  const DailyDarshanScreenUI({super.key});

  @override
  State<DailyDarshanScreenUI> createState() => _DailyDarshanScreenUIState();
}

class _DailyDarshanScreenUIState extends State<DailyDarshanScreenUI> {
  var controller = Get.put(DailyDarshanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(AppImages.backgroundImage,
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width),
      SingleChildScrollView(
          child: Column(children: [
        Padding(
            padding: EdgeInsets.only(top: 50),
            child: SizedBox(
                height: screenHeight(context) * 0.09,
                child: Stack(children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(AppImages.dasbboardMandirPic,
                          fit: BoxFit.cover)),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomText("Daily Darshan",
                          fontSize: 20,
                          textAlign: TextAlign.center,
                          wordSpacing: 2,
                          fontFamily: 'Open Sans'))
                ]))),
        titleselection(),
        dateSelection(),
        Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
                height: 350.0,
                child: Obx(() => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.dailyDarshanList.isNotEmpty &&
                            controller.dailyDarshanList != null
                        ? Stack(children: [
                            CarouselSlider(
                                items: controller.dailyDarshanList.map((e) {
                                  return Stack(children: [
                                    Container(
                                        height: 335,
                                        decoration: BoxDecoration(
                                            color: AppColors.backgroundColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            image: DecorationImage(
                                                image: NetworkImage(e.source),
                                                fit: BoxFit.cover))),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xffe2c9b6),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            child: CustomText(e.title,
                                                fontFamily: "Open Sans")))
                                  ]);
                                }).toList(),
                                options: CarouselOptions(
                                    height: 350.0,
                                    viewportFraction: 0.7,
                                    autoPlay:
                                        false, // Set this to true for automatic sliding
                                    enlargeCenterPage: true,
                                    onPageChanged: controller.onPageChanged))
                          ])
                        : Center(child: CustomText("No Images Found")))))
      ]))
    ]));
  }

  Widget titleselection() {
    return Stack(children: [
      Container(
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(AppImages.dailyDarshanSlider)))),
      Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                titleCards("Thakorji Maharaj"),
                titleCards('Loyadham NJ'),
                titleCards('Loyadham Kandari'),
                titleCards('Loyadham India'),
                titleCards('Loyadham Surat'),
                titleCards('Loyadham Canada')
              ])))
    ]);
  }

  Widget titleCards(String title) {
    return Obx(() => GestureDetector(
        onTap: () {
          controller.selectItem(title);
          controller.getValue();
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                color: controller.selectedTitle.value == title
                    ? AppColors.apptheme
                    : null,
                border: Border.all(
                    color: controller.selectedTitle.value == title
                        ? Colors.transparent
                        : AppColors.apptheme)),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: CustomText(title,
                fontSize: 10,
                color: controller.selectedTitle.value == title
                    ? Colors.white
                    : Colors.black))));
  }

  Widget dateSelection() {
    return Stack(children: [
      Container(
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(AppImages.dailyDarshanSlider)))),
      Container(
          height: 100,
          padding: EdgeInsets.only(left: 50, right: 40),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Obx(() {
              final selectedDate = controller.selectedDate;

              final formattedDate =
                  DateFormat('dd-MMMM-yyyy').format(selectedDate.value);

              return CustomText('${formattedDate.toString()}');
            }),
            IconButton(
                onPressed: () {
                  controller.pickDate(context);
                },
                icon:
                    Icon(Icons.calendar_month_sharp, color: AppColors.apptheme))
          ]))
    ]);
  }
}
