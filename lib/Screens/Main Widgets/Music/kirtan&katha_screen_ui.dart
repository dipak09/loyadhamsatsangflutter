// ignore_for_file: must_be_immutable, unnecessary_null_comparison, prefer_const_constructors

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/kirtan&katha_controller.dart';
import 'package:loyadhamsatsang/Controllers/singerlist_controller.dart';
import 'package:loyadhamsatsang/Models/KirtanKatha.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';

import 'package:loyadhamsatsang/Screens/Main%20Widgets/Music/audioList_screen_ui.dart';
import 'package:path_provider/path_provider.dart';

class KirtanKathaScreenUI extends StatefulWidget {
  String? type;
  KirtanKathaScreenUI({super.key, this.type});

  @override
  State<KirtanKathaScreenUI> createState() => _KirtanKathaScreenUIState();
}

class _KirtanKathaScreenUIState extends State<KirtanKathaScreenUI> {
  var KirtanKatha = Get.put(KirtanKathaController());
  var SingerList = Get.put(SingerListController());
  int selectedChipIndex = 0;
  //List<String> singerListWithAll = ['All', ...?SingerList.singerList?.map((singer) => singer.name)?.toList()];

  @override
  void initState() {
    super.initState();
    KirtanKatha.getData(widget.type!, "All");
    SingerList.getData();
  }

  @override
  Widget build(BuildContext context) {
    List<String> singerListWithAll = [
      'All',
      ...SingerList.singerList
          .where((singer) => singer.type == "Kirtan")
          .map((singer) => singer.name ?? '')
    ];
    List<String> singerListWithKatha = [
      'All',
      ...SingerList.singerList
          .where((singer) => singer.type == "Katha")
          .map((singer) => singer.name ?? '')
    ];
    return Column(
      children: [
        // ChoiceChip(label: label, selected: selected)
        Expanded(
          // flex: 0,
          // child: Obx(() => KirtanKatha.isLoading.value
          //     ? SizedBox()
          //     : KirtanKatha.kirtankathaList.isNotEmpty &&
          //             KirtanKatha.kirtankathaList != null
          //         ?
          child:
              // print(widget.type);
              ListView.builder(
                  itemCount: widget.type == "katha"
                      ? singerListWithKatha.length
                      : singerListWithAll.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ChoiceChip(
                          onSelected: (value) {
                            if (widget.type == 'katha') {
                              setState(() {
                                selectedChipIndex = value ? index : -1;
                                KirtanKatha.getData(widget.type!,
                                    "${singerListWithKatha[index]}");
                              });
                            } else {
                              setState(() {
                                selectedChipIndex = value ? index : -1;
                                KirtanKatha.getData(widget.type!,
                                    "${singerListWithAll[index]}");
                              });
                            }
                          },
                          label: widget.type == "katha"
                              ? Text(singerListWithKatha[index])
                              : Text(singerListWithAll[index]),
                          selected: selectedChipIndex == index),
                    );
                  }
                  // },
                  ),

          // : Center(child: CustomText("")))
        ),
        Expanded(
          flex: 7,
          child: Obx(() => KirtanKatha.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : KirtanKatha.kirtankathaList.isNotEmpty &&
                      KirtanKatha.kirtankathaList != null
                  ? ListView.builder(
                      itemCount: KirtanKatha.kirtankathaList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => AudioListScreenUI(
                                  type: widget.type,
                                  title: KirtanKatha
                                      .kirtankathaList[index].eventName
                                      .toString(),
                                  imgUrl: KirtanKatha
                                      .kirtankathaList[index].uploadFile!,
                                  kathaMasterId: KirtanKatha
                                      .kirtankathaList[index].kathaMasterId!,
                                  singerId: KirtanKatha
                                      .kirtankathaList[index].singerId!,
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
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(KirtanKatha
                                              .kirtankathaList[index]
                                              .uploadFile!))),
                                ),
                                title: CustomText(
                                    KirtanKatha.kirtankathaList[index].eventName
                                        .toString(),
                                    textAlign: TextAlign.start,
                                    // color: Colors.black,
                                    fontSize: 12),
                                trailing: InkWell(
                                    onTap: () {
                                      downloadAndSaveAudio(
                                          KirtanKatha.kirtankathaList[index]
                                              .trackList!,
                                          KirtanKatha
                                              .kirtankathaList[index].eventName
                                              .toString());
                                    },
                                    child: Icon(Icons.download))),
                          ),
                        );
                      })
                  : Center(child: CustomText("No Data Found"))),
        ),
      ],
    );
  }

  Future<void> downloadAndSaveAudio(
      List<TrackList> audioUrls, String audioname) async {
    Dio dio = Dio();

    for (var audioUrl in audioUrls) {
      try {
        var response = await dio.get(audioUrl.uploadAudio.toString(),
            options: Options(responseType: ResponseType.bytes));

        Directory appDocumentsDirectory =
            await getApplicationDocumentsDirectory();
        String filename = extractFilename(audioUrl.uploadAudio.toString());
        String filePath =
            '${appDocumentsDirectory.path}/${filename}_${DateTime.now().millisecondsSinceEpoch}.mp3';

        File file = File(filePath);
        await file.writeAsBytes(response.data);

        // File is saved to local storage
        print("Successfully Audio is Saved--------------------->");
        print('Audio saved to: $filePath');
        Fluttertoast.showToast(msg: "Song Download Successfully!!!");
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Please wait for a while. Try again later!!");
        print("Error found while downloading------------------->" +
            audioUrl.toString());
        print('Error downloading audio: $e');
      }
    }
  }

  String extractFilename(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;
    List<String> parts = path.split('/');
    String filenameWithExtension = parts.last;
    List<String> filenameParts = filenameWithExtension.split('.');
    String filename =
        filenameParts.sublist(1).join('.'); // Exclude the first part (number)
    return filename;
  }
}
