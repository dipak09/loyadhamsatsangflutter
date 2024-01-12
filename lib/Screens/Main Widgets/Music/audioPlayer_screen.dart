// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/kirtan&kathaAudio_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Music/audioList_screen_ui.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  String? imgUrl, audioname, audiofile;
  int? index;

  AudioPlayerScreen({
    this.imgUrl,
    this.audioname,
    this.audiofile,
    this.index,
  });
  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final KirtanKathaAudioController audioController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isdownload = false;
    // playallclick = false;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    // audioController.audioPlayer.stop();
  }

  String formatDuration(Duration duration) {
    // Function to format a duration as "mm:ss".
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  bool isdownload = false;
  bool isPlayPause = true;

  void play() {
    setState(() {
      isPlayPause = true;
    });
    audioController.audioPlayer.play();
  }

  void pause() {
    setState(() {
      isPlayPause = false;
    });
    audioController.audioPlayer.pause();
  }

  Future<void> downloadAndSaveAudio(String audioUrl) async {
    Dio dio = Dio();

    try {
      var response = await dio.get(audioUrl,
          options: Options(responseType: ResponseType.bytes));

      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String filePath = '${appDocumentsDirectory.path}/${widget.audioname}.mp3';

      File file = File(filePath);
      await file.writeAsBytes(response.data);
      // File is saved to local storage
      print("Sucessfully Audio is Saved--------------------->");
      print('Audio saved to: $filePath');
      isdownload = true;
      Fluttertoast.showToast(msg: "Song Download Sucessfully!!!");
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: "Please wait for while. Try again later!!");
      print("Error found while downloading------------------->");
      print('Error downloading audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ""),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(alignment: Alignment.topRight, children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.imgUrl!,
                          ),
                          fit: BoxFit.fill))),
              Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 30.0),
                  child: IconButton(
                      onPressed: () {
                        print("Donwload is clicked--------------->");
                        downloadAndSaveAudio(widget.audiofile.toString());
                      },
                      icon: isdownload == true
                          ? Icon(
                              Icons.download_done,
                              color: Colors.white,
                              size: 30.0,
                            )
                          : Icon(
                              Icons.download_for_offline_sharp,
                              color: Colors.white,
                              size: 30.0,
                            )))
            ]),
          ),
          CustomText(widget.audioname!),
          StreamBuilder<Duration?>(
            stream: audioController.audioPlayer.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              return StreamBuilder<Duration>(
                stream: audioController.audioPlayer.positionStream,
                builder: (context, snapshot) {
                  var position = snapshot.data ?? Duration.zero;

                  if (position > duration) {
                    position = duration;
                  }
                  return Column(
                    children: [
                      Slider(
                        value: position.inSeconds.toDouble(),
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          audioController.audioPlayer
                              .seek(Duration(seconds: value.toInt()));
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                "${formatDuration(audioController.audioPlayer.position)}"),
                            CustomText(
                                "${formatDuration(audioController.audioPlayer.duration ?? Duration.zero)}"),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  audioController.audioPlayer.seek(
                      audioController.audioPlayer.position -
                          Duration(seconds: 10));
                },
                child: Icon(Icons.skip_previous),
              ),
              ElevatedButton(
                onPressed: () {
                  isPlayPause ? pause() : play();
                },
                child: isPlayPause ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              ),
              ElevatedButton(
                onPressed: () {
                  audioController.audioPlayer.seek(
                      audioController.audioPlayer.position +
                          Duration(seconds: 10));
                },
                child: Icon(Icons.skip_next),
              ),
            ],
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     audioController.audioPlayer.pause();
          //   },
          //   child: Icon(Icons.pause),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     audioController.audioPlayer.stop();
          //     //   Get.back();
          //   },
          //   child: Icon(Icons.stop),
          // ),
        ],
      ),
    );
  }
}
