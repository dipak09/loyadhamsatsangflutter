import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/dashboard_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CatchImage.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardImageSlider extends StatefulWidget {
  const DashBoardImageSlider({super.key});

  @override
  State<DashBoardImageSlider> createState() => _DashBoardImageSliderState();
}

class _DashBoardImageSliderState extends State<DashBoardImageSlider> {
  _launchURL(String openURL) async {
    // ignore: deprecated_member_use
    if (await canLaunch(openURL)) {
      // ignore: deprecated_member_use
      await launch(openURL);
    } else {
      throw 'Could not launch $openURL';
    }
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  var Home = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.22,
      width: screenWidth(context),
      child: CarouselSlider(
        items: Home.sliderList
            .map(
              (item) => InkWell(
                onTap: () {
                  _launchURL(item.routename!);
                },
                child: Container(
                  height: screenHeight(context) * 0.22,
                  width: screenWidth(context),
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedImageWithShimmer(imageUrl: item.image!),
                  ),
                ),
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
