import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/donation_controller.dart';
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

  bool nutanMandirSeva = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Donate to Loyadham Mandir",
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //  color: AppColors.apptheme,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.apptheme,
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(top: 12.0, left: 10.0, right: 10.0),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: CustomText("Donation"),
                  trailing: donationvalue
                      ? onchange
                          ? CustomText("\$${_controller.value.text}")
                          : CustomText("\$0")
                      : CustomText("\$0"),
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: donationvalue,
                            onChanged: (value) {
                              setState(() {
                                donationvalue = value!;
                                if (value == false) {
                                  if (onsubmitvalue == 0) {
                                    totalamount += 0;
                                  } else {
                                    totalamount -= onsubmitvalue;
                                    onsubmitvalue = 0;
                                  }
                                } else {
                                  _controller.clear();
                                }
                              });
                            }),
                        Text("General")
                      ],
                    ),
                    donationvalue
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: TextFormField(
                              controller: _descriptionController,
                              decoration:
                                  InputDecoration(hintText: "Description"),
                            ),
                          )
                        : SizedBox(),
                    donationvalue
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _controller,
                              onChanged: (value) {
                                setState(() {
                                  onchange = true;
                                });
                              },
                              onFieldSubmitted: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    totalamount += 0;
                                    onsubmitvalue += 0;
                                  } else {
                                    print(value.toString());
                                    totalamount += int.parse(value.toString());
                                    onsubmitvalue = int.parse(value.toString());
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "\$ Enter Amount",
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
            Container(
              //  color: AppColors.apptheme,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.apptheme,
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(top: 12.0, left: 10.0, right: 10.0),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: CustomText("Mahapuja Seva"),
                  trailing: mahapujasevTotal == 0
                      ? CustomText("\$0")
                      : CustomText("\$${mahapujasevTotal}"),
                  children: [
                    ListTile(
                      leading: Checkbox(
                          value: hariJaynati,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                totalamount += 251;
                                mahapujasevTotal += 251;
                              } else {
                                totalamount -= 251;
                                mahapujasevTotal -= 251;
                              }

                              hariJaynati = value!;
                            });
                          }),
                      title: Text("Hari Jaynati Maha Puja - \$ 251"),
                    ),
                    ListTile(
                      leading: Checkbox(
                          value: nilkanthVariAbhishak,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                totalamount += 11;
                                mahapujasevTotal += 11;
                              } else {
                                totalamount -= 11;
                                mahapujasevTotal -= 11;
                              }
                              nilkanthVariAbhishak = value!;
                            });
                          }),
                      title: Text(
                          "Nilkanth Varni Abhishak during Hari Jayanti Maha Puja - \$ 11"),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              //  color: AppColors.apptheme,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.apptheme,
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(top: 12.0, left: 10.0, right: 10.0),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: CustomText("Thal"),
                  trailing: thalvalue ? CustomText("\$101") : CustomText("\$0"),
                  children: [
                    ListTile(
                      leading: Checkbox(
                          value: thalvalue,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                totalamount += 101;
                              } else {
                                totalamount -= 101;
                              }
                              thalvalue = value!;
                            });
                          }),
                      title: Text("Maharaj, Thakorji & Snato Thal - \$ 101"),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              //  color: AppColors.apptheme,
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
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: CustomText("Nutan Mandir Nirman Seva"),
                  trailing: nutanMandirSeva
                      ? CustomText("\$1001")
                      : CustomText("\$0"),
                  children: [
                    ListTile(
                      leading: Checkbox(
                          value: nutanMandirSeva,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                totalamount += 1001;
                              } else {
                                totalamount -= 1001;
                              }
                              nutanMandirSeva = value!;
                            });
                          }),
                      title: Text(
                          "Loya(India) Nutan Mandir Nirman Seva - \$ 1001"),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                height: 50.0,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.apptheme,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                margin: const EdgeInsets.only(
                  top: 12.0,
                  left: 10.0,
                  right: 10.0,
                ),
                child: ListTile(
                  title: CustomText("Total:- "),
                  trailing: CustomText("\$${totalamount}"),
                )),
            SizedBox(
              height: 50.0,
            ),
            SizedBox(
              height: 40.0,
              width: 300.0,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.apptheme),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => 
                            PersonalInfoUI(
                                  totalamount: totalamount,
                                )
                                ));
                  },
                  child: CustomText(
                    "Next",
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
