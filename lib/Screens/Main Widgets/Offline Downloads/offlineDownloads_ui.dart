import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:path_provider/path_provider.dart';

class AudioListScreen extends StatefulWidget {
  @override
  _AudioListScreenState createState() => _AudioListScreenState();
}

class _AudioListScreenState extends State<AudioListScreen> {
  late Directory _appDirectory;
  List<File> _audioFiles = [];
  

  @override
  void initState() {
    super.initState();
    _loadAudioFiles();
  }

  Future<void> _loadAudioFiles() async {
    _appDirectory = await getApplicationDocumentsDirectory();
    setState(() {
      print(_appDirectory);
      _audioFiles = _getAudioFiles(_appDirectory);
    });
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
      body: _audioFiles.isEmpty
          ? Center(child: CustomText("Please Download the Audio!!"))
          : ListView.builder(
              itemCount: _audioFiles.length,
              itemBuilder: (context, index) {
                String fileName = _audioFiles[index].path.split('/').last;
                fileName = fileName.replaceAll('.mp3', '');
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.apptheme),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        // image: DecorationImage(
                        //     fit: BoxFit.fill,
                        //     image: NetworkImage(KirtanKatha
                        //         .kirtankathaList[index].uploadFile!))
                      ),
                    ),
                    title: CustomText(fileName,
                        textAlign: TextAlign.start,
                        // color: Colors.black,
                        fontSize: 12),
                  ),
                );
              },
            ),
    );
  }
}
