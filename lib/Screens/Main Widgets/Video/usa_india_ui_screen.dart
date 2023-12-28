import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/video_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/video_screen.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:shimmer/shimmer.dart';

class USAIndiaScreen extends StatefulWidget {
  String type;
  USAIndiaScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<USAIndiaScreen> createState() => _USAIndiaScreenState();
}

class _USAIndiaScreenState extends State<USAIndiaScreen> {
  @override
  void initState() {
    super.initState();
    // VideoData.videoList.clear();
    // VideoData.getData(widget.type, "");
  }

  var VideoData = Get.put(VideoController());
  var moreloading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() => VideoData.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : VideoData.videoList.isNotEmpty && VideoData.videoList != null
                  ? ListView.builder(
                      //controller: _controller,
                      itemCount: VideoData.videoList.length,
                      itemBuilder: (context, index) {
                        log(VideoData.videoList.length.toString());
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => VideoScreen(
                                  timeAgo: VideoData.videoList[index].timeAgo,
                                  title: VideoData.videoList[index].title,
                                  view: VideoData.videoList[index].viewCount,
                                  publishedDate:
                                     VideoData.videoList[index].publishedDate,
                                  url: VideoData.videoList[index].youtubeLink,
                                  videoId: VideoData.videoList[index].initialId,
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
                                    child: VideoData.videoList[index].thumbnail ==
                                            null
                                        ? SizedBox()
                                        : CachedNetworkImage(
                                            imageUrl: VideoData.videoList[index].thumbnail!,
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              highlightColor: Colors.grey[300]!,
                                              baseColor: Colors.grey[200]!,
                                              child: Container(
                                                color: Colors.white,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.fill,
                                            height:
                                                screenHeight(context) * 0.18,
                                            width: screenWidth(context),
                                          )),
                                Container(
                                    width: screenWidth(context),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(179, 221, 218, 218),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            VideoData.videoList[index].title!,
                                              fontSize: 9,
                                              overflow: TextOverflow.ellipsis),
                                          CustomText(
                                             VideoData.videoList[index].publishedDate!
                                                  .toString(),
                                              fontSize: 9,
                                              overflow: TextOverflow.ellipsis),
                                          Container(
                                              width: screenWidth(context),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      VideoData.videoList[index].timeAgo!,
                                                        fontSize: 9),
                                                    CustomText(
                                                       VideoData.videoList[index].viewCount!,
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
        ),
        moreloading ? CircularProgressIndicator() : SizedBox.shrink()
      ],
    );
  }
}
