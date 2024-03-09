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
    KirtanKatha.audioPlayer.positionStream.listen((event) {
      if (event.inMilliseconds != 0) {
        var duration = KirtanKatha
            .audioPlayer.duration!.inMilliseconds; //get the duration of audio
        var progress = (event.inMilliseconds / duration) *
            100; // get the current position in percent
        log(progress.toString());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    playallclick = false;
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
  void playAllAudios() {
    // Start playing the first audio
    playNextAudio();
  }

//! Play All song button---------------->
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
        }
      });

      // Move to the next audio after a delay (you can adjust the delay according to your needs)
    } else {
      currentAudioIndex = 0;
      setState(() {});
    }
  }

//! play neext song Button-------------->
  void buttonplayNextAudio() {
    setState(() {
      playallclick = true;
    });

    // Check if there are more audio files in the list
    if (currentAudioIndex < KirtanKatha.kirtankathaAudioList.length - 1) {
      currentAudioIndex++; // Move to the next audio
      // Play the audio here, use your audio player logic
      KirtanKatha.playAudio(
          KirtanKatha.kirtankathaAudioList[currentAudioIndex].uploadAudio!);
    } else {
      // If the current audio is the last one in the list, loop back to the first audio
      currentAudioIndex = 0;
      // Play the first audio
      KirtanKatha.playAudio(
          KirtanKatha.kirtankathaAudioList[currentAudioIndex].uploadAudio!);
    }
  }

  //! Pervious Button for the song play----------->
  void playPreviousAudio() {
    setState(() {
      playallclick = true;
    });

    // Check if there is a previous audio file
    if (currentAudioIndex > 0) {
      currentAudioIndex--; // Move to the previous audio
    } else {
      // If the current audio is the first one in the list, loop back to the last audio
      currentAudioIndex = KirtanKatha.kirtankathaAudioList.length - 1;
    }

    // Play the audio here, use your audio player logic
    KirtanKatha.playAudio(
        KirtanKatha.kirtankathaAudioList[currentAudioIndex].uploadAudio!);
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
                              playallclick = false;
                              //    KirtanKatha.audioPlayer.stop();
                              setState(() {});
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
                              playPreviousAudio();
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
                              buttonplayNextAudio();
                              // KirtanKatha.audioPlayer.previousIndex;
                              // stop();
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
