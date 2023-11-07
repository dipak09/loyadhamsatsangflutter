import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/contactus_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class ContactUSScreenUI extends StatefulWidget {
  const ContactUSScreenUI({super.key});

  @override
  State<ContactUSScreenUI> createState() => _ContactUSScreenUIState();
}

class _ContactUSScreenUIState extends State<ContactUSScreenUI> {
  var ContactUS = Get.put(ContactUSController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Contact Us"),
        body: SingleChildScrollView(
            child: Column(children: [
          textFeild(
              title: "Name",
              hintText: "Enter your name",
              controller: ContactUS.nameController),
          textFeild(
              title: "Email",
              hintText: "Enter your email",
              controller: ContactUS.emailidController),
          textFeild(
              title: "Your Message",
              maxLength: 10,
              hintText: "Enter your message",
              controller: ContactUS.msgController),
          InkWell(
            onTap: ContactUS.sendFeedback,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                width: screenWidth(context),
                decoration: BoxDecoration(
                    color: AppColors.apptheme,
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CustomText("Send", color: Colors.white)),
          ),
          SizedBox(height: 20)
        ])));
  }

  textFeild(
      {String? title,
      String? hintText,
      int? maxLength,
      TextEditingController? controller}) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomText(title!),
          SizedBox(height: 10),
          TextFormField(
              controller: controller,
              maxLines: maxLength,
              decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.apptheme))))
        ]));
  }
}
