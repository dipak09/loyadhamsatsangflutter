// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/prashadi_vastu_sthan_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

import 'prashadi_vastu_sthan_detali_screen.dart';

class PrashadiVastuScreen extends StatefulWidget {
  const PrashadiVastuScreen({super.key});

  @override
  State<PrashadiVastuScreen> createState() => _PrashadiVastuScreenState();
}

class _PrashadiVastuScreenState extends State<PrashadiVastuScreen> {
  var Prashadi = Get.put(PrashadiVastuSthanController());
  void initState() {
    super.initState();
    Prashadi.getData("place");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Prashadi.isLoading.value
            ? Expanded(child: Center(child: CircularProgressIndicator()))
            : Prashadi.prashadiList.isNotEmpty && Prashadi.prashadiList != null
                ? Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(4.0),
                        scrollDirection: Axis.vertical,
                        itemCount: Prashadi.prashadiList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.8),
                        itemBuilder: (BuildContext context, int index) {
                          var data = Prashadi.prashadiList[index];
                          return GestureDetector(
                              onTap: () {
                                Get.to(() => PrashadiDetailScreen(
                                      title: "Vastu",
                                      imageUrl: data.uploadFile,
                                      name: data.title,
                                      description: data.description,
                                    ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedImageWithShimmer(
                                        imageUrl: data.uploadFile!,
                                        height: screenHeight(context) * 0.2,
                                        width: screenWidth(context) * 0.5),
                                  ),
                                  CustomText(
                                    data.title!,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ));
                        }),
                  )
                : Center(child: CustomText("No Images Found"))),
      ],
    );
  }
}
