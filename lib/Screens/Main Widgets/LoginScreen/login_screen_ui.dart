// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Dashboard/dashboard_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';

class LoginScreenUI extends StatefulWidget {
  const LoginScreenUI({super.key});

  @override
  State<LoginScreenUI> createState() => _LoginScreenUIState();
}

class _LoginScreenUIState extends State<LoginScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        AppImages.backgroundImage,
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            SizedBox(height: screenHeight(context) * 0.1),
            title(),
            SizedBox(height: screenHeight(context) * 0.07),
            email_textfeild(),
            password_textfeild(),
            button(),
            SizedBox(height: screenHeight(context) * 0.06),
            CustomText("Don't have an account?",
                fontWeight: FontWeight.bold, fontFamily: 'Open Sans'),
            CustomText("Create an Account", fontFamily: 'Open Sans')
          ]))
    ]));
  }

  Widget title() {
    return CustomText("Loyadham \n Satsang",
        fontSize: 45,
        textAlign: TextAlign.center,
        color: AppColors.apptheme,
        fontFamily: 'Black Chancery');
  }

  Widget email_textfeild() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: CustomText("Email", color: AppColors.headingTextColor)),
      Stack(children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: screenHeight(context) * 0.15,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage(AppImages.textLine),
                    fit: BoxFit.cover))),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.transparent,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none)))
      ])
    ]);
  }

  Widget password_textfeild() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: CustomText("Password", color: AppColors.headingTextColor)),
      SizedBox(
          height: screenHeight(context) * 0.15,
          child: Stack(children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: screenHeight(context) * 0.15,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(AppImages.textLine),
                        fit: BoxFit.cover))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.transparent),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: InputBorder.none))),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 30, right: 50),
                    child: CustomText("Forgot Password?",
                        color: AppColors.headingTextColor)))
          ]))
    ]);
  }

  Widget button() {
    return GestureDetector(
        onTap: () {
          Get.off(() => DashboardScreenUI());
        },
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
                color: AppColors.apptheme,
                borderRadius: BorderRadius.circular(10)),
            child: CustomText("Log In", color: Colors.white)));
  }
}
