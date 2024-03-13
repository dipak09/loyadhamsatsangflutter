import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';

class TodayBhajan extends StatefulWidget {
  String? description;
  String? title;

  TodayBhajan({super.key, required this.description, this.title});

  @override
  State<TodayBhajan> createState() => _TodayBhajanState();
}

class _TodayBhajanState extends State<TodayBhajan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Bhajan"),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CustomText(widget.title.toString()),
              SizedBox(
                height: 20,
              ),
              CustomText(
                widget.description.toString(),
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
