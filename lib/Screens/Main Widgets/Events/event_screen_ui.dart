// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/event_place_controller.dart';
import 'package:loyadhamsatsang/Controllers/events_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
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
  var EventPlaces = Get.put(EventsPlaceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Photos",
          isBack: false,
        ),
        body: Column(
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
                                int lastIndex = Events
                                    .eventList[index].albumTitle!
                                    .lastIndexOf("");

                                // Extract the title and date parts
                                String title = Events
                                    .eventList[index].albumTitle!
                                    .substring(0, lastIndex);
                                // String date = Events
                                //     .eventList[index].albumTitle!
                                //     .substring(lastIndex + 1);
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => EventsPhotosScreenUI(
                                        name:
                                            Events.eventList[index].albumTitle,
                                        date:Events.eventList[index].album_date_new,
                                        newTitle:Events.eventList[index].album_title_new,
                                        title:
                                            "${Events.eventList[index].albumTitle}"));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.apptheme),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            height: screenHeight(context) * 0.2,
                                            width: screenWidth(context),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            // width: 150,

                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedImageWithShimmer(
                                                imageUrl: Events
                                                    .eventList[index].source!,
                                              ),
                                            )),
                                        SizedBox(height: 10),
                                        CustomText(
                                            Events.eventList[index].album_title_new
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            color: Colors.black,
                                            fontSize: 12),
                                        CustomText(
                                            Events.eventList[index].album_date_new
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            color: Colors.black,
                                            fontSize: 12),
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
    return GetBuilder<EventsPlaceController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            CustomText("Place :"),
            Expanded(
              child: Container(
                  height: 50.0,
                  // width: screenWidth(context),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.apptheme),
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButton<String>(
                      icon: Icon(Icons.arrow_drop_down,
                          color: AppColors.apptheme),
                      style: GoogleFonts.poppins(
                          color: AppColors.apptheme,
                          fontWeight: FontWeight.w600),
                      underline: SizedBox.shrink(),
                      isExpanded: true,
                      value: EventPlaces.eventPlaceItems.isNotEmpty?EventPlaces.eventPlaceItems.first:null,
                      items: EventPlaces.eventPlaceItems
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ))
                          .toList(),
                      onChanged: (item) {
                        Events.selectItem(item!);
                      })),
            ),
          ],
        ),
      );
    },);
  }

  Widget yearSelection() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText("Years :"),
              //SizedBox(height: 10),
              Expanded(
                child: Container(
                    height: 50.0,
                   // width: 290.0,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.apptheme),
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton<String>(
                        icon: Icon(Icons.arrow_drop_down,
                            color: AppColors.apptheme),
                        style: GoogleFonts.poppins(
                            color: AppColors.apptheme,
                            fontWeight: FontWeight.w600),
                        underline: SizedBox.shrink(),
                        isExpanded: true,
                        value: Events.selectedYear.value,
                        items: Events.years
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList(),
                        onChanged: (item) {
                          Events.selectYear(item!);
                        })),
              ),
            ],
          ),
        ));
  }
}
