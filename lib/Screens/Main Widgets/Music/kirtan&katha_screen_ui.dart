// ignore_for_file: must_be_immutable, unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/kirtan&katha_controller.dart';
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
  @override
  void initState() {
    super.initState();
    KirtanKatha.getData(widget.type!);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                              singerId:
                                  KirtanKatha.kirtankathaList[index].singerId!,
                            ));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                                        .kirtankathaList[index].uploadFile!))),
                          ),
                          title: CustomText(
                              KirtanKatha.kirtankathaList[index].eventName
                                  .toString(),
                              textAlign: TextAlign.start,
                              // color: Colors.black,
                              fontSize: 12),
                        ),
                      ),
                    );
                  })
              : Center(child: CustomText("No Data Found"))),
    );
  }
}
