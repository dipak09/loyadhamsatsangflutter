// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/About%20Us/aboutus_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Branches/branches_screen_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Feedback%20Screen/feedback_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreenUI extends StatefulWidget {
  const SettingScreenUI({super.key});

  @override
  State<SettingScreenUI> createState() => _SettingScreenUIState();
}

class _SettingScreenUIState extends State<SettingScreenUI> {
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
        appBar: CustomAppBar(title: "Settings"),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cards(
                      title: "SHARE THIS APP",
                      onTap: () async {
                        await Share.share(
                          "Here is your App link : https://play.google.com/store/apps/details?id=com.phoenix.loyadhamsatsang&pcampaignid=web_share",
                          subject: "Share App",
                          // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
                        );
                      }),
                  cards(
                      title: "RATE APPLICATION",
                      onTap: () {
                        StoreRedirect.redirect(
                            androidAppId: "com.phoenix.loyadhamsatsang",
                            iOSAppId:
                                "https://apps.apple.com/in/app/loyadham-satsang/id1026670160");
                      }),
                  cards(
                      title: "VISIT OUR WEBSITE",
                      onTap: () {
                        _launchURL('https://loyadham.in/');
                      }),
                  cards(
                      title: "FEEDBACK",
                      onTap: () {
                        Get.to(() => FeedBackScreenUI());
                      }),
                  cards(
                      title: "CONTACT US",
                      onTap: () {
                        Get.to(() => BranchesScreenUI());
                      }),
                  cards(
                      title: "ABOUT US",
                      onTap: () {
                        Get.to(() => AboutUsScreenUI());
                      }),
                ])));
  }

  Widget cards({String? title, Function? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: screenWidth(context),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: AppColors.apptheme,
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                topEnd: Radius.circular(5),
                bottomStart: Radius.circular(5),
                bottomEnd: Radius.circular(20))),
        child: CustomText(
          title!,
          color: Colors.white,
        ),
      ),
    );
  }
}
