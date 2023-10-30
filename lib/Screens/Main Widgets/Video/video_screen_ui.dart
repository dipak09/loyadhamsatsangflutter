// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/video_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/video_screen.dart';
import 'package:loyadhamsatsang/globals.dart';

class VideoScreenUI extends StatefulWidget {
  const VideoScreenUI({super.key});

  @override
  State<VideoScreenUI> createState() => _VideoScreenUIState();
}

class _VideoScreenUIState extends State<VideoScreenUI> {
  var Video = Get.put(VideoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Videos", isBack: false),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => Video.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Video.videoList.isNotEmpty && Video.videoList != null
                    ? ListView.builder(
                        itemCount: Video.videoList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => VideoScreen(
                                    url: Video.videoList[index].youtubeLink,
                                    videoId: Video.videoList[index].initialId,
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                children: [
                                  Container(
                                    height: screenHeight(context) * 0.2,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        border: Border.all(
                                            color: AppColors.apptheme),
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(Video
                                                .videoList[index].thumbnail!))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                      Video.videoList[index].title!,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(child: CustomText("No Video Found"))),
          )
        ],
      ),
    );
  }
}
