import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/kirtan&kathaAudio_controller.dart';
import 'package:loyadhamsatsang/Models/KirtanKathAudio.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:wakelock/wakelock.dart';
import 'package:path_provider/path_provider.dart';

class KirtanPlayerScreen extends StatefulWidget {
  String? imgUrl, audioname, audiofile;
  int? index;
  List<KirtanKathaAudio> kirtankathaAudioList;

  KirtanPlayerScreen({
    this.imgUrl,
    this.audioname,
    this.audiofile,
    this.index,
    required this.kirtankathaAudioList,
  });

  @override
  State<KirtanPlayerScreen> createState() => _KirtanPlayerScreenState();
}

class _KirtanPlayerScreenState extends State<KirtanPlayerScreen> {
  final KirtanKathaAudioController audioController =
  Get.put(KirtanKathaAudioController());
  bool isdownload = false;
  bool isPlayPause = true;
  late Timer _stopTimer;
  bool _isPhoneLocked = false;

  @override
  void initState() {
    super.initState();
    startWakeLock();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    stopWakeLockAndAudio();
    _stopTimer.cancel();
  }

  void startWakeLock() {
    Wakelock.enable();
  }

  void stopWakeLockAndAudio() {
    Wakelock.disable();
    audioController.audioPlayer.stop();
  }


  void startTimer() {
    _stopTimer = Timer(Duration(seconds: 10), stopWakeLockAndAudio);
  }

  Future<void> downloadAndSaveAudio(String audioUrl) async {
    print("Audio is $audioUrl--------------------->");
    Dio dio = Dio();

    try {
      var response = await dio.get(audioUrl,
          options: Options(responseType: ResponseType.bytes));

      Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory();
      String filePath =
          '${appDocumentsDirectory.path}/${widget.audioname}.mp3';

      File file = File(filePath);
      await file.writeAsBytes(response.data);
      // File is saved to local storage
      print("Sucessfully Audio is Saved--------------------->");
      print('Audio saved to: $filePath');
      isdownload = true;
      Fluttertoast.showToast(msg: "Song Download Sucessfully!!!");
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Please wait for while. Try again later!!");
      print("Error found while downloading------------------->");
      print('Error downloading audio: $e');
    }
  }

  void playNextSong() {
    // Get the index of the current song
    int currentIndex = widget.index ?? 0;

    // Check if there is a next song in the list
    if (currentIndex < widget.kirtankathaAudioList.length - 1) {
      // Increment the index to play the next song
      int nextIndex = currentIndex + 1;

      // Retrieve the URL of the next song
      String nextSongUrl = audioController
          .kirtankathaAudioList[nextIndex].uploadAudio!;

      // Play the next song
      audioController.audioPlayer.setUrl(nextSongUrl).then((_) {
        setState(() {
          // Update the index to the next song
          widget.index = nextIndex;
          // Start playing the next song
          audioController.audioPlayer.play();
          // Set the play/pause state
          isPlayPause = true;
        });
      });
    }
  }

  void playPreviousSong() {
    // Get the index of the current song
    int currentIndex = widget.index ?? 0;

    // Check if there is a previous song in the list
    if (currentIndex > 0) {
      // Decrement the index to play the previous song
      int previousIndex = currentIndex - 1;

      // Retrieve the URL of the previous song
      String previousSongUrl = audioController
          .kirtankathaAudioList[previousIndex].uploadAudio!;

      // Play the previous song
      audioController.audioPlayer.setUrl(previousSongUrl).then((_) {
        setState(() {
          // Update the index to the previous song
          widget.index = previousIndex;
          // Start playing the previous song
          audioController.audioPlayer.play();
          // Set the play/pause state
          isPlayPause = true;
        });
      });
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
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(widget.imgUrl!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 30.0),
                  child: IconButton(
                    onPressed: () {
                      print("Download is clicked--------------->");
                      downloadAndSaveAudio(audioController
                          .kirtankathaAudioList[widget.index!].uploadAudio
                          .toString());
                      // Implement download functionality here
                    },
                    icon: isdownload
                        ? Icon(
                      Icons.download_done,
                      color: Colors.white,
                      size: 30.0,
                    )
                        : Icon(
                      Icons.download_for_offline_sharp,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomText(audioController.kirtankathaAudioList[widget.index!]
              .fileName
              .toString()),
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
                              "${formatDuration(audioController.audioPlayer.position)}",
                            ),
                            CustomText(
                              "${formatDuration(audioController.audioPlayer.duration ?? Duration.zero)}",
                            ),
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
                  playPreviousSong();
                  // Seek 10 seconds backward
                  // audioController.audioPlayer.seek(
                  //   audioController.audioPlayer.position -
                  //       Duration(seconds: 10),
                  // );
                },
                child: Icon(Icons.skip_previous),
              ),
              ElevatedButton(
                onPressed: () {
                  // Toggle play/pause
                  isPlayPause ? pause() : play();
                },
                child: isPlayPause
                    ? Icon(Icons.pause)
                    : Icon(Icons.play_arrow),
              ),
              ElevatedButton(
                onPressed: () {
                  playNextSong();
                  // Seek 10 seconds forward
                  // audioController.audioPlayer.seek(
                  //   audioController.audioPlayer.position +
                  //       Duration(seconds: 10),
                  // );
                },
                child: Icon(Icons.skip_next),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    // Function to format a duration as "mm:ss".
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

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
}

