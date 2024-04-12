import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loyadhamsatsang/Controllers/get_notification_status_controller.dart';
import 'package:loyadhamsatsang/Controllers/update_notification_status_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/globals.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GetNotificationStatusController controller = Get.put(GetNotificationStatusController());
  final UpdateNotificationStatusController updateNotificationStatusController = Get.put(UpdateNotificationStatusController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getNotificationStatus();
  }
  // Variable to track notification state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Settings"),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      ListTile(
                        title: Text("Notifications"),
                        trailing: Switch(
                          value: controller.notification.value,
                          onChanged: (value) {
                            setState(() {
                              controller.notification.value = value; // Update notification state
                            });
                            Future.delayed(Duration(seconds: 1), () {
                             updateNotificationStatusController.updateNotificationStatus(value);
                            });
                          },
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
        ));
  }
}
