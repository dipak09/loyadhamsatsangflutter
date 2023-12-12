import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/kirtan&kathaAudio_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:path_provider/path_provider.dart';

class OfflineScreen extends StatefulWidget {
  @override
  _OfflineScreenState createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  // var KirtanKatha = Get.put(KirtanKathaAudioController());
  bool playallclick = false;
  var currentindex;
  @override
  void dispose() {
    super.dispose();
    playallclick = false;
    // KirtanKatha.audioPlayer.stop();
  }

  @override
  void initState() {
    super.initState();
    _loadAudioFiles();
    // KirtanKatha.getAudio(widget.type!, widget.kathaMasterId!, widget.singerId!);
  }

  late Directory _appDirectory;
  List<File> _audioFiles = [];
  bool isPlayPause = true;
  final AudioPlayer _audioPlayer = AudioPlayer();

  // @override
  // void initState() {
  //   super.initState();
  //   _loadAudioFiles();
  // }
  String formatDuration(Duration duration) {
    // Function to format a duration as "mm:ss".
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> _loadAudioFiles() async {
    _appDirectory = await getApplicationDocumentsDirectory();
    setState(() {
      log("--------------------->" + _appDirectory.toString());
      _audioFiles = _getAudioFiles(_appDirectory);
    });
  }

  void play() {
    setState(() {
      isPlayPause = true;
    });
    _audioPlayer.play();
  }

  void pause() {
    setState(() {
      isPlayPause = false;
    });
    _audioPlayer.pause();
  }

  void stop() {
    setState(() {
      isPlayPause = true;
    });
    _audioPlayer.seekToNext();
  }

  List<File> _getAudioFiles(Directory dir) {
    List<File> files = [];
    dir
        .listSync(recursive: false, followLinks: false)
        .forEach((FileSystemEntity entity) {
      if (entity is File && entity.path.endsWith('.mp3')) {
        files.add(entity);
      }
    });
    return files;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "OFFLINE DOWNLOADS"),
        body: Column(
          children: [
            _audioFiles.isEmpty
                ? Center(child: CustomText("Please Download the Audio!!"))
                : Expanded(
                    child: ListView.builder(
                      itemCount: _audioFiles.length,
                      itemBuilder: (context, index) {
                        String fileName =
                            _audioFiles[index].path.split('/').last;
                        fileName = fileName.replaceAll('.mp3', '');
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                            border: currentindex == index
                                ? Border.all(color: Colors.green)
                                : Border.all(color: AppColors.apptheme),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            onTap: () {
                              _audioPlayer.setUrl(_audioFiles[index].path);

                              _audioPlayer.play();
                              setState(() {
                                playallclick = true;
                                currentindex = index;
                                isPlayPause = true;
                              });
                            },
                            leading: currentindex == index
                                ? Icon(
                                    Icons.music_note,
                                    color: Colors.green,
                                  )
                                : Icon(Icons.music_note),
                            title: currentindex == index
                                ? CustomText(fileName,
                                    textAlign: TextAlign.start,
                                    color: Colors.green,
                                    fontSize: 12)
                                : CustomText(fileName,
                                    textAlign: TextAlign.start,
                                    // color: Colors.black,
                                    fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
            playallclick
                ? StreamBuilder<Duration?>(
                    stream: _audioPlayer.durationStream,
                    builder: (context, snapshot) {
                      final duration = snapshot.data ?? Duration.zero;
                      return StreamBuilder<Duration>(
                        stream: _audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          var position = snapshot.data ?? Duration.zero;
                          if (position > duration) {
                            position = duration;
                          }
                          return Column(
                            children: [
                              // CustomText(KirtanKatha
                              //     .kirtankathaAudioList[index]
                              //     .fileName
                              //     .toString()),
                              Slider(
                                value: position.inSeconds.toDouble(),
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  _audioPlayer
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        "${formatDuration(_audioPlayer.position)}"),
                                    CustomText(
                                        "${formatDuration(_audioPlayer.duration ?? Duration.zero)}"),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                : SizedBox(),
            playallclick
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _audioPlayer.seek(
                              _audioPlayer.position - Duration(seconds: 10));
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
                  )
                : SizedBox()
          ],
        ));
  }
}
