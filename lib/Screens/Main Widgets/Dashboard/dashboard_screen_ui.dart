// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/appbar.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/imageSlider.dart';
import 'package:loyadhamsatsang/globals.dart';

class DashboardScreenUI extends StatefulWidget {
  const DashboardScreenUI({super.key});

  @override
  State<DashboardScreenUI> createState() => _DashboardScreenUIState();
}

class _DashboardScreenUIState extends State<DashboardScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DashboardAppBar(),
        body: Stack(children: [
          Image.asset(
            AppImages.backgroundPic,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          SingleChildScrollView(
            child: Column(children: [
              statusSection(),
              DashBoardImageSlider(),
              dailyNiyamSection(),
              liveStreamSection()
            ]),
          )
        ]));
  }

  Widget statusSection() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomText("Stories",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Open Sans'),
            Row(children: [
              Icon(Icons.arrow_right),
              CustomText("Watch all",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Open Sans')
            ])
          ])),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            statusCircleCard(title: "Satsang", img: AppImages.image1),
            statusCircleCard(title: "Daily Darshan", img: AppImages.image2),
            statusCircleCard(title: "Pu Guruji", img: AppImages.image1),
            statusCircleCard(title: "Upcoming events", img: AppImages.image2),
            statusCircleCard(title: "Daily Darshan", img: AppImages.image1)
          ]))
    ]);
  }

  Widget statusCircleCard({String? title, String? img}) {
    return SizedBox(
        height: screenHeight(context) * 0.13,
        width: screenWidth(context) * 0.24,
        child: Column(children: [
          Container(
              height: 75,
              width: 75,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.statusCircle),
                      fit: BoxFit.fill)),
              child: ClipOval(
                  child: Container(
                      width: 60.0, // Adjust the width and height as needed
                      height: 60.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(img!), fit: BoxFit.fill))))),
          CustomText(title!,
              color: Colors.black,
              fontSize: 10,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w400,
              fontFamily: 'Open Sans')
        ]));
  }

  Widget dailyNiyamSection() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomText("My Daily Niyams",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Open Sans'),
            Row(children: [
              Icon(Icons.arrow_right),
              CustomText("View all",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Open Sans')
            ])
          ])),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            dailyNiyamCard(
                title: "Swaminarayan Dhun", img: AppImages.dailyniyamimg1),
            dailyNiyamCard(title: "Vachanamrut", img: AppImages.dailyniyamimg2),
            dailyNiyamCard(
                title: "Swaminarayan Dhun", img: AppImages.dailyniyamimg1)
          ]))
    ]);
  }

  Widget dailyNiyamCard({String? title, String? img}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
            height: 170,
            width: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.section1bg), fit: BoxFit.fill)),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                    width: 90.0, // Adjust the width and height as needed
                    height: 90.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(img!), fit: BoxFit.fill))),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 60,
                            alignment: Alignment.centerLeft,
                            child: CustomText(title!,
                                fontSize: 8,
                                color: Colors.black,
                                textAlign: TextAlign.start)),
                        Icon(Icons.favorite, color: Colors.grey, size: 15)
                      ]))
            ])));
  }

  Widget liveStreamSection() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomText("Live Streaming",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Open Sans'),
            Row(children: [
              Icon(Icons.arrow_right),
              CustomText("View all",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Open Sans')
            ])
          ])),
      SizedBox(
          height: screenHeight(context) * 0.2,
          child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (contex, index) {
                return Container(
                    height: 125,
                    width: 300,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        image: DecorationImage(
                            image: AssetImage(AppImages.slider2),
                            fit: BoxFit.fill)));
              }))
    ]);
  }
}
