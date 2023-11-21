// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId!,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false, loop: true),
    );

    _controller.addListener(() {
      if (_controller.value.isFullScreen) {
        setState(() {
          isFullScreen = true;
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        });
      } else {
        setState(() {
          isFullScreen = false;
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
        appBar: isFullScreen ? null : AppBar(title: Text('Video Player')),
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                Expanded(
                  child: YoutubePlayer(
                    controller: _controller,
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
                                  CustomText(widget.title!,
                                      fontSize: 9,
                                      overflow: TextOverflow.ellipsis),
                                  CustomText(widget.publishedDate!.toString(),
                                      fontSize: 9,
                                      overflow: TextOverflow.ellipsis),
                                  Container(
                                      width: screenWidth(context),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(widget.timeAgo!,
                                                fontSize: 9),
                                            CustomText(widget.view!,
                                                fontSize: 9)
                                          ]))
                                ])),
                        // Expanded(
                        //   child: ListView.builder(itemBuilder: (context, i) {
                        //     return CustomText("title");
                        //   }),
                        // )
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
