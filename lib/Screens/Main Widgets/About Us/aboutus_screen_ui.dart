// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/aboutus_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class AboutUsScreenUI extends StatefulWidget {
  const AboutUsScreenUI({super.key});

  @override
  State<AboutUsScreenUI> createState() => _AboutUsScreenUIState();
}

class _AboutUsScreenUIState extends State<AboutUsScreenUI> {
  var AboutUs = Get.put(AboutUSController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "About US"),
        body: Column(children: [
          titleselection(),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Obx(() => AboutUs.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : AboutUs.list.isNotEmpty && AboutUs.list != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(4.0),
                              scrollDirection: Axis.vertical,
                              itemCount: AboutUs.list.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = AboutUs.list[index];

                                return Column(children: [
                                  CustomText(data.title!,
                                      textAlign: TextAlign.center),
                                  SizedBox(height: 10),
                                  Container(
                                    height: screenHeight(context) * 0.4,
                                    width: screenWidth(context),
                                    margin: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedImageWithShimmer(
                                          imageUrl: data.uploadFile!),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: CustomText(data.description!,
                                          fontSize: 10, color: Colors.black))
                                ]);
                              })
                          : Center(child: CustomText("No Data Found")))))
        ]));
  }

  Widget titleselection() {
    return Obx(() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.apptheme),
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButton<String>(
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.apptheme),
                  style: GoogleFonts.poppins(
                      color: AppColors.apptheme, fontWeight: FontWeight.w600),
                  underline: SizedBox.shrink(),
                  isExpanded: true,
                  value: AboutUs.selectedTitle.value,
                  items: AboutUs.items
                      .map((item) => DropdownMenuItem<String>(
                          value: item, child: Text(item)))
                      .toList(),
                  onChanged: (item) {
                    AboutUs.selectItem(item!);
                  }))
        ])));
  }
}
