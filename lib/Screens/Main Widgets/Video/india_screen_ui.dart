import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/india_channel_controller.dart';
import 'package:loyadhamsatsang/Models/youtubevideo.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/video_screen.dart';
import 'package:loyadhamsatsang/globals.dart';

import 'package:shimmer/shimmer.dart';

class IndiaScreen extends StatefulWidget {
  String type;
  IndiaScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<IndiaScreen> createState() => _IndiaScreenState();
}

class _IndiaScreenState extends State<IndiaScreen> {
  //var videoController = Get.put(VideoController());
  var videoController = Get.put(IndiaChannelController());
  var moreloading = false;
  int pagenumber = 1;
  ScrollController _controller = ScrollController();
  // var moreloading = false;
  Dio dio = Dio();
  void loadmore() async {
    // print("here scroller postion ${_controller.position.extentAfter}");
    if (_controller.position.maxScrollExtent == _controller.position.pixels) {

      setState(() {
        moreloading = true;
      });
      moreloading = true;
      videoController.pageno.value += 1;
      String apiUrl =
          "http://loyadham.in/api/webservice/getYoutubeChannellatest?page=${videoController.pageno.value.toString()}&youtube=${widget.type.isEmpty ? "IN" : widget.type}&pageToken=${apitoken ?? ""}";
      log("IndiaScreenBaseURL${apiUrl}");
      try{
        final response = await dio.get(apiUrl);

        final data = response.data['youtube_video'];

        log("data${data}");
        data.forEach((el) {
          ListYoutubeVideo video = ListYoutubeVideo.fromJson(el);
          videoController.videoList.add(video);
        });

        setState(() {
          moreloading = false;
        });
      }catch(e){
        log("Error loading more data: $e");
        setState(() {
          moreloading = false;
        });
      }
    }
  }


  void _loadData() async {
    try {
      final String apiUrl =
          "http://loyadham.in/api/webservice/getYoutubeChannellatest?page=${videoController.pageno.value.toString()}&youtube=${widget.type.isEmpty ? "IN" : widget.type}&pageToken=${apitoken ?? ""}";
      log("ApiUrl: $apiUrl");

      final response = await dio.get(apiUrl);
      final data = response.data['youtube_video'];

      data.forEach((el) {
        ListYoutubeVideo video = ListYoutubeVideo.fromJson(el);
        videoController.videoList.add(video);
      });

      setState(() {
        moreloading = true; // Set loaded to true after data is loaded for the first time
      });
    } catch (e) {
      log("Error loading data: $e");
    }
  }

  // void _loadData() {
  //   if (!moreloading) {
  //     // Load data only if it hasn't been loaded yet
  //     videoController.get(widget.type == 'US' ? 0 : 1);
  //     moreloading = true; // Set loaded to true after data is loaded for this tab
  //   }
  // }
  //
  // void _loadMore() async {
  //   if (_controller.position.maxScrollExtent == _controller.position.pixels &&
  //       !videoController.isLoading.value) {
  //     videoController.pageno.value++;
  //     await videoController.getData(widget.type, apitoken ?? "", videoController.pageno.value.toString());
  //   }
  // }
  @override
  void initState() {
    _controller = ScrollController()..addListener(loadmore);
    // TODO: implement initState
    super.initState();
    // _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() => videoController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : videoController.videoList.isNotEmpty
              ? GetBuilder<IndiaChannelController>(
            builder: (controller) {
              return ListView.builder(
                  controller: _controller,
                  itemCount: videoController.videoList.length,
                  itemBuilder: (context, index) {
                    log(videoController.videoList.length.toString());
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => VideoScreen(
                          timeAgo:
                          videoController.videoList[index].timeAgo,
                          title: videoController.videoList[index].title,
                          view: videoController
                              .videoList[index].viewCount,
                          publishedDate: videoController
                              .videoList[index].publishedDate,
                          url: videoController
                              .videoList[index].youtubeLink,
                          videoId: videoController
                              .videoList[index].initialId,
                          type: "IN",
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: videoController.videoList[index]
                                    .thumbnail ==
                                    null
                                    ? SizedBox()
                                    : CachedNetworkImage(
                                  imageUrl: videoController
                                      .videoList[index]
                                      .thumbnail!,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                        highlightColor:
                                        Colors.grey[300]!,
                                        baseColor:
                                        Colors.grey[200]!,
                                        child: Container(
                                          color: Colors.white,
                                        ),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.fill,
                                  height:
                                  screenHeight(context) *
                                      0.18,
                                  width: screenWidth(context),
                                )),
                            Container(
                                width: screenWidth(context),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(
                                        179, 221, 218, 218),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft:
                                        Radius.circular(15),
                                        bottomRight:
                                        Radius.circular(15))),
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          videoController.videoList[index]
                                              .title!,
                                          fontSize: 9,
                                          overflow:
                                          TextOverflow.ellipsis),
                                      CustomText(
                                          videoController.videoList[index]
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
                                                    videoController
                                                        .videoList[
                                                    index]
                                                        .timeAgo!,
                                                    fontSize: 9),
                                                CustomText(
                                                    videoController
                                                        .videoList[
                                                    index]
                                                        .viewCount!,
                                                    fontSize: 9)
                                              ]))
                                    ])),
                            const  SizedBox(height: 10),
                            const   Divider(),
                          ],
                        ),
                      ),
                    );
                  });
            },
          )
              : const Center(child: CustomText("No Video Found"))),
        ),
        // ElevatedButton(onPressed: () {}, child: Text("Load More")),
        moreloading ? Container(
            height: kBottomNavigationBarHeight,
            color: Colors.transparent,
            child: Center(
                child: const CircularProgressIndicator()
            )
        ) : const SizedBox.shrink()
      ],
    );
  }
}
