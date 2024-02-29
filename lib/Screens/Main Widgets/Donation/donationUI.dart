import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/donation_controller.dart';
import 'package:loyadhamsatsang/Controllers/get_donation_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/customTextField.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Donation/personalInfo_ui.dart';

class DonationUI extends StatefulWidget {
  const DonationUI({super.key});

  @override
  State<DonationUI> createState() => _DonationUIState();
}

class _DonationUIState extends State<DonationUI> {
  bool donationvalue = false;
  bool thalvalue = false;
  bool hariJaynati = false;
  bool onchange = false;
  var totalamount = 0;
  var mahapujasevTotal = 0;
  var onsubmitvalue = 0;
  bool nilkanthVariAbhishak = false;
  TextEditingController _controller = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  var Donation = Get.put(DonationController());
  var DonationList = Get.put(GetDonationControlloer());
  List<List<bool>> checkboxValuesList = [];
  bool nutanMandirSeva = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DonationList.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Donate to Loyadham Mandir",
        ),
        body: Obx(
          () => DonationList.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          // Initialize checkboxValues for each ExpansionTile
                          if (checkboxValuesList.length <= index) {
                            checkboxValuesList.add(List.filled(
                              DonationList
                                  .getDonationList[index]['subDonations']
                                  .length,
                              false,
                            ));
                          }

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.apptheme,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.only(
                                top: 12.0, left: 10.0, right: 10.0),
                            child: ExpansionTile(
                              title: CustomText(
                                  DonationList.getDonationList[index]['type']),
                              // trailing: mahapujasevTotal == 0
                              //     ? CustomText("\$0")
                              //     : CustomText("\$${mahapujasevTotal}"),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: DonationList
                                      .getDonationList[index]['subDonations']
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int indexs) {
                                    return ListTile(
                                      leading: Checkbox(
                                        value: checkboxValuesList[index]
                                            [indexs],
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValuesList[index][indexs] =
                                                value!;
                                            if (value) {
                                              totalamount += int.parse(
                                                  DonationList
                                                      .getDonationList[index]
                                                          ['subDonations']
                                                          [indexs]['amount']
                                                      .toString());
                                              mahapujasevTotal += int.parse(
                                                  DonationList
                                                      .getDonationList[index]
                                                          ['subDonations']
                                                          [indexs]['amount']
                                                      .toString());
                                            } else {
                                              totalamount -= int.parse(
                                                  DonationList
                                                      .getDonationList[index]
                                                          ['subDonations']
                                                          [indexs]['amount']
                                                      .toString());
                                              mahapujasevTotal -= int.parse(
                                                  DonationList
                                                      .getDonationList[index]
                                                          ['subDonations']
                                                          [indexs]['amount']
                                                      .toString());
                                            }
                                          });
                                        },
                                      ),
                                      title: Text(
                                        "${DonationList.getDonationList[index]['subDonations'][indexs]['sub_type'].toString()}" +
                                            " -" +
                                            "${DonationList.getDonationList[index]['subDonations'][indexs]['amount'].toString()}",
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: DonationList.getDonationList.length,
                      ),
                    ),
                    Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.apptheme,
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: EdgeInsets.only(
                          top: 12.0,
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: ListTile(
                          title: CustomText("Total:- "),
                          trailing: CustomText("\$${mahapujasevTotal}"),
                        )),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 40.0,
                          width: 300.0,
                          child: ElevatedButton(
                              style: mahapujasevTotal != 0
                                  ? ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.apptheme)
                                  : ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey),
                              onPressed: () {
                                if (mahapujasevTotal != 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => PersonalInfoUI(
                                                totalamount: mahapujasevTotal,
                                              )));
                                }
                              },
                              child: CustomText(
                                "Next",
                                color: Colors.white,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
        ));
  }
}
