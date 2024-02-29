// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:loyadhamsatsang/Constants/app_colors.dart';
// import 'package:loyadhamsatsang/Controllers/feedback_controller.dart';
// import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
// import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
// import 'package:loyadhamsatsang/globals.dart';

// class FeedBackScreenUI extends StatefulWidget {
//   const FeedBackScreenUI({super.key});

//   @override
//   State<FeedBackScreenUI> createState() => _FeedBackScreenUIState();
// }

// class _FeedBackScreenUIState extends State<FeedBackScreenUI> {
//   var Feedback = Get.put(FeedbackController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(title: "Feedback"),
//         body: SingleChildScrollView(
//             child: Column(children: [
//           textFeild(
//               title: "Name",
//               hintText: "Enter your name",
//               controller: Feedback.nameController),
//           textFeild(
//               title: "Email",
//               hintText: "Enter your email",
//               controller: Feedback.emailidController),
//           textFeild(
//               title: "State",
//               hintText: "Enter your state",
//               controller: Feedback.stateController),
//           textFeild(
//               title: "City",
//               hintText: "Enter your city",
//               controller: Feedback.cityController),
//           textFeild(
//               title: "Your Message",
//               maxLength: 10,
//               hintText: "Enter your message",
//               controller: Feedback.msgController),
//           InkWell(
//             onTap: Feedback.sendFeedback,
//             child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10),
//                 alignment: Alignment.center,
//                 width: screenWidth(context),
//                 decoration: BoxDecoration(
//                     color: AppColors.apptheme,
//                     borderRadius: BorderRadius.circular(15)),
//                 padding: EdgeInsets.symmetric(vertical: 20),
//                 child: CustomText("Send", color: Colors.white)),
//           ),
//           SizedBox(height: 20)
//         ])));
//   }

//   textFeild(
//       {String? title,
//       String? hintText,
//       int? maxLength,
//       TextEditingController? controller}) {
//     return Container(
//         padding: EdgeInsets.all(10),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           CustomText(title!),
//           SizedBox(height: 10),
//           TextFormField(
//               controller: controller,
//               maxLines: maxLength,
//               decoration: InputDecoration(
//                   hintText: hintText,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: AppColors.apptheme))))
//         ]));
//   }
// }
