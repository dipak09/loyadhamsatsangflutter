// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:loyadhamsatsang/Constants/app_colors.dart';
// import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
// import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
//
// class AudioFile extends StatefulWidget {
//   final List<File> audioFiles;
//   String directoryName;
//
//   AudioFile({required this.audioFiles, required this.directoryName});
//
//   @override
//   _AudioFileState createState() => _AudioFileState();
// }
//
// class _AudioFileState extends State<AudioFile> {
//   late AudioPlayer _audioPlayer;
//   bool isPlaying = false;
//   var currentIndex;
//   bool playallclick = false;
//   bool isPlayPause = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     playallclick = false;
//     //_initAudioPlayer();
//
//     _audioPlayer.playerStateStream.listen((state) {
//       if (state.processingState == ProcessingState.completed) {
//         _playNextSong();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   void _initAudioPlayer() async {
//     try {
//       await _audioPlayer.setFilePath(widget.audioFiles[currentIndex].path);
//       _audioPlayer.playerStateStream.listen((playerState) {
//         if (playerState.playing) {
//           if (mounted) {
//             // Check if the widget is mounted before calling setState
//             setState(() {
//               isPlaying = true;
//             });
//           }
//         } else {
//           if (mounted) {
//             // Check if the widget is mounted before calling setState
//             setState(() {
//               isPlaying = false;
//             });
//           }
//         }
//       });
//     } catch (e) {
//       print("Error initializing audio player: $e");
//     }
//   }
//
//   void play() {
//     setState(() {
//       isPlayPause = true;
//     });
//     _audioPlayer.play();
//   }
//
//   void pause() {
//     setState(() {
//       isPlayPause = false;
//     });
//     _audioPlayer.pause();
//   }
//
//   void stop() {
//     setState(() {
//       isPlayPause = true;
//     });
//     _audioPlayer.seekToNext();
//   }
//
//   void _playNextSong() {
//     int nextIndex = currentIndex + 1;
//     if (nextIndex >= 0 && nextIndex < widget.audioFiles.length) {
//       _audioPlayer.setUrl(widget.audioFiles[nextIndex].path);
//       _audioPlayer.play();
//       setState(() {
//         currentIndex = nextIndex;
//         isPlayPause = true;
//       });
//     }
//   }
//
//   void _playPreviousSong() {
//     int previousIndex = currentIndex - 1;
//     if (previousIndex >= 0 && previousIndex < widget.audioFiles.length) {
//       _audioPlayer.setUrl(widget.audioFiles[previousIndex].path);
//       _audioPlayer.play();
//       setState(() {
//         currentIndex = previousIndex;
//         isPlayPause = true;
//       });
//     }
//   }
//
//   Future<void> shareFile(String filePath) async {
//     try {
//       final file = File(filePath);
//       await Share.shareFiles([file.path], text: 'Check out this audio file!');
//     } catch (e) {
//       print('Error sharing file: $e');
//     }
//   }
//
//   String formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String minutes = twoDigits(duration.inMinutes);
//     String seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$minutes:$seconds";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: widget.directoryName,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.audioFiles.length,
//               itemBuilder: (context, index) {
//                 String fileName = widget.audioFiles[index].path
//                     .split('/')
//                     .last
//                     .replaceAll('.mp3', '');
//                 return Container(
//                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                   decoration: BoxDecoration(
//                     border: currentIndex == index
//                         ? Border.all(color: Colors.green)
//                         : Border.all(color: AppColors.apptheme),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: ListTile(
//                     title: currentIndex == index
//                         ? CustomText(fileName,
//                             textAlign: TextAlign.start,
//                             color: Colors.green,
//                             fontSize: 12)
//                         : CustomText(fileName,
//                             textAlign: TextAlign.start,
//                             // color: Colors.black,
//                             fontSize: 12),
//                     leading: currentIndex == index
//                         ? Icon(
//                             Icons.music_note,
//                             color: Colors.green,
//                           )
//                         : Icon(Icons.music_note),
//                     trailing: IconButton(
//                       icon: Icon(Icons.share,
//                           color: currentIndex == index
//                               ? Colors.green
//                               : Colors.black),
//                       onPressed: () {
//                         shareFile(widget.audioFiles[index].path);
//                       },
//                     ),
//                     onTap: () async {
//                       setState(() {
//                         playallclick = true;
//                         currentIndex = index;
//                         isPlayPause = true;
//                       });
//                       await _audioPlayer
//                           .setFilePath(widget.audioFiles[currentIndex].path);
//                       _audioPlayer.play();
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           playallclick ? _buildPlayerControls() : SizedBox(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPlayerControls() {
//     String fileName = widget.audioFiles[currentIndex].path
//         .split('/')
//         .last
//         .replaceAll('.mp3', '');
//     return Column(
//       children: [
//         StreamBuilder<Duration?>(
//           stream: _audioPlayer.durationStream,
//           builder: (context, snapshot) {
//             final duration = snapshot.data ?? Duration.zero;
//             return StreamBuilder<Duration>(
//               stream: _audioPlayer.positionStream,
//               builder: (context, snapshot) {
//                 var position = snapshot.data ?? Duration.zero;
//                 if (position > duration) {
//                   position = duration;
//                 }
//                 return Column(
//                   children: [
//                     CustomText(fileName),
//                     Slider(
//                       value: position.inSeconds.toDouble(),
//                       min: 0,
//                       max: duration.inSeconds.toDouble(),
//                       onChanged: (value) {
//                         _audioPlayer.seek(Duration(seconds: value.toInt()));
//                       },
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           CustomText(formatDuration(_audioPlayer.position)),
//                           CustomText(formatDuration(
//                               _audioPlayer.duration ?? Duration.zero)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 _playPreviousSong();
//                 // _audioPlayer.seek(
//                 //     _audioPlayer.position - Duration(seconds: 10));
//               },
//               child: Icon(Icons.skip_previous),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 isPlayPause ? pause() : play();
//               },
//               child: isPlayPause ? Icon(Icons.pause) : Icon(Icons.play_arrow),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // KirtanKatha.audioPlayer.seek(
//                 //     KirtanKatha.audioPlayer.position +
//                 //         Duration(seconds: 10));
//                 //stop();
//                 _playNextSong();
//               },
//               child: Icon(Icons.skip_next),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:share_plus/share_plus.dart';

class AudioFile extends StatefulWidget {
  final List<File> audioFiles;
  final String directoryName;

  AudioFile({required this.audioFiles, required this.directoryName});

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  int? currentIndex;
  bool playallclick = false;
  bool isPlayPause = true;
  Timer? _stopAudioTimer;
  // ScreenStateEvent? _previousEvent;
  // Screen _screen = Screen();
  // StreamSubscription<ScreenStateEvent>? _screenStateSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer = AudioPlayer();

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _playNextSong();
      }
    });

    //_initScreenStateListener();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    _stopAudioTimer?.cancel();
    // _screenStateSubscription?.cancel();
    super.dispose();
  }

  // void _initScreenStateListener() {
  //   _screenStateSubscription = _screen.screenStateStream?.listen((event) {
  //     log("event$event");
  //     log("ScreenStateEvent${ScreenStateEvent.SCREEN_OFF}");
  //     if (event == ScreenStateEvent.SCREEN_OFF) {
  //       _startStopAudioTimer();
  //     } else if (event == ScreenStateEvent.SCREEN_ON) {
  //       _stopAudioTimer?.cancel();
  //     }
  //     _previousEvent = event;
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
    if (nextIndex >= 0 && nextIndex < widget.audioFiles.length) {
      _audioPlayer.setUrl(widget.audioFiles[nextIndex].path);
      _audioPlayer.play();
      setState(() {
        currentIndex = nextIndex;
        isPlayPause = true;
      });
    }
  }

  void _playPreviousSong() {
    int previousIndex = currentIndex! - 1;
    if (previousIndex >= 0 && previousIndex < widget.audioFiles.length) {
      _audioPlayer.setUrl(widget.audioFiles[previousIndex].path);
      _audioPlayer.play();
      setState(() {
        currentIndex = previousIndex;
        isPlayPause = true;
      });
    }
  }

  Future<void> shareFile(String filePath) async {
    try {
      final file = File(filePath);
      await Share.shareFiles([file.path], text: 'Check out this audio file!');
    } catch (e) {
      print('Error sharing file: $e');
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
     // _startStopAudioTimer();
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
        title: widget.directoryName,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.audioFiles.length,
              itemBuilder: (context, index) {
                String fileName = widget.audioFiles[index].path.split('/').last.replaceAll('.mp3', '');
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    border: currentIndex == index
                        ? Border.all(color: Colors.green)
                        : Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: currentIndex == index
                        ? Text(fileName, style: TextStyle(color: Colors.green, fontSize: 12))
                        : Text(fileName, style: TextStyle(fontSize: 12)),
                    leading: currentIndex == index
                        ? Icon(Icons.music_note, color: Colors.green)
                        : Icon(Icons.music_note),
                    trailing: IconButton(
                      icon: Icon(Icons.share, color: currentIndex == index ? Colors.green : Colors.black),
                      onPressed: () {
                        shareFile(widget.audioFiles[index].path);
                      },
                    ),
                    onTap: () async {
                      setState(() {
                        playallclick = true;
                        currentIndex = index;
                        isPlayPause = true;
                      });
                      await _audioPlayer.setFilePath(widget.audioFiles[currentIndex!].path);
                      _audioPlayer.play();
                    },
                  ),
                );
              },
            ),
          ),
          playallclick ? _buildPlayerControls() : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildPlayerControls() {
    String fileName = widget.audioFiles[currentIndex!].path.split('/').last.replaceAll('.mp3', '');
    return Column(
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
                          Text(formatDuration(_audioPlayer.position)),
                          Text(formatDuration(
                              _audioPlayer.duration ?? Duration.zero)),
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
              child: isPlayPause ? Icon(Icons.pause) : Icon(Icons.play_arrow),
            ),
            ElevatedButton(
              onPressed: _playNextSong,
              child: Icon(Icons.skip_next),
            ),
          ],
        ),
      ],
    );
  }
}
