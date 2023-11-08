// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/prashadi_vastu_sthan_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Prashadi%20Vastu%20Sthan/prashadi_vastu_sthan_detali_screen.dart';
import 'package:loyadhamsatsang/globals.dart';

class PrashadiSthanScreen extends StatefulWidget {
  const PrashadiSthanScreen({super.key});

  @override
  State<PrashadiSthanScreen> createState() => _PrashadiSthanScreenState();
}

class _PrashadiSthanScreenState extends State<PrashadiSthanScreen> {
  var Prashadi = Get.put(PrashadiVastuSthanController());
  void initState() {
    super.initState();
    setState(() {
      Prashadi.getData("item");
    });
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
                            crossAxisCount: 2, childAspectRatio: 0.7),
                        itemBuilder: (BuildContext context, int index) {
                          var data = Prashadi.prashadiList[index];
                          return GestureDetector(
                              onTap: () {
                                Get.to(() => PrashadiDetailScreen(
                                      title: "Sthan",
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
                                          width: screenWidth(context) * 0.5)),
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
