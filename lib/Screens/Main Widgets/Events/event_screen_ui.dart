// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Controllers/events_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomScaffold.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Events/event_photo_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';

class EventScreenUI extends StatefulWidget {
  const EventScreenUI({super.key});

  @override
  State<EventScreenUI> createState() => _EventScreenUIState();
}

class _EventScreenUIState extends State<EventScreenUI> {
  var Events = Get.put(EventsController());
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appbar: CustomAppBar(
          isBackButton: false,
          titleImage: AppImages.eventsTitle,
        ),
        children: Column(
          children: [
            titleselection(),
            yearSelection(),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Obx(() => Events.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : Events.eventList.isNotEmpty && Events.eventList != null
                          ? ListView.builder(
                              itemCount: Events.eventList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => EventsPhotosScreenUI(
                                          title: Events
                                              .eventList[index].albumTitle
                                              .toString(),
                                        ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        CustomText(
                                            Events.eventList[index].albumTitle
                                                .toString(),
                                            color: Colors.black,
                                            fontSize: 12),
                                        SizedBox(height: 10),
                                        Container(
                                            height: screenHeight(context) * 0.2,
                                            width: screenWidth(context),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            // width: 150,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(Events
                                                        .eventList[index]
                                                        .source!)))),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Center(child: CustomText("No Data Found")))),
            )
          ],
        ));
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
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Events.items.length,
              itemBuilder: (context, index) {
                return titleCards(Events.items[index]);
              }))
    ]);
  }

  Widget titleCards(String title) {
    return Obx(() => GestureDetector(
        onTap: () {
          Events.selectItem(title);
          //controller.getValue();
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                color: Events.selectedTitle.value == title
                    ? AppColors.apptheme
                    : null,
                border: Border.all(
                    color: Events.selectedTitle.value == title
                        ? Colors.transparent
                        : AppColors.apptheme)),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: CustomText(title,
                fontSize: 10,
                color: Events.selectedTitle.value == title
                    ? Colors.white
                    : Colors.black))));
  }

  Widget yearSelection() {
    return Stack(children: [
      Container(
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(AppImages.dailyDarshanSlider)))),
      Container(
          height: 100,
          padding: EdgeInsets.only(left: 50, right: 40, top: 25, bottom: 25),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Events.years.length,
              itemBuilder: (context, index) {
                return yearCards(Events.years[index]);
              }))
    ]);
  }

  Widget yearCards(String title) {
    return Obx(() => GestureDetector(
          onTap: () {
            Events.selectYear(title);
          },
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  color: Events.selectedYear.value == title
                      ? AppColors.apptheme
                      : null,
                  border: Border.all(
                      color: Events.selectedYear.value == title
                          ? Colors.transparent
                          : AppColors.apptheme)),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: CustomText(title,
                  fontSize: 10,
                  color: Events.selectedYear.value == title
                      ? Colors.white
                      : Colors.black)),
        ));
  }
}
