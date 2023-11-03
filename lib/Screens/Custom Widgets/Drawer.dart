// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/About%20Us/aboutus_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Branches/branches_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Feedback%20Screen/feedback_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Prashadi%20Vastu%20Sthan/prashadi_vastu_sthan_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Wellpaper/wallpaper_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:share_plus/share_plus.dart';

import 'CustomText.dart';

class DrawerData extends StatelessWidget {
  const DrawerData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color.fromARGB(255, 230, 230, 230),
                width: screenWidth(context),
                height: 200,
                child: Center(
                  child: Container(
                      height: 125,
                      width: 125,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(81),
                          image: DecorationImage(
                              image: AssetImage(AppImages.drawerImage),
                              fit: BoxFit.fill))),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    _subMenuCard(
                        title: "Wallpapers",
                        onTap: () {
                          Get.back();
                          Get.to(() => WallpaperScreenUI());
                        }),
                    _subMenuCard(
                        title: "Prasadi Vastu / Sthan",
                        onTap: () {
                          Get.back();
                          Get.to(() => PrashadiVastuSthanScreenUI());
                        }),
                    _subMenuCard(title: "Donations", onTap: () {}),
                    _subMenuCard(title: "Our Applications", onTap: () {}),
                    _subMenuCard(title: "Our Guru Parampara", onTap: () {}),
                    _subMenuCard(
                        title: "Our Branches",
                        onTap: () {
                          Get.back();
                          Get.to(() => BranchesScreenUI());
                        }),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 20),
                    _subMenuCard(
                        title: "Share this app",
                        onTap: () async {
                          await Share.share(
                            "Here is your App link : https://play.google.com/store/apps/details?id=com.phoenix.loyadhamsatsang&pcampaignid=web_share",
                            subject: "Share App",
                            // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
                          );
                        }),
                    _subMenuCard(
                        title: "Feedback",
                        onTap: () {
                          Get.back();
                          Get.to(() => FeedBackScreenUI());
                        }),
                    _subMenuCard(title: "Contact us", onTap: () {}),
                    _subMenuCard(
                        title: "About US",
                        onTap: () {
                          Get.back();
                          Get.to(() => AboutUsScreenUI());
                        })
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Image.asset(
                  AppImages.youtube,
                  height: 30,
                  width: 30,
                ),
                Image.asset(
                  AppImages.facebook,
                  height: 30,
                  width: 30,
                ),
                Image.asset(
                  AppImages.insta,
                  height: 30,
                  width: 30,
                ),
                Image.asset(
                  AppImages.whatsapp,
                  height: 30,
                  width: 30,
                ),
                Image.asset(
                  AppImages.spotify,
                  height: 30,
                  width: 30,
                ),
                Image.asset(
                  AppImages.web,
                  height: 30,
                  width: 30,
                )
              ]),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.copyright_outlined,
                    size: 13,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    "Shree Swaminarayan Mandir Loyadham",
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _subMenuCard({String? title, Function()? onTap}) {
    return InkWell(
        onTap: onTap!,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Row(
            children: [
              CustomText(
                title!,
                fontSize: 16,
              ),
            ],
          ),
        ));
  }
}
