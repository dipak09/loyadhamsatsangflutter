import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/donation_controller.dart';
import 'package:loyadhamsatsang/Controllers/get_donation_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Donation/personalInfo_ui.dart';
import 'package:loyadhamsatsang/globals.dart';

class DonationUI extends StatefulWidget {
  const DonationUI({super.key});

  @override
  State<DonationUI> createState() => _DonationUIState();
}

class _DonationUIState extends State<DonationUI> {
  var Donation = Get.put(DonationController());
  var _getDonationController = Get.put(GetDonationControlloer());

  late List<List<bool>> _subDonationCheckboxValues;
  late double _totalAmount;
  List<Map<String, dynamic>> _selectedDonations = [];
  List<List<TextEditingController>> _amtTextEditingControllerList = [];
  List<List<TextEditingController>> _decTextEditingControllerList = [];
  List<List<String>> _selectDropDownList = [];
  List<List<String>> _selectDate = [];

  @override
  void initState() {
    super.initState();
    _getDonationController.getDonationData().then((_) {
      // Initialize the list of checkbox values for each sub-donation
      _subDonationCheckboxValues = List.generate(
        _getDonationController.donationList.length,
        (index) => List.filled(
          _getDonationController.donationList[index].subDonations.length,
          false,
        ),
      );
      _amtTextEditingControllerList = List.generate(
        _getDonationController.donationList.length,
        (index) => List.generate(
          _getDonationController.donationList[index].subDonations.length,
          (subIndex) => TextEditingController(),
        ),
      );
      _decTextEditingControllerList = List.generate(
        _getDonationController.donationList.length,
        (index) => List.generate(
          _getDonationController.donationList[index].subDonations.length,
          (subIndex) => TextEditingController(),
        ),
      );
      _selectDropDownList = List.generate(
        _getDonationController.donationList.length,
        (index) => List.filled(
          _getDonationController.donationList[index].subDonations.length,
          '', // Initialize with empty string or any default value
        ),
      );
      _selectDate = List.generate(
        _getDonationController.donationList.length,
        (index) => List.filled(
          _getDonationController.donationList[index].subDonations.length,
          '', // Initialize with empty string or any default value
        ),
      );
      setState(() {
        _totalAmount = 0;
      });
    });
  }

  void _updateTotalAmount() {
    double totalAmount = 0;
    List<Map<String, dynamic>> selectedDonations = [];
    for (int i = 0; i < _getDonationController.donationList.length; i++) {
      var donationType = _getDonationController.donationList[i];
      for (int j = 0; j < donationType.subDonations.length; j++) {
        if (_subDonationCheckboxValues[i][j]) {
          double amount =
              double.parse(donationType.subDonations[j].amount.toString());
          if (amount == 0) {
            // If amount is zero, check if there's a value entered in the text field
            if (_amtTextEditingControllerList[i][j].text.isNotEmpty) {
              amount = double.parse(_amtTextEditingControllerList[i][j].text);
            }
          }
          totalAmount += amount;
          selectedDonations.add({
            'subtype': donationType.subDonations[j].subType,
            'amount': amount,
          });
        }
      }
    }
    setState(() {
      _totalAmount = totalAmount;
      _selectedDonations = selectedDonations;
    });
  }

  double calculateTotalAmount() {
    double totalAmount = 0;
    for (int i = 0; i < _getDonationController.donationList.length; i++) {
      var donationType = _getDonationController.donationList[i];
      for (int j = 0; j < donationType.subDonations.length; j++) {
        if (_subDonationCheckboxValues[i][j]) {
          double amount =
              double.parse(donationType.subDonations[j].amount.toString());
          if (amount == 0) {
            // If amount is zero, check if there's a value entered in the text field
            String enteredText = _amtTextEditingControllerList[i][j].text;
            if (enteredText.isNotEmpty) {
              amount = double.parse(enteredText);
            }
          }
          totalAmount += amount;
        }
      }
    }
    return totalAmount;
  }

  String generateEnteredDataJSON() {
    double userEnterAmount = 0;
    List<Map<String, dynamic>> enteredDataJson = [];
    for (int i = 0; i < _getDonationController.donationList.length; i++) {
      var donationType = _getDonationController.donationList[i];
      for (int j = 0; j < donationType.subDonations.length; j++) {
        if (_subDonationCheckboxValues[i][j]) {
          userEnterAmount =
              double.parse(donationType.subDonations[j].amount.toString());
          if (userEnterAmount == 0) {
            // If amount is zero, check if there's a value entered in the text field
            String enteredText = _amtTextEditingControllerList[i][j].text;
            if (enteredText.isNotEmpty) {
              userEnterAmount = double.parse(enteredText);
            }
          }
          String subtype = donationType.subDonations[j].subType;
          String? description =
              _decTextEditingControllerList[i][j].text.isNotEmpty
                  ? _decTextEditingControllerList[i][j].text
                  : "";
          String? selectedDate = _selectDate[i][j].isNotEmpty
              ? _selectDate[i][j]
              : ""; //ement selection of date if needed
          //String? selectedDropdownValue =_selectDropDownList[i][j].toString(); // Implement selection of dropdown value if needed
          String? selectedDropdownValue = _selectDropDownList[i][j].isNotEmpty
              ? _selectDropDownList[i][j].toString()
              : ""; // Implement selection of dropdown value if needed

          DonationData donationData = DonationData(
            subtype: subtype,
            amount: userEnterAmount,
            description: description,
            selectedDate: selectedDate,
            selectedDropdownValue: selectedDropdownValue,
          );
          enteredDataJson.add(donationData.toJson());
        }
      }
    }

    return jsonEncode(enteredDataJson);
  }

  String missingFields = ""; // Declare missingFields list here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Donate to Loyadham Mandir",
        ),
        body: Obx(
          () => _getDonationController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 70),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _getDonationController
                                        .donationList.length,
                                    itemBuilder: (context, index) {
                                      var donationType = _getDonationController
                                          .donationList[index];
                                      return ExpansionTileWithBorder(
                                        title: CustomText(
                                            donationType.type.toString()),
                                        children: donationType.subDonations
                                            .asMap()
                                            .entries
                                            .map((entry) => ExpansionTileChild(
                                                  selectedDate:
                                                      _selectDate[index]
                                                              [entry.key]
                                                          .toString(),
                                                  selectDateOnPressed:
                                                      () async {
                                                    String selectedDate = "";
                                                    // Show date picker dialog
                                                    final DateTime? pickedDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2100),
                                                    );
                                                    if (pickedDate != null) {
                                                      // Set selected date
                                                      setState(() {
                                                        selectedDate =
                                                            DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    pickedDate)
                                                                .toString();
                                                      });

                                                      setState(() {
                                                        _selectDate[index]
                                                                [entry.key] =
                                                            selectedDate;
                                                      });
                                                    }
                                                  },
                                                  //  selectValue: _selectDropDownList,
                                                  dropDownOnChanged: (p0) {
                                                    setState(() {
                                                      _selectDropDownList[index]
                                                              [entry.key] =
                                                          p0.toString();
                                                    });
                                                  },
                                                  //dropDownErrorText: _selectDropDownList[index][entry.key],
                                                  dropDownErrorText:
                                                      _selectDropDownList[index]
                                                                  [entry.key]
                                                              .isEmpty
                                                          ? 'This field is required'
                                                          : null,
                                                  decController:
                                                      _decTextEditingControllerList[
                                                          index][entry.key],
                                                  zeroAmtController:
                                                      _amtTextEditingControllerList[
                                                          index][entry.key],
                                                  zeroAmtOnChanged: (p0) {
                                                    setState(() {
                                                      _updateTotalAmount();
                                                    });
                                                  },
                                                  //\$${NumberFormat('##,##,###').format(num.parse(_totalAmount.toString()))}
                                                  title: entry.value.amount ==
                                                          '0'
                                                      ? entry.value.subType +
                                                          " \$${NumberFormat('###,###,###').format(num.parse(_amtTextEditingControllerList[index][entry.key].text.isEmpty ? "0" : _amtTextEditingControllerList[index][entry.key].text.toString()))}"
                                                      : entry.value.subType +
                                                              " \$${NumberFormat('###,###,###').format(num.parse(entry.value.amount.toString()!= "0"?entry.value.amount.toString():"0"))}" ??
                                                          "",
                                                  isChecked:
                                                      _subDonationCheckboxValues[
                                                          index][entry.key],
                                                  descriptionRequired: entry
                                                          .value
                                                          .descriptionRequired
                                                          .toString() ==
                                                      "1",
                                                  descriptionMandatory: entry
                                                          .value
                                                          .descriptionMandatory
                                                          .toString() ==
                                                      "1",
                                                  onChanged: (isChecked) {
                                                    setState(() {
                                                      // Update the checkbox state for the corresponding sub-donation
                                                      _subDonationCheckboxValues[
                                                                  index]
                                                              [entry.key] =
                                                          isChecked!;

                                                      _updateTotalAmount();
                                                    });
                                                  },
                                                  dateMandatory: entry
                                                          .value.dateMandatory
                                                          .toString() ==
                                                      "1",
                                                  dateRequired: entry
                                                          .value.dateRequired
                                                          .toString() ==
                                                      "1",
                                                  description: entry
                                                      .value.description
                                                      .toString(),
                                                  dropdownMandatory: entry.value
                                                          .dropdownMandatory
                                                          .toString() ==
                                                      "1",
                                                  dropdownRequired: entry.value
                                                          .dropdownRequired
                                                          .toString() ==
                                                      "1",
                                                  dropdownLabel: entry
                                                      .value.dropdownLabel
                                                      .toString(),
                                                  dropdownName:
                                                      entry.value.dropdownName,
                                                  amount: entry.value.amount
                                                      .toString(),
                                                ))
                                            .toList(),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 50.0,
                                        width: screenWidth(context),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.4)),
                                            color: AppColors.apptheme
                                            //borderRadius: BorderRadius.circular(10),

                                            ),
                                        child: CustomText(
                                          "Donation Summary",
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      _selectedDonations.isNotEmpty
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(0.4))),
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    _selectedDonations.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    tileColor: index.isEven
                                                        ? Colors.grey
                                                            .withOpacity(0.5)
                                                        : Colors.white,
                                                    // contentPadding: EdgeInsets.zero,
                                                    title: Text(
                                                        _selectedDonations[
                                                                    index]
                                                                ['subtype'] ??
                                                            ""),
                                                    //_selectedDonations[index]['amount']
                                                    trailing: Text(
                                                        "\$${NumberFormat('###,###,###').format(num.parse(_selectedDonations[index]['amount'].toString()))}"),
                                                  );
                                                },
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 60.0,
                                      width: screenWidth(context),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black
                                                  .withOpacity(0.4)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText("Total"),
                                          CustomText(
                                              "\$${NumberFormat('###,###,###').format(num.parse(_totalAmount.toString()))}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 60.0,
                          width: screenWidth(context),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40.0,
                                width: 300.0,
                                color: Colors.transparent,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.apptheme),
                                    onPressed: () {
                                      bool allMandatoryFieldsFilled = true;
                                      String result = generateEnteredDataJSON();
                                      log("finalResult${result}");
                                      log("_totalAmount${_totalAmount}");
                                      if (_totalAmount == 0) {
                                        allMandatoryFieldsFilled = false;
                                        Fluttertoast.showToast(
                                            msg:
                                                "Amount should not be zero or Required filled should not be empty");
                                      } else {
                                        // Flag to indicate if all mandatory fields are filled
                                        // bool allMandatoryFieldsFilled = true;

                                        // Iterate through each donation type and its sub-donations
                                        for (int i = 0;
                                            i <
                                                _getDonationController
                                                    .donationList.length;
                                            i++) {
                                          var donationType =
                                              _getDonationController
                                                  .donationList[i];
                                          for (int j = 0;
                                              j <
                                                  donationType
                                                      .subDonations.length;
                                              j++) {
                                            if (_subDonationCheckboxValues[i]
                                                [j]) {
                                              var subDonation =
                                                  donationType.subDonations[j];

                                              // Check if description is mandatory and not filled
                                              if (subDonation
                                                          .descriptionMandatory ==
                                                      "1" &&
                                                  _decTextEditingControllerList[
                                                          i][j]
                                                      .text
                                                      .isEmpty) {
                                                allMandatoryFieldsFilled =
                                                    false;
                                                missingFields =
                                                    subDonation.subType;
                                                break; // Exit the loop if any mandatory field is empty
                                              }

                                              // Check if date is mandatory and not selected
                                              if (subDonation.dateMandatory ==
                                                      "1" &&
                                                  _selectDate[i][j].isEmpty) {
                                                allMandatoryFieldsFilled =
                                                    false;
                                                missingFields =
                                                    subDonation.subType;
                                                break; // Exit the loop if any mandatory field is empty
                                              }

                                              // Check if dropdown selection is mandatory and not made
                                              if (subDonation
                                                          .dropdownMandatory ==
                                                      "1" &&
                                                  _selectDropDownList[i][j]
                                                      .isEmpty) {
                                                allMandatoryFieldsFilled =
                                                    false;
                                                missingFields =
                                                    subDonation.subType;
                                                break; // Exit the loop if any mandatory field is empty
                                              }
                                            }
                                          }
                                          if (!allMandatoryFieldsFilled) {
                                            break; // Exit the loop if any mandatory field is empty
                                          }
                                        }

                                        // Proceed to the next screen if all mandatory fields are filled
                                        if (allMandatoryFieldsFilled) {
                                          String result =
                                              generateEnteredDataJSON();
                                          log("finalResult${result}");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => PersonalInfoUI(
                                                totalamount: _totalAmount,
                                                donationData: result,
                                              ),
                                            ),
                                          );
                                        } else {
                                          // Show toast message if any mandatory field is empty
                                          Fluttertoast.showToast(
                                            msg:
                                                "Please fill out all required fields: ${missingFields}",
                                          );
                                        }
                                      }
                                    },
                                    child: CustomText(
                                      "Next",
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}

class ExpansionTileWithBorder extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  const ExpansionTileWithBorder({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Border color
        borderRadius: BorderRadius.circular(8.0), // Border radius
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: title,
          children: children,
        ),
      ),
    );
  }
}

class ExpansionTileChild extends StatefulWidget {
  final String title;
  final String amount;
  final bool isChecked;
  final Function(bool?)? onChanged;
  final bool descriptionRequired;
  final bool descriptionMandatory;

  final bool dateRequired;
  final bool dateMandatory;
  final bool dropdownRequired;
  final bool dropdownMandatory;
  final String? description;
  final String? dropdownLabel;

  //  List<List<String>>? selectValue;
  final TextEditingController? zeroAmtController;
  final TextEditingController? decController;
  final List<dynamic>? dropdownName;

  final Function(String)? zeroAmtOnChanged;

  Function(String?)? dropDownOnChanged;

  Function()? selectDateOnPressed;

  String? selectedDate;
  String? dropDownErrorText;

  ExpansionTileChild(
      {Key? key,
      required this.title,
      required this.amount,
      required this.isChecked,
      required this.onChanged,
      required this.descriptionMandatory,
      required this.descriptionRequired,
      required this.dateMandatory,
      required this.dateRequired,
      required this.description,
      required this.dropdownMandatory,
      required this.dropdownRequired,
      required this.dropdownLabel,
      required this.dropdownName,
      this.zeroAmtController,
      this.zeroAmtOnChanged,
      this.decController,
      this.dropDownOnChanged,
      this.selectDateOnPressed,
      this.selectedDate,
      this.dropDownErrorText
      //this.selectValue
      })
      : super(key: key);

  @override
  State<ExpansionTileChild> createState() => _ExpansionTileChildState();
}

class _ExpansionTileChildState extends State<ExpansionTileChild> {
  String? selectedDropdownValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          value: widget.isChecked,
          onChanged: widget.onChanged,
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
        ),
        if (widget.isChecked && widget.amount == "0")
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                TextField(
                  controller: widget.zeroAmtController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z0-9]+|\s")),
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: widget.zeroAmtOnChanged,
                  decoration: InputDecoration(
                    hintText: "",
                    contentPadding: const EdgeInsets.only(
                        left: 20.0), // Add padding to the left
                  ),
                ),
                const Positioned(
                  left: 0,
                  child: Text(
                    '\$',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black), // Customize the style as needed
                  ),
                ),
              ],
            ),
          ),
        if (widget.isChecked &&
            widget.descriptionRequired &&
            widget.descriptionMandatory)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFormField(
              controller: widget.decController,
              decoration: InputDecoration(
                //labelText: widget.description ?? 'Name and Purpose',
                labelText:
                    '${widget.description}${widget.descriptionRequired == true ? '*' : ''}',
                //errorText: widget.dropDownErrorText
                errorText: widget.descriptionRequired == true &&
                        widget.decController!.text.isEmpty
                    ? 'This field is required'
                    : null,
              ),
              validator: (value) {
                if (widget.descriptionRequired == true && value!.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
              // Set error style to red if validation fails
              // style: TextStyle(color: widget.descriptionRequired == true? Colors.red : null),
            ),
          ),
        if (widget.isChecked && widget.dateRequired && widget.dateMandatory)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: widget.selectDateOnPressed,
                    // onPressed: () async {
                    //   // Show date picker dialog
                    //   final DateTime? pickedDate = await showDatePicker(
                    //     context: context,
                    //     initialDate: DateTime.now(),
                    //     firstDate: DateTime(2000),
                    //     lastDate: DateTime(2100),
                    //   );
                    //   if (pickedDate != null) {
                    //     // Set selected date
                    //     setState(() {
                    //       selectedDate = pickedDate;
                    //       // userSelectedDate = DateFormat('yyyy-MM-dd')
                    //       //     .format(selectedDate!)
                    //       //     .toString();
                    //     });
                    //   }
                    // },
                    child: Text(
                      widget.selectedDate.toString() == ""
                          ? "Select Date*"
                          : widget.selectedDate.toString(),
                      style: TextStyle(
                          color: widget.selectedDate.toString() == ""
                              ? Colors.red
                              : null),
                      //: DateFormat('yyyy-MM-dd').format(widget.selectedDate!)),
                    ),
                  ),
                )
              ],
            ),
          ),
        if (widget.isChecked &&
            widget.dropdownRequired &&
            widget.dropdownMandatory)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  // labelText: widget.dropdownLabel,
                  labelText:
                      '${widget.dropdownLabel}${widget.descriptionRequired == true ? '*' : ''}',
                  errorText: widget.dropDownErrorText
                  // errorText: widget.dropdownMandatory && widget.dropDownErrorText == null
                  //     ? 'This field is required'
                  //     : null,
                  ),
              value: selectedDropdownValue,
              onChanged: widget.dropDownOnChanged,
              // onChanged: (newValue) {
              //   setState(() {
              //     selectedDropdownValue = newValue;
              //    // widget.selectValue! = newValue.toString();
              //     //String? selectedValue = getSelectedDropdownValue();
              //    // widget.selectValue?.add([newValue.toString()]);
              //     selectedDropDownValues!.add([newValue.toString()]);
              //    // log("final selectValue${widget.selectValue}");
              // //    widget.selectValue?.add(newValue.toString());
              // //    userSelectDropDownValue = newValue.toString();
              //   });
              // },
              items: widget.dropdownName!
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}

class DonationData {
  String subtype;
  double amount;
  String? description;
  String? selectedDate;
  String? selectedDropdownValue;

  DonationData({
    required this.subtype,
    required this.amount,
    this.description,
    this.selectedDate,
    this.selectedDropdownValue,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'subtype': subtype,
      'amount': amount,
    };
    if (description != null) json['description'] = description;
    if (selectedDate != null) json['selectedDate'] = selectedDate;
    if (selectedDropdownValue != null)
      json['selectedDropdownValue'] = selectedDropdownValue;
    return json;
  }
}
