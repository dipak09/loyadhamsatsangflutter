// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerApp extends StatelessWidget {
  String? id;
  YouTubePlayerApp({this.id});

  @override
  Widget build(BuildContext context) {
    final controller = YoutubePlayerController(
      initialVideoId: id!, // Replace with your video ID
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );

    return YoutubePlayer(
      controller: controller,
    );
  }
}
