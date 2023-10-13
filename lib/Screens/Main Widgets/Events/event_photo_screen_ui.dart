// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/events_Images_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomScaffold.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EventsPhotosScreenUI extends StatefulWidget {
  String? title;
  EventsPhotosScreenUI({super.key, this.title});

  @override
  State<EventsPhotosScreenUI> createState() => _EventsPhotosScreenUIState();
}

class _EventsPhotosScreenUIState extends State<EventsPhotosScreenUI> {
  var Events = Get.put(EventsImagesController());

  @override
  void initState() {
    super.initState();
    Events.getImages(widget.title!);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: Events.isLoading.value,
          color: Colors.white,
          opacity: 0.9,
          progressIndicator: Center(child: CircularProgressIndicator()),
          child: CustomScaffold(
              appbar: CustomAppBar(
                  isTitle: false,
                  title: CustomText(
                    widget.title.toString(),
                    fontSize: 13,
                  )),
              children: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4.0),
                  scrollDirection: Axis.vertical,
                  itemCount: Events.imageList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    var data = Events.imageList[index];
                    return GestureDetector(
                        onTap: () {
                          Get.dialog(Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: screenWidth(context) * 0.9,
                                    height: screenHeight(context) * 0.4,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        image: DecorationImage(
                                            image: NetworkImage(data.source!),
                                            fit: BoxFit.fill),
                                        border: Border.all(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                              ],
                            ),
                          ));
                        },
                        child: Container(
                            width: screenWidth(context) * 0.32,
                            height: screenHeight(context) * 0.2,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                image: DecorationImage(
                                    image: NetworkImage(data.source!),
                                    fit: BoxFit.fill),
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))));
                  })),
        ));
  }
}
