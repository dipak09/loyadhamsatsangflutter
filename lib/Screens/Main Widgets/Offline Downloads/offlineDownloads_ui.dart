import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Offline%20Downloads/audio_file.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class AudioDirectory {
  final String directoryName;
  final List<File> audioFiles;

  AudioDirectory({required this.directoryName, required this.audioFiles});
}

class OfflineScreen extends StatefulWidget {
  @override
  _OfflineScreenState createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen>
    with WidgetsBindingObserver {
  late Directory _appDirectory;
  List<AudioDirectory> _audioDirectories = [];
  List<File> _otherFiles = [];
  var currentIndex;
  bool playAllClick = false;
  bool isPlayPause = true;
  late AudioPlayer _audioPlayer;
  Timer? _stopAudioTimer;

  // ScreenStateEvent? _previousEvent;
  // Screen _screen = Screen();
  // StreamSubscription<ScreenStateEvent>? _screenStateSubscription;

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadAudioFiles();
    _audioPlayer = AudioPlayer();
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _playNextSong();
      }
    });
    //_initScreenStateListener();
  }

  Future<void> _loadAudioFiles() async {
    _appDirectory = await getApplicationDocumentsDirectory();
    List<Directory> audioDirectories = _getAudioDirectories(_appDirectory);

    List<AudioDirectory> directories = [];
    for (var directory in audioDirectories) {
      String dirName = directory.path.split('/').last;
      List<File> files = _getAudioFiles(directory);
      if (files.isNotEmpty) {
        if (dirName == 'OTHERS') {
          _otherFiles.addAll(files);
        } else {
          directories
              .add(AudioDirectory(directoryName: dirName, audioFiles: files));
        }
      }
    }

    setState(() {
      _audioDirectories = directories;
    });
  }

  List<Directory> _getAudioDirectories(Directory dir) {
    List<Directory> directories = [];
    dir
        .listSync(recursive: false, followLinks: false)
        .forEach((FileSystemEntity entity) {
      if (entity is Directory) {
        directories.add(entity);
      }
    });
    return directories;
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

  Future<void> shareFile(String filePath) async {
    try {
      final file = File(filePath);
      await Share.shareFiles([file.path], text: 'Check out this audio file!');
    } catch (e) {
      print('Error sharing file: $e');
    }
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

  void _playNextSong() {
    int nextIndex = currentIndex! + 1;
    if (nextIndex >= 0 && nextIndex < _otherFiles.length) {
      _audioPlayer.setUrl(_otherFiles[nextIndex].path);
      _audioPlayer.play();
      setState(() {
        currentIndex = nextIndex;
        isPlayPause = true;
      });
    }
  }

  void _playPreviousSong() {
    int previousIndex = currentIndex! - 1;
    if (previousIndex >= 0 && previousIndex < _otherFiles.length) {
      _audioPlayer.setUrl(_otherFiles[previousIndex].path);
      _audioPlayer.play();
      setState(() {
        currentIndex = previousIndex;
        isPlayPause = true;
      });
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Widget _buildPlayerControls() {
    String fileName =
        _otherFiles[currentIndex!].path.split('/').last.replaceAll('.mp3', '');
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        height: 160,
        child: Column(
          children: [
            StreamBuilder<Duration?>(
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
                        Text(fileName),
                        Slider(
                          value: position.inSeconds.toDouble(),
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          onChanged: (value) {
                            _audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(formatDuration(position)),
                              Text(formatDuration(duration)),
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
                  onPressed: _playPreviousSong,
                  child: Icon(Icons.skip_previous),
                ),
                ElevatedButton(
                  onPressed: isPlayPause ? pause : play,
                  child:
                      isPlayPause ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                ),
                ElevatedButton(
                  onPressed: _playNextSong,
                  child: Icon(Icons.skip_next),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // void _initScreenStateListener() {
  //   _screenStateSubscription = _screen.screenStateStream?.listen((event) {
  //     log("event$event");
  //     log("ScreenStateEvent${ScreenStateEvent.SCREEN_OFF}");
  //     if (event == ScreenStateEvent.SCREEN_UNLOCKED) {
  //       _startStopAudioTimer();
  //     } else if (event == ScreenStateEvent.SCREEN_ON) {
  //       _stopAudioTimer?.cancel();
  //     }
  //     _previousEvent = event;
  //   });
  // }

  // void _startStopAudioTimer1() {
  //   _stopAudioTimer?.cancel();
  //   _stopAudioTimer = Timer(const Duration(seconds: 20), () {
  //     if (_previousEvent == ScreenStateEvent.SCREEN_OFF) {
  //       _audioPlayer.pause();
  //       setState(() {
  //         isPlayPause = false;
  //       });
  //     }
  //   });
  // }
  void _startStopAudioTimer() async {
    _stopAudioTimer?.cancel();
    _stopAudioTimer = Timer(const Duration(minutes: 3), () async {
      _audioPlayer.pause();
      setState(() {
        isPlayPause = false;
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      //_startStopAudioTimer();
      print('app inactive, is lock screen:');
    } else if (state == AppLifecycleState.resumed) {
      print('app resumed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'OFFLINE DOWNLOADS',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _audioDirectories.isEmpty
                    ? Container(
                        height: screenHeight(context,dividedBy: 1.2),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Text("Please Download the Audio!!"),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _audioDirectories.length,
                            itemBuilder: (context, directoryIndex) {
                              AudioDirectory audioDirectory =
                                  _audioDirectories[directoryIndex];
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 1.0)),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return AudioFile(
                                          audioFiles: audioDirectory.audioFiles,
                                          directoryName:
                                              audioDirectory.directoryName,
                                        );
                                      },
                                    ));
                                    setState(() {
                                      currentIndex = -1;
                                      playAllClick = false;
                                      _audioPlayer.stop();
                                    });
                                  },
                                  title:
                                      CustomText(audioDirectory.directoryName),
                                  trailing: Icon(Icons.arrow_forward_ios,
                                      color: AppColors.apptheme),
                                  leading: Icon(
                                    Icons.queue_music,
                                    color: AppColors.apptheme,
                                  ),
                                ),
                              );
                            },
                          ),
                          _otherFiles.isNotEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        itemCount: _otherFiles.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          String fileName = _otherFiles[index]
                                              .path
                                              .split('/')
                                              .last
                                              .replaceAll('.mp3', '');
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            decoration: BoxDecoration(
                                              border: currentIndex == index
                                                  ? Border.all(
                                                      color: Colors.green)
                                                  : Border.all(
                                                      color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: ListTile(
                                              title: currentIndex == index
                                                  ? Text(fileName,
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 12))
                                                  : Text(fileName,
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                              leading: currentIndex == index
                                                  ? Icon(Icons.music_note,
                                                      color: Colors.green)
                                                  : Icon(Icons.music_note),
                                              trailing: IconButton(
                                                icon: Icon(Icons.share,
                                                    color: currentIndex == index
                                                        ? Colors.green
                                                        : Colors.black),
                                                onPressed: () {
                                                  shareFile(
                                                      _otherFiles[index].path);
                                                },
                                              ),
                                              onTap: () async {
                                                setState(() {
                                                  playAllClick = true;
                                                  currentIndex = index;
                                                  isPlayPause = true;
                                                });
                                                await _audioPlayer.setFilePath(
                                                    _otherFiles[currentIndex!]
                                                        .path);
                                                _audioPlayer.play();
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
              ],
            ),
          ),
          playAllClick ? _buildPlayerControls() : SizedBox(),
        ],
      ),
    );
  }
}
