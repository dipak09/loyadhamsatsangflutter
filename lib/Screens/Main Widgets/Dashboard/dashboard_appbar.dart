

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/search_bar.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Notification/notification_screen_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DashboardAppBar extends StatefulWidget   implements PreferredSizeWidget {
  final Function()? drawerOnTap;
  final GlobalKey<ScaffoldState>? drawer;
  DashboardAppBar({this.drawerOnTap, this.drawer});
  @override
  State<StatefulWidget> createState() => _DashboardAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  // downloadFile() async {
  Future<void> downloadVideoAsMp3(String videoUrl) async {
    try {
      var yt = YoutubeExplode();
      var videoId = VideoId(videoUrl);

      // Fetching video manifest
      var manifest = await yt.videos.streamsClient.getManifest(videoId);

      // Finding the highest bitrate audio stream
      var audioStreamInfo = manifest.audioOnly.withHighestBitrate();

      // Getting the audio stream
      var audioStream = yt.videos.streamsClient.get(audioStreamInfo);

      // Getting the directory to save the file
      var directory = await getExternalStorageDirectory();
      if (directory == null) {
        throw FileSystemException('Unable to get external storage directory.');
      }
      var savePath = '${directory.path}/${videoId.value}.mp3';

      // Opening the file for writing
      var file = File(savePath);
      var fileStream = file.openWrite();

      // Downloading the audio stream and writing it to the file
      await audioStream.pipe(fileStream);

      // Closing the file stream
      await fileStream.flush();
      await fileStream.close();

      // Enqueuing the downloaded file for FlutterDownloader
      await FlutterDownloader.enqueue(
        url: 'file://${file.path}',
        savedDir: directory.path,
        fileName: '${videoId.value}.mp3',
        showNotification: true,
        openFileFromNotification: true,
      );

      yt.close();
    } catch (e) {
      // Error handling
      print('Failed to download video: $e');
      // You can show an error message to the user or handle the error in any other appropriate way
    }
  }

  bool downloading = false;
  var progressString = "";
  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      print("path ${dir.path}");
      await dio.download("https://youtu.be/JU54W9H8Qk8", "${dir.path}/demo.mp4",
          onReceiveProgress: (rec, total) {
            print("Rec: $rec , Total: $total");

            setState(() {
              downloading = true;
              progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
            });
          });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        forceMaterialTransparency: true,
        elevation: 10,
        leading: IconButton(
            onPressed: () {
              widget.drawer!.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu, color: Colors.white)),
        title: CustomText("Loyadham Satsang",
            fontSize: 15,
            textAlign: TextAlign.center,
            color: Colors.white,
            fontWeight: FontWeight.w700),
        actions: [
          InkWell(
            onTap: () async {
              // await downloadVideoAsMp3('https://youtu.be/JU54W9H8Qk8');
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Downloading MP3...'),
              // ));
              //Get.to(() => NotificationScreenUI());

              await downloadFile();
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(AppImages.appBarNotificationPic,
                    height: 20, width: 20)),
          ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (_) => SearchAppBar()));
          //   },
          //   child: Padding(
          //       padding: const EdgeInsets.only(right: 20),
          //       child: Image.asset(AppImages.appBarSearchPic,
          //           height: 20, width: 20)),
          // )
        ],
        flexibleSpace: Container(color: AppColors.apptheme));
  }
}
