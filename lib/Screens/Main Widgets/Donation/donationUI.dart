import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/customTextField.dart';

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
  bool nilkanthVariAbhishak = false;
  TextEditingController _controller = TextEditingController();
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
                  trailing: CustomText("\$0"),
                  children: [
                    ListTile(
                      leading: Checkbox(
                          value: hariJaynati,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                totalamount += 251;
                              } else {
                                totalamount -= 251;
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
                              } else {
                                totalamount -= 11;
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
                  trailing: CustomText("\$0"),
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
            Form(
                child: Column(
              children: [
                CustomTextField(hintname: "Name"),
                CustomTextField(hintname: "Email"),
                CustomTextField(hintname: "Phone"),
                CustomTextField(hintname: "Street 1 Address"),
                CustomTextField(hintname: "Street 2 Address"),
                CustomTextField(hintname: "City"),
                CustomTextField(hintname: "Zip"),
                CustomTextField(hintname: "State"),
                CustomTextField(hintname: "Country")
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
                  leading: CustomText("Total:- "),
                  trailing: CustomText("\$${totalamount}"),
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
                        if (totalamount == 0) {
                          Fluttertoast.showToast(
                              msg: "Amount should not be zero");
                        } else {
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
                                        "total": '${totalamount.toString()}',
                                        "currency": "USD",
                                        "details": {
                                          "subtotal":
                                              '${totalamount.toString()}',
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },

                                      "description":
                                          "The payment transaction description.",

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
                                                '${totalamount.toString()}',
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
                                  },
                                  onError: (error) {
                                    log("onError: $error");
                                  },
                                  onCancel: (params) {
                                    log('cancelled: $params');
                                  }),
                            ),
                          );
                        }
                      },
                      child: Text(
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
