import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/clear_notification_controller.dart';
import 'package:loyadhamsatsang/Controllers/get_notification_status_controller.dart';
import 'package:loyadhamsatsang/Controllers/notification_controller.dart';
import 'package:loyadhamsatsang/Controllers/update_notification_status_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class NotificationScreenUI extends StatefulWidget {
  const NotificationScreenUI({super.key});

  @override
  State<NotificationScreenUI> createState() => _NotificationScreenUIState();
}

class _NotificationScreenUIState extends State<NotificationScreenUI> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getNotificationStatus();
    Notificationlist.getDashboardData();
  }

  var Notificationlist = Get.put(NotificationController());
  var clearNotification = Get.put(ClearNotificationController());

  final GetNotificationStatusController controller =
      Get.put(GetNotificationStatusController());
  final UpdateNotificationStatusController updateNotificationStatusController =
      Get.put(UpdateNotificationStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Notification",
          actions: [
            GetBuilder<GetNotificationStatusController>(
              builder: (controller) {
                log("controller.notification.value${controller.notification.value}");
                return controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            if (controller.notification.value == true) {
                              controller.notification.value = false;
                            } else {
                              controller.notification.value = true;
                            }
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            updateNotificationStatusController
                                .updateNotificationStatus(
                                    controller.notification.value);
                          });
                        },
                        child: CustomSwitch(
                          value: controller.notification.value,
                        ),
                      );
              },
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Obx(() => Notificationlist.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Notificationlist.notificationData.isEmpty
                ? Center(
                    child: CustomText(
                      "Data Not Yet!...",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        height: 60,
                        alignment: Alignment.centerRight,
                        width: screenWidth(context),
                        color: Colors.transparent,
                        child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Notifications Cleared'),
                                  content: Text(
                                      'All notifications have been cleared.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        await clearNotification
                                            .postClearAllNotification(
                                                context: context); // Call API
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: CustomText("Clear All")),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: Notificationlist.notificationData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10),
                              child: ListTile(
                                leading: Notificationlist
                                            .notificationData[index].icon ==
                                        null
                                    ? SizedBox()
                                    : Image.network(
                                        Notificationlist
                                            .notificationData[index].icon
                                            .toString(),
                                        scale: 2.0,
                                      ),
                                title: Text(Notificationlist
                                    .notificationData[index].englishMsg
                                    .toString()),
                                subtitle: Text(Notificationlist
                                    .notificationData[index].eventDate
                                    .toString()),
                                trailing: Text(Notificationlist
                                    .notificationData[index].notificationDate
                                    .toString()),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )));
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  static const double _switchWidth = 55.0;
  static const double _switchHeight = 30.0;
  static const double _toggleWidth = 26.0;
  static const double _toggleHeight = 26.0;

  const CustomSwitch({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _switchWidth,
      height: _switchHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_switchHeight / 2),
        color: value ? Colors.blue : Colors.grey,
      ),
      child: Stack(
        children: [
          Positioned(
            left: value ? _switchWidth - _toggleWidth - 2 : 2,
            top: (_switchHeight - _toggleHeight) / 2,
            child: Container(
              width: _toggleWidth,
              height: _toggleHeight,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(_toggleHeight / 2),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  value ? 'On' : 'Off',
                  style: TextStyle(
                    color: value ? Colors.blue : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
