// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/santMandal_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class SantMandalScreenUI extends StatefulWidget {
  const SantMandalScreenUI({super.key});

  @override
  State<SantMandalScreenUI> createState() => _SantMandalScreenUIState();
}

class _SantMandalScreenUIState extends State<SantMandalScreenUI> {
  var SantMandal = Get.put(SantMandalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Sant Mandal"),
      body: Obx(() => SantMandal.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : SantMandal.santMandalList.isNotEmpty &&
                  SantMandal.santMandalList != null
              ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(4.0),
                  scrollDirection: Axis.vertical,
                  itemCount: SantMandal.santMandalList.length,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2, childAspectRatio: 0.8),
                  itemBuilder: (BuildContext context, int index) {
                    var data = SantMandal.santMandalList[index];
                    // final DateFormat formatter = DateFormat('EEEE, d MMMM y');

                    return GestureDetector(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.apptheme),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(data.saintName.toString(),
                                      textAlign: TextAlign.center,
                                      color: Colors.black,
                                      fontSize: 12),
                                  SizedBox(height: 10),
                                  Row(children: [
                                    Container(
                                      height: screenHeight(context) * 0.2,
                                      width: screenWidth(context) * 0.35,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedImageWithShimmer(
                                            imageUrl: data.photopath!),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText("Date Of Birth",
                                                  fontSize: 10),
                                              CustomText(data.dateOfBirth!,
                                                  fontSize: 8),
                                              SizedBox(height: 10),
                                              CustomText("Parshad Diksha Date",
                                                  fontSize: 10),
                                              CustomText(
                                                  data.dateOfParshadDiksha ??
                                                      "",
                                                  fontSize: 8),
                                              SizedBox(height: 10),
                                              CustomText("Bhagvati Diksha Date",
                                                  fontSize: 10),
                                              CustomText(
                                                  data.dateOfBhagvatiDiksha ??
                                                      "",
                                                  fontSize: 8)
                                            ]))
                                  ])
                                ])));
                  })
              : Center(child: CustomText("No Data Found"))),
    );
  }
}
