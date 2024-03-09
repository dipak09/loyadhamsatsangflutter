import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/notification_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Notification"),
        body: Obx(() => Notificationlist.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: Notificationlist.livestreamchannel.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(
                      Notificationlist.livestreamchannel[index].icon.toString(),
                      scale: 2.0,
                    ),
                    title: Text(Notificationlist
                        .livestreamchannel[index].englishMsg
                        .toString()),
                    subtitle: Text(Notificationlist
                        .livestreamchannel[index].eventDate
                        .toString()),
                    trailing: Text(Notificationlist
                        .livestreamchannel[index].notificationDate
                        .toString()),
                  );
                },
              )));
  }
}
