// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/dashboard_controller.dart';
import 'package:loyadhamsatsang/globals.dart';

class DashBoardImageSlider extends StatefulWidget {
  const DashBoardImageSlider({super.key});

  @override
  State<DashBoardImageSlider> createState() => _DashBoardImageSliderState();
}

class _DashBoardImageSliderState extends State<DashBoardImageSlider> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  var Home = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print(currentIndex);
          },
          child: SizedBox(
            height: screenHeight(context) * 0.2,
            width: screenWidth(context),
            child: CarouselSlider(
              items: Home.sliderList
                  .map(
                    (item) => Image.network(
                      item.image!,
                    ),
                  )
                  .toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 2,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildIndicators(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];

    for (int i = 0; i < Home.sliderList.length; i++) {
      indicators.add(
        Container(
          width: 26.0,
          height: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              color: currentIndex == i
                  ? Color.fromARGB(255, 10, 91, 157)
                  : Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(3))),
        ),
      );
    }

    return indicators;
  }
}
