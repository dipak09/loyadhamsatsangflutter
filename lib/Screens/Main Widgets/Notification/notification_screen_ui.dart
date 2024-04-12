import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/clear_notification_controller.dart';
import 'package:loyadhamsatsang/Controllers/notification_controller.dart';
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
    Notificationlist.getDashboardData();
  }

  var Notificationlist = Get.put(NotificationController());
  var clearNotification = Get.put(ClearNotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Notification"),
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
                      child: TextButton(onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Notifications Cleared'),
                            content: Text('All notifications have been cleared.'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await clearNotification.postClearAllNotification(context: context); // Call API
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }, child: CustomText("Clear All")),
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
                              margin:
                                  EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                              child: ListTile(
                                leading: Notificationlist
                                            .notificationData[index].icon ==
                                        null
                                    ? SizedBox()
                                    : Image.network(
                                        Notificationlist.notificationData[index].icon
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
