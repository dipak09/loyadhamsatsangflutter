// ignore_for_file: non_constant_identifier_names, must_be_immutable, unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  void initState() {
    super.initState();
    KirtanKatha.getAudio(widget.type!, widget.kathaMasterId!, widget.singerId!);
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
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.apptheme),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.music_note),
                                title: CustomText(
                                    KirtanKatha
                                        .kirtankathaAudioList[index].fileName
                                        .toString(),
                                    textAlign: TextAlign.start,
                                    // color: Colors.black,
                                    fontSize: 12),
                              ),
                            ),
                          );
                        })
                    : Center(child: CustomText("No Data Found"))),
          )
        ],
      ),
    );
  }
}
