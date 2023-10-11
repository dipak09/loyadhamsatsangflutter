// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appbar;
  final Widget? children;
  // ignore: prefer_const_constructors_in_immutables
  CustomScaffold({this.appbar, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Stack(
        children: [
          Image.asset(AppImages.backgroundPic,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width),
          children!
        ],
      ),
    );
  }
}
