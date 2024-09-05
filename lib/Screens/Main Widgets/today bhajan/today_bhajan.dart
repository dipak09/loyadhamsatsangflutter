// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class TodayBhajan extends StatefulWidget {
  String? description;
  String? title;
  String? date;

  TodayBhajan({super.key, required this.description, this.title, this.date});

  @override
  State<TodayBhajan> createState() => _TodayBhajanState();
}

class _TodayBhajanState extends State<TodayBhajan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Today's Bhajan"),
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              CustomText(widget.title.toString(), fontSize: 16),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Html(data: widget.description.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
