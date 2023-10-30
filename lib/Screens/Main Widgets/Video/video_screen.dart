// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/player.dart';
import 'package:loyadhamsatsang/globals.dart';

class VideoScreen extends StatefulWidget {
  String? url, videoId;
  VideoScreen({super.key, this.url, this.videoId});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: "",
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight(context),
            width: screenWidth(context),
            child: YouTubePlayerApp(
              id: widget.videoId,
            ),
          ),
        ],
      ),
    );
  }
}
