import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';

class NotificationScreenUI extends StatefulWidget {
  const NotificationScreenUI({super.key});

  @override
  State<NotificationScreenUI> createState() => _NotificationScreenUIState();
}

class _NotificationScreenUIState extends State<NotificationScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification"),
      body: Center(
        child: CustomText("No Notification found"),
      ),
    );
  }
}
