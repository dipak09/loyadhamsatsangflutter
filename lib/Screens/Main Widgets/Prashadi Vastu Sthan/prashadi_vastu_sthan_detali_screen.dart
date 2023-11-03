// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class PrashadiDetailScreen extends StatefulWidget {
  String? title, imageUrl, name, description;
  PrashadiDetailScreen(
      {super.key, this.title, this.imageUrl, this.name, this.description});

  @override
  State<PrashadiDetailScreen> createState() => _PrashadiDetailScreenState();
}

class _PrashadiDetailScreenState extends State<PrashadiDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Prashadi ${widget.title}",
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 20),
          CustomText(
            widget.name!,
            fontSize: 16,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedImageWithShimmer(
                  imageUrl: widget.imageUrl!,
                  height: screenHeight(context) * 0.3,
                  width: screenWidth(context))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomText(
              widget.description!,
              fontSize: 14,
              textAlign: TextAlign.start,
              color: Colors.black,
            ),
          ),
        ]),
      ),
    );
  }
}
