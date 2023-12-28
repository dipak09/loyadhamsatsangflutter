import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/donation_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:shimmer/main.dart';

import '../../Custom Widgets/customTextField.dart';

bool donationsucess = false;

class PersonalInfoUI extends StatefulWidget {
  var totalamount;
  PersonalInfoUI({
    Key? key,
    required this.totalamount,
  }) : super(key: key);

  @override
  State<PersonalInfoUI> createState() => _PersonalInfoUIState();
}

class _PersonalInfoUIState extends State<PersonalInfoUI> {
  var Donation = Get.put(DonationController());
  // var totalamount = 0;
  bool donationvalue = false;

  TextEditingController _controller = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    donationsucess = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                child: Column(
              children: [
                CustomTextField(
                  hintname: "Name",
                  controller: Donation.namecontroller,
                ),
                CustomTextField(
                  hintname: "Email",
                  controller: Donation.emailcontroller,
                ),
                CustomTextField(
                  hintname: "Phone",
                  controller: Donation.phonecontroller,
                ),
                CustomTextField(
                    hintname: "Street 1 Address",
                    controller: Donation.addresscontroller),
                CustomTextField(hintname: "Street 2 Address"),
                CustomTextField(
                    hintname: "City", controller: Donation.citycontroller),
                CustomTextField(
                    hintname: "Zip", controller: Donation.zipcontroller),
                CustomTextField(
                    hintname: "State", controller: Donation.statecontroller),
                CustomTextField(
                    hintname: "Country", controller: Donation.countrycontroller)
              ],
            )),
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
                  trailing: CustomText("\$${widget.totalamount}"),
                )),

            // Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
              child: Center(
                child: SizedBox(
                  height: 40.0,

                  width: 300.0,

                  //  color: AppColors.apptheme,

                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.apptheme),
                      onPressed: () {
                        if (Donation.namecontroller.value.text.isNotEmpty &&
                            Donation.emailcontroller.value.text.isNotEmpty &&
                            Donation.citycontroller.value.text.isNotEmpty &&
                            Donation.zipcontroller.value.text.isNotEmpty &&
                            widget.totalamount != 0) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => UsePaypal(
                                  sandboxMode: true,
                                  clientId:
                                      "AZAvbuknc_yWC4RA-mHoC1q2auWscZcOZd-pZEVnNK-Kd83p-JMvCl8PvPPmWyAJPjgFFRaPGp2fPjjO",
                                  secretKey:
                                      "EMr3iHKaDX6kgEasACP_LzkRZwx_cEdghpqE1D148GkXynqSefwNUeiwUuCvicS2Va9bmlzxKqcBQUlw",
                                  returnURL: "https://samplesite.com/return",
                                  cancelURL: "https://samplesite.com/cancel",
                                  transactions: [
                                    {
                                      "amount": {
                                        "total":
                                            '${widget.totalamount.toString()}',
                                        "currency": "USD",
                                        "details": {
                                          "subtotal":
                                              '${widget.totalamount.toString()}',
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },

                                      "description": _descriptionController
                                              .value.text.isEmpty
                                          ? "This is demo"
                                          : _descriptionController.value.text
                                              .toString(),

                                      // "payment_options": {

                                      //   "allowed_payment_method":

                                      //       "INSTANT_FUNDING_SOURCE"

                                      // },

                                      "item_list": {
                                        "items": [
                                          {
                                            "name": "Donation",
                                            "quantity": 1,
                                            "price":
                                                '${widget.totalamount.toString()}',
                                            "currency": "USD"
                                          }
                                        ],

                                        // shipping address is not required though

                                        "shipping_address": {
                                          "recipient_name": "Jane Foster",
                                          "line1": "Travis County",
                                          "line2": "",
                                          "city": "Austin",
                                          "country_code": "US",
                                          "postal_code": "73301",
                                          "phone": "+00000000",
                                          "state": "Texas"
                                        },
                                      }
                                    }
                                  ],
                                  note:
                                      "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    log("onSuccess: $params");

                                    Donation.getDonation(
                                        amount: widget.totalamount.toString(),
                                        paymentstatus: "Success",
                                        tnx_id: "MWGWQ6I3T680248G2612284N",
                                        paymentdate: "2023-12-28T12:22:17Z",
                                        payment_gross: "101");

                                    Fluttertoast.showToast(
                                        msg:
                                            "Thankyou for Donation. Money Received");
                                    Donation.namecontroller.clear();
                                    Donation.addresscontroller.clear();
                                    Donation.citycontroller.clear();
                                    Donation.countrycontroller.clear();
                                    Donation.emailcontroller.clear();
                                    Donation.phonecontroller.clear();
                                    Donation.statecontroller.clear();
                                    Donation.zipcontroller.clear();
                                    widget.totalamount = 0;
                                    setState(() {
                                      donationsucess = true;
                                    });
                                    // Donation.getDonation(
                                    //     amount: widget.totalamount);
                                  },
                                  onError: (error) {
                                    log("onError: $error");
                                  },
                                  onCancel: (params) {
                                    log('cancelled: $params');
                                  }),
                            ),
                          ); //print(_namecontroller.value.text.toString());
                          // print(_addresscontroller.value.text);
                        } else if (donationvalue == true) {
                          if (_descriptionController.value.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please Enter the Description");
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "Donation should not be zero or Required filled should not be empty");
                        }
                      },
                      child: const Text(
                        "Donate",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
