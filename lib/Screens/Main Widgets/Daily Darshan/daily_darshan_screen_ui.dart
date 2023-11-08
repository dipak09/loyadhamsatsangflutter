// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/daily_darshan_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:intl/intl.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Daily%20Darshan/daily_darshan_photo_viewer.dart';
import 'package:loyadhamsatsang/globals.dart';

class DailyDarshanScreenUI extends StatefulWidget {
  String? title;
  DateTime? date;
  DailyDarshanScreenUI({this.date, this.title});

  @override
  State<DailyDarshanScreenUI> createState() => _DailyDarshanScreenUIState();
}

class _DailyDarshanScreenUIState extends State<DailyDarshanScreenUI> {
  var DailyDarshan = Get.put(DailyDarshanController());

  @override
  void initState() {
    super.initState();
    DailyDarshan.selectItem(widget.title!);
    DailyDarshan.selectDate(widget.date!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Daily Darshan"),
        body: SingleChildScrollView(
            child: Column(children: [
          titleselection(),
          dateSelection(),
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                  height: 350.0,
                  child: Obx(() => DailyDarshan.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : DailyDarshan.dailyDarshanList.isNotEmpty &&
                              DailyDarshan.dailyDarshanList != null
                          ? Stack(children: [
                              CarouselSlider(
                                  items: DailyDarshan.dailyDarshanList.map((e) {
                                    return Stack(children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => DailyDarshanPhotoViewer(
                                              title: e.title,
                                              darshanList: DailyDarshan
                                                  .dailyDarshanList));
                                        },
                                        child: Container(
                                          height: 335,
                                          width: screenWidth(context),
                                          decoration: BoxDecoration(
                                            color: AppColors.backgroundColor,
                                            border: Border.all(
                                                color: AppColors.apptheme),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            child: CachedImageWithShimmer(
                                              imageUrl: e.source,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.apptheme,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              child: CustomText(
                                                e.title,
                                                color: Colors.white,
                                              )))
                                    ]);
                                  }).toList(),
                                  options: CarouselOptions(
                                      height: 350.0,
                                      viewportFraction: 0.7,
                                      autoPlay:
                                          false, // Set this to true for automatic sliding
                                      enlargeCenterPage: true,
                                      onPageChanged:
                                          DailyDarshan.onPageChanged))
                            ])
                          : Center(child: CustomText("No Images Found")))))
        ])));
  }

  Widget titleselection() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText("Place :"),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                      value: DailyDarshan.selectedTitle.value,
                      items: DailyDarshan.items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (item) {
                        DailyDarshan.selectItem(item!);
                      })),
            ],
          ),
        ));
  }

  Widget dateSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText("Date :"),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.apptheme),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      final selectedDate = DailyDarshan.selectedDate;

                      final formattedDate =
                          DateFormat('dd-MMMM-yyyy').format(selectedDate.value);

                      return CustomText('${formattedDate.toString()}');
                    }),
                    IconButton(
                        onPressed: () {
                          DailyDarshan.pickDate(context);
                        },
                        icon: Icon(Icons.calendar_month_sharp,
                            color: AppColors.apptheme))
                  ])),
        ],
      ),
    );
  }
}
