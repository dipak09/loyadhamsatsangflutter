// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/branches_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:url_launcher/url_launcher.dart';

class BranchesScreenUI extends StatefulWidget {
  const BranchesScreenUI({super.key});

  @override
  State<BranchesScreenUI> createState() => _BranchesScreenUIState();
}

class _BranchesScreenUIState extends State<BranchesScreenUI> {
  var Branches = Get.put(BranchesController());
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
    return Obx(() => ModalProgressHUD(
        inAsyncCall: Branches.isLoading.value,
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: Scaffold(
            appBar: CustomAppBar(
              title: "Our Branches",
            ),
            body: ListView.builder(
                itemCount: Branches.branchesList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        CustomText(Branches.branchesList[index].name!,
                            color: Colors.black, fontSize: 12),
                        SizedBox(
                          height: 10,
                        ),
                        // Image.network(Branches.branchesList[index].uploadFile!),
                        Container(
                            height: screenHeight(context) * 0.2,
                            width: screenWidth(context),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            // width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(Branches
                                        .branchesList[index].uploadFile!)))),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _launchURL(
                                      'tel:${Branches.branchesList[index].mobileNumber!}');
                                },
                                child: Row(children: [
                                  Icon(Icons.phone, size: 15),
                                  SizedBox(width: 5),
                                  CustomText(
                                      Branches
                                          .branchesList[index].mobileNumber!,
                                      color: Colors.black,
                                      fontSize: 10)
                                ]),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  _launchURL(
                                      Branches.branchesList[index].addr!);
                                },
                                child: Row(children: [
                                  Icon(Icons.location_on, size: 15),
                                  SizedBox(width: 5),
                                  CustomText("View Map",
                                      textAlign: TextAlign.start,
                                      color: Colors.black,
                                      fontSize: 10)
                                ]),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'mailto:${Branches.branchesList[index].emailId!}');
                            },
                            child: Row(children: [
                              Icon(Icons.email, size: 15),
                              SizedBox(width: 5),
                              CustomText(Branches.branchesList[index].emailId!,
                                  textAlign: TextAlign.start,
                                  color: Colors.black,
                                  fontSize: 10)
                            ]),
                          ),
                        ),
                      ],
                    ),
                  );
                })
            // Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //     child: GridView.builder(
            //         shrinkWrap: true,
            //         scrollDirection: Axis.vertical,
            //         padding: EdgeInsets.all(4.0),
            //         itemCount: Branches.branchesList.length,
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 2, childAspectRatio: 0.72),
            //         itemBuilder: (BuildContext context, int index) {
            //           return Container(
            //               padding: EdgeInsets.all(10),
            //               margin: EdgeInsets.all(8),
            //               decoration: BoxDecoration(
            //                   border: Border.all(),
            //                   borderRadius: BorderRadius.circular(15)),
            //               child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                   children: [
            //                     CustomText(Branches.branchesList[index].name!,
            //                         color: Colors.black, fontSize: 10),
            //                     Container(
            //                         height: 100,
            //                         width: 150,
            //                         decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(15),
            //                             image: DecorationImage(
            //                                 fit: BoxFit.cover,
            //                                 image: NetworkImage(Branches
            //                                     .branchesList[index]
            //                                     .uploadFile!)))),
            //                     Row(children: [
            //                       Icon(Icons.phone, size: 15),
            //                       SizedBox(width: 5),
            //                       CustomText(
            //                           Branches
            //                               .branchesList[index].mobileNumber!,
            //                           color: Colors.black,
            //                           fontSize: 10)
            //                     ]),
            //                     Row(children: [
            //                       Icon(Icons.email, size: 15),
            //                       SizedBox(width: 5),
            //                       Container(
            //                           height: 30,
            //                           width: 105,
            //                           alignment: Alignment.center,
            //                           child: CustomText(
            //                               Branches.branchesList[index].emailId!,
            //                               textAlign: TextAlign.start,
            //                               color: Colors.black,
            //                               fontSize: 10))
            //                     ]),
            //                     GestureDetector(
            //                       onTap: () {
            //                         _launchURL(
            //                             Branches.branchesList[index].address!);
            //                       },
            //                       child: Row(children: [
            //                         Icon(Icons.location_on, size: 15),
            //                         SizedBox(width: 5),
            //                         CustomText("View Map",
            //                             textAlign: TextAlign.start,
            //                             color: Colors.black,
            //                             fontSize: 10)
            //                       ]),
            //                     )
            //                   ]));
            //         }))
            )));
  }
}
