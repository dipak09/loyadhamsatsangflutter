// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/video_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/video_screen.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:shimmer/shimmer.dart';

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
                                    timeAgo: Video.videoList[index].timeAgo,
                                    title: Video.videoList[index].title,
                                    view: Video.videoList[index].viewCount,
                                    publishedDate:
                                        Video.videoList[index].publishedDate,
                                    url: Video.videoList[index].youtubeLink,
                                    videoId: Video.videoList[index].initialId,
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            Video.videoList[index].thumbnail!,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          highlightColor: Colors.grey[300]!,
                                          baseColor: Colors.grey[200]!,
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.fill,
                                        height: screenHeight(context) * 0.18,
                                        width: screenWidth(context),
                                      )),
                                  Container(
                                      width: screenWidth(context),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              179, 221, 218, 218),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                                Video.videoList[index].title!,
                                                fontSize: 9,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            CustomText(
                                                Video.videoList[index]
                                                    .publishedDate!
                                                    .toString(),
                                                fontSize: 9,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            Container(
                                                width: screenWidth(context),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                          Video.videoList[index]
                                                              .timeAgo!,
                                                          fontSize: 9),
                                                      CustomText(
                                                          Video.videoList[index]
                                                              .viewCount!,
                                                          fontSize: 9)
                                                    ]))
                                          ])),
                                  SizedBox(height: 10),
                                  Divider(),
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
