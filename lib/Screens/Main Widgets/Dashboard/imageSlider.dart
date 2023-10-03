import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/globals.dart';

class DashBoardImageSlider extends StatefulWidget {
  const DashBoardImageSlider({super.key});

  @override
  State<DashBoardImageSlider> createState() => _DashBoardImageSliderState();
}

class _DashBoardImageSliderState extends State<DashBoardImageSlider> {
  final List<String> images = [
    AppImages.slider1,
    AppImages.slider3,
    AppImages.slider2,
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

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
              items: images
                  .map(
                    (item) => Image.asset(
                      item,
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

    for (int i = 0; i < images.length; i++) {
      indicators.add(
        Container(
          width: 26.0,
          height: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              color: currentIndex == i
                  ? const Color.fromARGB(255, 10, 91, 157)
                  : Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(3))),
        ),
      );
    }

    return indicators;
  }
}
