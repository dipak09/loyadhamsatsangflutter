// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/About%20Us/aboutus_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Branches/branches_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Contact_Us/contact_us_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Feedback%20Screen/feedback_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Prashadi%20Vastu%20Sthan/prashadi_vastu_sthan_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Wellpaper/wallpaper_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CustomText.dart';

class DrawerData extends StatelessWidget {
  const DrawerData({super.key});
  _launchURL(String openURL) async {
    // ignore: deprecated_member_use
    if (await canLaunch(openURL)) {
      // ignore: deprecated_member_use
      await launch(openURL);
    } else {
      throw 'Could not launch $openURL';
    }
  }

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
                    _subMenuCard(
                        title: "Contact us",
                        onTap: () {
                          Get.back();
                          Get.to(() => ContactUSScreenUI());
                        }),
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
                InkWell(
                  onTap: () {
                    _launchURL("https://www.youtube.com/user/MaconMandal");
                  },
                  child: Image.asset(
                    AppImages.youtube,
                    height: 30,
                    width: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL("https://www.facebook.com/loyadhammandir/");
                  },
                  child: Image.asset(
                    AppImages.facebook,
                    height: 30,
                    width: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL("https://www.instagram.com/loyadhammandir/");
                  },
                  child: Image.asset(
                    AppImages.insta,
                    height: 30,
                    width: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL(
                        "https://api.whatsapp.com/send?phone=918758026000&text=Jay%20Swaminarayan,%20Name:%20___________City:%20_____________Country%20:%20___________");
                  },
                  child: Image.asset(
                    AppImages.whatsapp,
                    height: 30,
                    width: 30,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    AppImages.spotify,
                    height: 30,
                    width: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL("https://loyadham.in/");
                  },
                  child: Image.asset(
                    AppImages.web,
                    height: 30,
                    width: 30,
                  ),
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
