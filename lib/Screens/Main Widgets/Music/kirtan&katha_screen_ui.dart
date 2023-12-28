// ignore_for_file: must_be_immutable, unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/kirtan&katha_controller.dart';
import 'package:loyadhamsatsang/Controllers/singerlist_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';

import 'package:loyadhamsatsang/Screens/Main%20Widgets/Music/audioList_screen_ui.dart';

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
      ...SingerList.singerList.map((singer) => singer.name ?? '')
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
            child: ListView.builder(
          itemCount: singerListWithAll.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ChoiceChip(
                  onSelected: (value) {
                    //  print(value);
                    setState(() {
                      selectedChipIndex = value ? index : -1;
                      KirtanKatha.getData(
                          widget.type!, "${singerListWithAll[index]}");
                    });
                  },
                  label: Text(singerListWithAll[index]),
                  selected: selectedChipIndex == index),
            );
          },
        )
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
                              trailing: CustomText(KirtanKatha
                                  .kirtankathaList[index].album_total_duration
                                  .toString()),
                            ),
                          ),
                        );
                      })
                  : Center(child: CustomText("No Data Found"))),
        ),
      ],
    );
  }
}
