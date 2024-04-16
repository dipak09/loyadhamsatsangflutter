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
          String? description = _decTextEditingControllerList[i][j].text.isNotEmpty
              ? _decTextEditingControllerList[i][j].text
              : "";
          String? selectedDate =_selectDate[i][j].isNotEmpty?_selectDate[i][j]:"";//ement selection of date if needed
          //String? selectedDropdownValue =_selectDropDownList[i][j].toString(); // Implement selection of dropdown value if needed
          String? selectedDropdownValue = _selectDropDownList[i][j].isNotEmpty
              ? _selectDropDownList[i][j].toString()
              : "";// Implement selection of dropdown value if needed

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
                  margin: EdgeInsets.symmetric( horizontal: 10),
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
                                          selectedDate: _selectDate[index][entry.key].toString(),
                                          selectDateOnPressed: () async {
                                            String selectedDate = "";
                                            // Show date picker dialog
                                            final DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                            );
                                            if (pickedDate != null) {
                                              // Set selected date
                                              setState(() {
                                                selectedDate = DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate)
                                                    .toString();
                                              });

                                              setState(() {
                                                _selectDate[index][entry.key] = selectedDate;
                                              });
                                            }
                                          },
                                        //  selectValue: _selectDropDownList,
                                          dropDownOnChanged: (p0) {
                                              setState(() {
                                                _selectDropDownList[index][entry.key] = p0.toString();
                                              });

                                          },
                                          decController: _decTextEditingControllerList[index][entry.key],
                                                  zeroAmtController:
                                                      _amtTextEditingControllerList[
                                                          index][entry.key],
                                                  zeroAmtOnChanged: (p0) {
                                                    setState(() {
                                                      _updateTotalAmount();
                                                    });
                                                  },
                                                  title: entry.value.subType +
                                                          " \$${entry.value.amount}" ??
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
                                                    trailing: Text(
                                                        "\$${_selectedDonations[index]['amount']}"),
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
                                          CustomText("\$$_totalAmount"),
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
                                      String result = generateEnteredDataJSON();
                                      log("finalResult${result}");
                                      if (_totalAmount == 0) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Amount should not be zero or Required filled should not be empty");
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => PersonalInfoUI(
                                                      totalamount: _totalAmount, donationData: result,
                                                    )));
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

   ExpansionTileChild({
    Key? key,
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
     this.selectedDate
     //this.selectValue
  }) : super(key: key);

  @override
  State<ExpansionTileChild> createState() => _ExpansionTileChildState();
}

class _ExpansionTileChildState extends State<ExpansionTileChild> {

  String? selectedDropdownValue;
  String? getSelectedDropdownValue() {
    return selectedDropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    log("descriptionMandatory@@@${widget.descriptionMandatory}");
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextField(
              controller: widget.zeroAmtController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9]+|\s")),
              ], //
              keyboardType: TextInputType.number,
              onChanged: widget.zeroAmtOnChanged,
              decoration: InputDecoration(
                labelText: "\$",
              ),
            ),
          ),
        if (widget.isChecked &&
            widget.descriptionRequired &&
            widget.descriptionMandatory)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextField(
              controller: widget.decController,
              decoration: InputDecoration(
                labelText: widget.description ?? 'Name and Purpose',
              ),
            ),
          ),
        if (widget.isChecked && widget.dateRequired && widget.dateMandatory)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    child: Text(widget.selectedDate.toString() == ""
                        ? "Select Date":widget.selectedDate.toString()
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
                labelText: widget.dropdownLabel,
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
