// ignore_for_file: must_be_immutable, unnecessary_null_comparison, prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/videoID_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  String? url, videoId, title, view, publishedDate, timeAgo;

  VideoScreen(
      {super.key,
      this.url,
      this.videoId,
      this.title,
      this.view,
      this.publishedDate,
      this.timeAgo});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  bool isFullScreen = false;
  var VideoIDWise = Get.put(VideoIDWiseController());
  void playNewVideo(String videoId) {
    _controller.load(videoId);
    _controller.play();
  }

  @override
  void initState() {
    super.initState();
    VideoIDWise.assignData(
        agoTime: widget.timeAgo,
        videoTitle: widget.title,
        videoView: widget.view,
        videopublishedDate: widget.publishedDate,
        videourl: widget.url,
        videovideoId: widget.videoId);

    VideoIDWise.getData(widget.videoId!);
    _controller = YoutubePlayerController(
      initialVideoId: VideoIDWise.videoId.value,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false, loop: true),
    );

    _controller.addListener(() {
      if (_controller.value.isFullScreen) {
        setState(() {
          isFullScreen = true;
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        });
      } else {
        setState(() {
          isFullScreen = false;
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isFullScreen) {
          _controller.toggleFullScreenMode();
          return false; // Prevent system back navigation
        } else {
          return true; // Allow system back navigation
        }
      },
      child: Scaffold(
        appBar: isFullScreen ? null : CustomAppBar(title: 'Video Player'),
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                Expanded(
                  child: YoutubePlayer(
                    controller: _controller,
                  //  aspectRatio: 16 / 4,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    onReady: () {},
                  ),
                ),
                if (!isFullScreen)
                  Container(
                    height: screenHeight(context) * 0.7,
                    child: Column(
                      children: [
                        Container(
                            width: screenWidth(context),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(179, 221, 218, 218),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(VideoIDWise.title.value,
                                      fontSize: 9,
                                      overflow: TextOverflow.ellipsis),
                                  CustomText(
                                      VideoIDWise.publishedDate.toString(),
                                      fontSize: 9,
                                      overflow: TextOverflow.ellipsis),
                                  Container(
                                      width: screenWidth(context),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                VideoIDWise.timeAgo.value,
                                                fontSize: 9),
                                            CustomText(VideoIDWise.view.value,
                                                fontSize: 9)
                                          ]))
                                ])),
                        Expanded(
                          child: Obx(() => VideoIDWise.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : VideoIDWise.videoList.isNotEmpty &&
                                      VideoIDWise.videoList != null
                                  ? ListView.builder(
                                      // controller: _controller,
                                      itemCount: VideoIDWise.videoList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            playNewVideo(VideoIDWise
                                                .videoList[index].initialId!);
                                            VideoIDWise.assignData(
                                                agoTime: VideoIDWise
                                                    .videoList[index].timeAgo,
                                                videoTitle: VideoIDWise
                                                    .videoList[index].title,
                                                videoView: VideoIDWise
                                                    .videoList[index].viewCount,
                                                videopublishedDate: VideoIDWise
                                                    .videoList[index]
                                                    .publishedDate,
                                                videourl: VideoIDWise
                                                    .videoList[index]
                                                    .youtubeLink,
                                                videovideoId: VideoIDWise
                                                    .videoList[index]
                                                    .initialId);
                                            VideoIDWise.getData(VideoIDWise
                                                .videoList[index].initialId!);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15)),
                                                    child: CachedNetworkImage(
                                                      imageUrl: VideoIDWise
                                                          .videoList[index]
                                                          .thumbnail!,
                                                      placeholder: (context,
                                                              url) =>
                                                          Shimmer.fromColors(
                                                        highlightColor:
                                                            Colors.grey[300]!,
                                                        baseColor:
                                                            Colors.grey[200]!,
                                                        child: Container(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      fit: BoxFit.fill,
                                                      height: screenHeight(
                                                              context) *
                                                          0.18,
                                                      width:
                                                          screenWidth(context),
                                                    )),
                                                Container(
                                                    width: screenWidth(context),
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            179, 221, 218, 218),
                                                        borderRadius: BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15))),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomText(
                                                              VideoIDWise
                                                                  .videoList[
                                                                      index]
                                                                  .title!,
                                                              fontSize: 9,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                          CustomText(
                                                              VideoIDWise
                                                                  .videoList[
                                                                      index]
                                                                  .publishedDate!
                                                                  .toString(),
                                                              fontSize: 9,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                          Container(
                                                              width:
                                                                  screenWidth(
                                                                      context),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    CustomText(
                                                                        VideoIDWise
                                                                            .videoList[
                                                                                index]
                                                                            .timeAgo!,
                                                                        fontSize:
                                                                            9),
                                                                    CustomText(
                                                                        VideoIDWise
                                                                            .videoList[
                                                                                index]
                                                                            .viewCount!,
                                                                        fontSize:
                                                                            9)
                                                                  ]))
                                                        ])),
                                                SizedBox(height: 10),
                                                Divider(),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: CustomText("No Video Found"))),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class FullScreenButton extends StatelessWidget {
  final bool isFullScreen;
  final VoidCallback onFullScrenToggle;

  FullScreenButton(
      {required this.isFullScreen, required this.onFullScrenToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
      onPressed: onFullScrenToggle,
    );
  }
}
