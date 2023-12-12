// ignore_for_file: non_constant_identifier_names, must_be_immutable, unnecessary_null_comparison, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/kirtan&kathaAudio_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Music/audioPlayer_screen.dart';

class AudioListScreenUI extends StatefulWidget {
  String? title, imgUrl, kathaMasterId, singerId, type;
  AudioListScreenUI(
      {super.key,
      this.title,
      this.imgUrl,
      this.kathaMasterId,
      this.singerId,
      this.type});

  @override
  State<AudioListScreenUI> createState() => _AudioListScreenUIState();
}

class _AudioListScreenUIState extends State<AudioListScreenUI> {
  var KirtanKatha = Get.put(KirtanKathaAudioController());
  @override
  void dispose() {
    super.dispose();
    playallclick = false;
    KirtanKatha.audioPlayer.stop();
  }

  @override
  void initState() {
    super.initState();
    KirtanKatha.getAudio(widget.type!, widget.kathaMasterId!, widget.singerId!);
  }

  String formatDuration(Duration duration) {
    // Function to format a duration as "mm:ss".
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  // Define a global index to keep track of the currently playing audio
  int currentAudioIndex = 0;
  bool isPlayPause = true;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool playallclick = false;
// Function to play the audios one after another
  // Future<void> playAll(String audioUrl) async {
  //   if (playallclick == true) {
  //     try {
  //     await _audioPlayer.setUrl(audioUrl);

  //     // Listen for player completion
  //     _audioPlayer.playerStateStream.listen((state) async {
  // if (state.processingState == ProcessingState.completed) {
  //   // Play the next audio
  //   // Implement your logic to get the next URL
  //   // For example:
  //   // final nextUrl = getNextUrl();
  //   // if (nextUrl != null) {
  //   //   await play(nextUrl);
  //   // }
  // }
  //     });

  //     // Start playback
  //     await _audioPlayer.play();
  //   } catch (e) {
  //     // Handle any exceptions
  //     print('Error playing audio: $e');
  //   }
  //   } else {
  //     log("PlayALL is not true yet----------->");
  //   }
  // }
  void playAllAudios() {
    // Start playing the first audio
    playNextAudio();
  }

// Function to play the next audio
  void playNextAudio() {
    setState(() {
      playallclick = true;
    });
    if (currentAudioIndex < KirtanKatha.kirtankathaAudioList.length) {
      // Play the audio here, use your audio player logic
      KirtanKatha.playAudio(
          KirtanKatha.kirtankathaAudioList[currentAudioIndex].uploadAudio!);
      KirtanKatha.audioPlayer.playerStateStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          currentAudioIndex++;
          playNextAudio();
         
          //setState(() {});
          // Play the next audio
          // Implement your logic to get the next URL
          // For example:
          // final nextUrl = getNextUrl();
          // if (nextUrl != null) {
          //   await play(nextUrl);
          // }
        }
      });

      // Move to the next audio after a delay (you can adjust the delay according to your needs)
    }else{
      currentAudioIndex =0;
      setState(() {
        
      });
    }
    // currentAudioIndex = -1;
  }

  void play() {
    setState(() {
      isPlayPause = true;
    });
    KirtanKatha.audioPlayer.play();
  }

  void pause() {
    setState(() {
      isPlayPause = false;
    });
    KirtanKatha.audioPlayer.pause();
  }

  void stop() {
    setState(() {
      isPlayPause = true;
    });
    KirtanKatha.audioPlayer.seekToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.imgUrl!,
                        ),
                        fit: BoxFit.fill))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: TextButton.icon(
                    onPressed: () {
                      playAllAudios();
                      //stop();
                    },
                    icon: Icon(Icons.play_circle),
                    label: CustomText("Play All")),
              )
            ],
          ),
          Expanded(
            child: Obx(() => KirtanKatha.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : KirtanKatha.kirtankathaAudioList.isNotEmpty &&
                        KirtanKatha.kirtankathaAudioList != null
                    ? ListView.builder(
                        itemCount: KirtanKatha.kirtankathaAudioList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              KirtanKatha.playAudio(KirtanKatha
                                  .kirtankathaAudioList[index].uploadAudio!);
                              Get.to(AudioPlayerScreen(
                                imgUrl: widget.imgUrl,
                                audioname: KirtanKatha
                                    .kirtankathaAudioList[index].fileName,
                                audiofile: KirtanKatha
                                    .kirtankathaAudioList[index].uploadAudio,
                                index: index,
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                border: playallclick
                                    ? currentAudioIndex == index
                                        ? Border.all(color: Colors.green)
                                        : Border.all(color: AppColors.apptheme)
                                    : Border.all(color: AppColors.apptheme),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                  leading: playallclick
                                      ? currentAudioIndex == index
                                          ? Icon(
                                              Icons.music_note,
                                              color: Colors.green,
                                            )
                                          : Icon(Icons.music_note)
                                      : Icon(Icons.music_note),
                                  title: playallclick
                                      ? currentAudioIndex == index
                                          ? CustomText(
                                              KirtanKatha
                                                  .kirtankathaAudioList[index]
                                                  .fileName
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              color: Colors.green,
                                              fontSize: 12)
                                          : CustomText(
                                              KirtanKatha
                                                  .kirtankathaAudioList[index]
                                                  .fileName
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              // color: Colors.black,
                                              fontSize: 12)
                                      : CustomText(
                                          KirtanKatha
                                              .kirtankathaAudioList[index]
                                              .fileName
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          // color: Colors.black,
                                          fontSize: 12),
                                  trailing: playallclick
                                      ? currentAudioIndex == index
                                          ? CustomText(
                                              KirtanKatha
                                                  .kirtankathaAudioList[index]
                                                  .audio_duration
                                                  .toString(),
                                              color: Colors.green,
                                            )
                                          : CustomText(KirtanKatha
                                              .kirtankathaAudioList[index]
                                              .audio_duration
                                              .toString())
                                      : CustomText(KirtanKatha
                                          .kirtankathaAudioList[index]
                                          .audio_duration
                                          .toString())),
                            ),
                          );
                        })
                    : Center(child: CustomText("No Data Found"))),
          ),
          playallclick
              ? SizedBox(
                  child: Column(
                    children: [
                      StreamBuilder<Duration?>(
                        stream: KirtanKatha.audioPlayer.durationStream,
                        builder: (context, snapshot) {
                          final duration = snapshot.data ?? Duration.zero;
                          return StreamBuilder<Duration>(
                            stream: KirtanKatha.audioPlayer.positionStream,
                            builder: (context, snapshot) {
                              var position = snapshot.data ?? Duration.zero;
                              if (position > duration) {
                                position = duration;
                              }
                              return Column(
                                children: [
                                  CustomText(KirtanKatha
                                      .kirtankathaAudioList[currentAudioIndex]
                                      .fileName
                                      .toString()),
                                  Slider(
                                    value: position.inSeconds.toDouble(),
                                    min: 0,
                                    max: duration.inSeconds.toDouble(),
                                    onChanged: (value) {
                                      KirtanKatha.audioPlayer.seek(
                                          Duration(seconds: value.toInt()));
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            "${formatDuration(KirtanKatha.audioPlayer.position)}"),
                                        CustomText(
                                            "${formatDuration(KirtanKatha.audioPlayer.duration ?? Duration.zero)}"),
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
                              KirtanKatha.audioPlayer.seek(
                                  KirtanKatha.audioPlayer.position -
                                      Duration(seconds: 10));
                            },
                            child: Icon(Icons.skip_previous),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              isPlayPause ? pause() : play();
                            },
                            child: isPlayPause
                                ? Icon(Icons.pause)
                                : Icon(Icons.play_arrow),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // KirtanKatha.audioPlayer.seek(
                              //     KirtanKatha.audioPlayer.position +
                              //         Duration(seconds: 10));
                              stop();
                            },
                            child: Icon(Icons.skip_next),
                          ),
                        ],
                      ),
                   
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
