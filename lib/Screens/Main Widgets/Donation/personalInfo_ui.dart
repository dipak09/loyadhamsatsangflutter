import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/donation_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/customTextFieldWithPrefixIcon.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar_ui.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Donation/payPal_payment.dart';
import 'package:loyadhamsatsang/globals.dart';

import '../../Custom Widgets/customTextField.dart';

//bool donationsucess = false;

class PersonalInfoUI extends StatefulWidget {
  var totalamount;
  String donationData;

  PersonalInfoUI(
      {Key? key, required this.totalamount, required this.donationData})
      : super(key: key);

  @override
  State<PersonalInfoUI> createState() => _PersonalInfoUIState();
}

class _PersonalInfoUIState extends State<PersonalInfoUI> {
  var Donation = Get.put(DonationController());

  // var totalamount = 0;
  bool donationvalue = false;
  String countryCode = "1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.microtask(() {
    //   // Check if the widget is still mounted before calling setState
    //   if (mounted) {
    //     setState(() {
    //       donationsucess = false;
    //       // Update the state here
    //     });
    //   }
    // });
  }

  // @override
  // void dispose() {
  //   // Cancel any ongoing asynchronous operations here
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "",
        ),
        body: Obx(
          () => Donation.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
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
                          CustomTextFieldWithPrefixIcon(
                            hintname: "Phone",
                            prefixIcon: GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                    context: context,
                                    showPhoneCode: true,
                                    countryListTheme: CountryListThemeData(
                                      flagSize: 25,
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16, color: Colors.blueGrey),
                                      bottomSheetHeight: 500,
                                      // Optional. Country list modal height
                                      //Optional. Sets the border radius for the bottomsheet.
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                      //Optional. Styles the search field.
                                      inputDecoration: InputDecoration(
                                        labelText: 'Search',
                                        hintText: 'Search Your Country',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color(0xFF8C98A8)
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onSelect: (Country country) {
                                      setState(() {
                                        countryCode = country.phoneCode;
                                      });
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 13),
                                width: 70,
                                child: Row(
                                  children: [
                                    Text("+$countryCode"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),
                              ),
                            ),
                            controller: Donation.phonecontroller,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              MaskedInputFormatter('###-###-####'),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       width: 80,
                          //       alignment: Alignment.center,
                          //       child: CustomTextField(
                          //         readOnly: true,
                          //         hintname: countryCode,
                          //         keyboardType: TextInputType.number,
                          //       ),
                          //     ),
                          //     Expanded(
                          //       flex: 4,
                          //       child: CustomTextField(
                          //         hintname: "Phone",
                          //         controller: Donation.phonecontroller,
                          //         keyboardType: TextInputType.number,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          CustomTextField(
                              hintname: "Street 1 Address",
                              controller: Donation.street_address1controller),
                          CustomTextField(
                            hintname: "Street 2 Address",
                            controller: Donation.street_address2controller,
                          ),
                          CustomTextField(
                              hintname: "City",
                              controller: Donation.citycontroller),
                          CustomTextField(
                              keyboardType: TextInputType.number,
                              hintname: "Zip",
                              controller: Donation.zipcontroller),
                          CustomTextField(
                              hintname: "State",
                              controller: Donation.statecontroller),
                          CustomTextField(
                              hintname: "Country",
                              controller: Donation.countrycontroller)
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
                            trailing: CustomText("\$${NumberFormat('###,###,###').format(num.parse(widget.totalamount.toString()))}"),
                          )),

                      // Spacer(),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10.0, top: 20.0),
                          child: Center(
                              child: SizedBox(
                                  height: 40.0,
                                  width: 300.0,

                                  //  color: AppColors.apptheme,

                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.apptheme),
                                      onPressed: () {
                                        BuildContext dialogContext = context;
                                        if (Donation
                                            .namecontroller.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Name field cannot be empty!.");
                                        } else if (Donation
                                            .emailcontroller.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Email field cannot be empty!.");
                                        } else if (!EmailValidator.validate(
                                            Donation.emailcontroller.text
                                                .trim())) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Email address must be valid!.");
                                        } else if (Donation
                                            .phonecontroller.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Phone number field cannot be empty!.");
                                        } else if (Donation
                                            .street_address1controller
                                            .text
                                            .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Address field cannot be empty!.");
                                        } else if (Donation
                                            .citycontroller.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "City field cannot be empty!.");
                                        } else if (Donation
                                            .zipcontroller.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Zip code field cannot be empty!.");
                                        } else if (Donation
                                            .statecontroller.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "State field cannot be empty!.");
                                        } else if (Donation
                                            .countrycontroller.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Country field cannot be empty!.");
                                        } else {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext dialogContext) =>
                                                  PaypalCheckoutView(
                                                      sandboxMode: true,
                                                      clientId:
                                                          "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                                                      secretKey:
                                                          "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                                                      // returnURL:
                                                      //     "https://samplesite.com/return",
                                                      // cancelURL:
                                                      //     "https://samplesite.com/cancel",
                                                      transactions: [
                                                        {
                                                          "amount": {
                                                            "total": widget
                                                                .totalamount
                                                                .toString(),
                                                            "currency": "USD",
                                                            "details": {
                                                              "subtotal": widget
                                                                  .totalamount
                                                                  .toString(),
                                                              "shipping": '0',
                                                              "shipping_discount":
                                                                  0
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
                                                                "name":
                                                                    "A demo product",
                                                                "quantity": 1,
                                                                "price": widget
                                                                    .totalamount
                                                                    .toString(),
                                                                "currency":
                                                                    "USD"
                                                              }
                                                            ],

                                                            // shipping address is not required though
                                                            // "shipping_address": {
                                                            //   "recipient_name": Donation.namecontroller.text.toString(),
                                                            //   "line1": Donation.addresscontroller.text.toString(),
                                                            //   "line2": "",
                                                            //   "city": Donation.citycontroller.text.toString(),
                                                            //   "country_code": "US",
                                                            //   "postal_code": "73301",
                                                            //   "phone": "+00000000",
                                                            //   "state": "Texas"
                                                            // },
                                                          }
                                                        }
                                                      ],
                                                      note:
                                                          "Contact us for any questions on your order.",
                                                      onSuccess:
                                                          (Map params) async {
                                                        String transactionId =
                                                            "null";
                                                        log("****onSuccess: ${params}****");
                                                        Map<dynamic, dynamic>
                                                            responseData =
                                                            params['data'];

                                                        // Retrieve the create_time field
                                                        String createTime =
                                                            responseData[
                                                                'create_time'];
                                                        DateTime
                                                            createTimeParsed =
                                                            DateTime.parse(
                                                                createTime);
                                                        String formattedTime =
                                                            DateFormat(
                                                                    'yyyy-MM-dd hh:mm a')
                                                                .format(
                                                                    createTimeParsed);
                                                        // String transactionId =
                                                        //     params['paymentId'];
                                                        List<dynamic>
                                                            transactions =
                                                            params['data'][
                                                                'transactions'];

                                                        // Iterate through each transaction
                                                        transactions.forEach(
                                                            (transaction) {
                                                          // Access the 'related_resources' list from each transaction
                                                          List<dynamic>
                                                              relatedResources =
                                                              transaction[
                                                                  'related_resources'];

                                                          // Iterate through each related resource
                                                          relatedResources.forEach(
                                                              (relatedResource) {
                                                            // Access the 'sale' object from each related resource
                                                            Map<dynamic,
                                                                    dynamic>
                                                                sale =
                                                                relatedResource[
                                                                    'sale'];

                                                            // Access the 'id' field from the sale object (this is the sale ID)
                                                            transactionId =
                                                                sale['id'];

                                                            // Use the saleId as needed
                                                            log("Sale ID: $transactionId");
                                                          });
                                                        });
                                                        log("transactionId$transactionId");
                                                        log("formattedTime$formattedTime");
                                                        log("countryCode$countryCode");
                                                        Get.snackbar(
                                                          'Success',
                                                          "Your transaction was successful!",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          backgroundColor:
                                                              Colors.green,
                                                          duration: Duration(
                                                              seconds: 3),
                                                        );
                                                        Donation.getDonation(
                                                            donationData: widget
                                                                .donationData,
                                                            totalAmount: widget
                                                                .totalamount
                                                                .toString(),
                                                            txn_id: transactionId
                                                                .toString(),
                                                            payment_date:
                                                                formattedTime
                                                                    .toString(),
                                                            payment_status:
                                                                'completed',
                                                            countryCode:
                                                                countryCode);

                                                        //Navigator.pop(context);
                                                      },
                                                      onError: (error) {
                                                        log("onError: $error");
                                                        Get.snackbar(
                                                          'onError',
                                                          "An error occurred during the transaction.",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          backgroundColor:
                                                              Colors.green,
                                                          duration: Duration(
                                                              seconds: 2),
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      onCancel: (params) {
                                                        log('cancelled: $params');
                                                        Navigator.pop(context);
                                                      }),
                                            ),
                                            //(Route<dynamic> route) => false,
                                          );
                                        }
                                        // if (Donation.namecontroller.value.text.isNotEmpty &&
                                        //     Donation
                                        //         .emailcontroller.value.text.isNotEmpty &&
                                        //     Donation
                                        //         .citycontroller.value.text.isNotEmpty &&
                                        //     Donation
                                        //         .zipcontroller.value.text.isNotEmpty &&
                                        //     widget.totalamount != 0) {
                                        //   // log(Donation.namecontroller.value.text
                                        //   //     .toString());
                                        //   // Navigator.push(
                                        //   //     context,
                                        //   //     MaterialPageRoute(
                                        //   //         builder: (_) => PaypalPayment(
                                        //   //               name: Donation
                                        //   //                   .namecontroller.value
                                        //   //                   .toString(),
                                        //   //               totalAmount:
                                        //   //                   widget.totalamount.toString(),
                                        //   //               city: Donation
                                        //   //                   .citycontroller.value.text,
                                        //   //               state: Donation
                                        //   //                   .statecontroller.value.text,
                                        //   //               zipcode: Donation
                                        //   //                   .zipcontroller.value.text,
                                        //   //               country: Donation
                                        //   //                   .countrycontroller.value.text,
                                        //   //               phoneNumber: Donation
                                        //   //                   .phonecontroller.value.text,
                                        //   //               address: Donation
                                        //   //                   .addresscontroller.value.text,
                                        //   //               onFinish: (number) async {
                                        //   //                 Donation.getDonation(
                                        //   //                     amount: widget.totalamount
                                        //   //                         .toString(),
                                        //   //                     tnx_id: number,
                                        //   //                     paymentstatus: "Sucess",
                                        //   //                     paymentdate: DateTime.now()
                                        //   //                         .toString(),
                                        //   //                     payment_gross:
                                        //   //                         "sddffeie49323");
                                        //   //                 Fluttertoast.showToast(
                                        //   //                     msg:
                                        //   //                         "Thankyou for Donation. Money Received");
                                        //   //                 Donation.namecontroller.clear();
                                        //   //                 Donation.addresscontroller
                                        //   //                     .clear();
                                        //   //                 Donation.citycontroller.clear();
                                        //   //                 Donation.countrycontroller
                                        //   //                     .clear();
                                        //   //                 Donation.emailcontroller
                                        //   //                     .clear();
                                        //   //                 Donation.phonecontroller
                                        //   //                     .clear();
                                        //   //                 Donation.statecontroller
                                        //   //                     .clear();
                                        //   //                 Donation.zipcontroller.clear();
                                        //   //                 widget.totalamount = 0;
                                        //   //               },
                                        //   //             )));
                                        //
                                        // } else {
                                        //   Fluttertoast.showToast(
                                        //       msg:
                                        //           "Donation should not be zero or Required filled should not be empty");
                                        // }
                                      },
                                      // {
                                      //               Navigator.of(context).push(
                                      //                 MaterialPageRoute(
                                      //                   builder: (BuildContext context) => UsePaypal(
                                      //                       sandboxMode: true,
                                      //                       clientId:
                                      //                           "AZAvbuknc_yWC4RA-mHoC1q2auWscZcOZd-pZEVnNK-Kd83p-JMvCl8PvPPmWyAJPjgFFRaPGp2fPjjO",
                                      //                       secretKey:
                                      //                           "EMr3iHKaDX6kgEasACP_LzkRZwx_cEdghpqE1D148GkXynqSefwNUeiwUuCvicS2Va9bmlzxKqcBQUlw",
                                      //                       returnURL: "https://samplesite.com/return",
                                      //                       cancelURL: "https://samplesite.com/cancel",
                                      //                       transactions: [
                                      //                         {
                                      //                           "amount": {
                                      //                             "total":
                                      //                                 '${widget.totalamount.toString()}',
                                      //                             "currency": "USD",
                                      //                             "details": {
                                      //                               "subtotal":
                                      //                                   '${widget.totalamount.toString()}',
                                      //                               "shipping": '0',
                                      //                               "shipping_discount": 0
                                      //                             }
                                      //                           },

                                      //                           "description": _descriptionController
                                      //                                   .value.text.isEmpty
                                      //                               ? "This is demo"
                                      //                               : _descriptionController.value.text
                                      //                                   .toString(),

                                      //                           // "payment_options": {

                                      //                           //   "allowed_payment_method":

                                      //                           //       "INSTANT_FUNDING_SOURCE"

                                      //                           // },

                                      //                           "item_list": {
                                      //                             "items": [
                                      //                               {
                                      //                                 "name": "Donation",
                                      //                                 "quantity": 1,
                                      //                                 "price":
                                      //                                     '${widget.totalamount.toString()}',
                                      //                                 "currency": "USD"
                                      //                               }
                                      //                             ],

                                      //                             // shipping address is not required though

                                      //                             "shipping_address": {
                                      //                               "recipient_name": "Jane Foster",
                                      //                               "line1": "Travis County",
                                      //                               "line2": "",
                                      //                               "city": "Austin",
                                      //                               "country_code": "US",
                                      //                               "postal_code": "73301",
                                      //                               "phone": "+00000000",
                                      //                               "state": "Texas"
                                      //                             },
                                      //                           }
                                      //                         }
                                      //                       ],
                                      //                       note:
                                      //                           "Contact us for any questions on your order.",
                                      //                       onSuccess: (Map params) async {
                                      //                         log("onSuccess: $params");

                                      //                         Donation.getDonation(
                                      //                             amount: widget.totalamount.toString(),
                                      //                             paymentstatus: "Success",
                                      //                             tnx_id: "MWGWQ6I3T680248G2612284N",
                                      //                             paymentdate: "2023-12-28T12:22:17Z",
                                      //                             payment_gross: "101");

                                      //                         setState(() {
                                      //                           donationsucess = true;
                                      //                         });
                                      //                         // Donation.getDonation(
                                      //                         //     amount: widget.totalamount);
                                      //                       },
                                      //                       onError: (error) {
                                      //                         log("onError: $error");
                                      //                       },
                                      //                       onCancel: (params) {
                                      //                         log('cancelled: $params');
                                      //                       }),
                                      //                 ),
                                      //               ); //print(_namecontroller.value.text.toString());
                                      //               // print(_addresscontroller.value.text);
                                      //             } else if (donationvalue == true) {
                                      //               if (_descriptionController.value.text.isEmpty) {
                                      //                 Fluttertoast.showToast(
                                      //                     msg: "Please Enter the Description");
                                      //               }
                                      //             } else {
                                      //               Fluttertoast.showToast(
                                      //                   msg:
                                      //                       "Donation should not be zero or Required filled should not be empty");
                                      //             }
                                      //           },
                                      child: const Text(
                                        "Donate",
                                        style: TextStyle(color: Colors.white),
                                      )))))
                    ],
                  ),
                ),
        ));
  }
}
