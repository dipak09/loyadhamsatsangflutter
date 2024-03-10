import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/donation_controller.dart';
import 'package:loyadhamsatsang/Controllers/get_donation_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
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
  bool dropdown = false;

  var totalamount = 0;
  var mahapujasevTotal = 0;
  String? dropdownValue;
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
                                    bool isCheckboxChecked =
                                        checkboxValuesList[index][indexs];
                                    print(isCheckboxChecked);
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: Checkbox(
                                            value: checkboxValuesList[index]
                                                [indexs],
                                            onChanged: (value) {
                                              setState(() {
                                                checkboxValuesList[index]
                                                    [indexs] = value!;
                                                if (value) {
                                                  totalamount += int.parse(
                                                      DonationList
                                                          .getDonationList[
                                                              index]
                                                              ['subDonations']
                                                              [indexs]['amount']
                                                          .toString());
                                                  mahapujasevTotal += int.parse(
                                                      DonationList
                                                          .getDonationList[
                                                              index]
                                                              ['subDonations']
                                                              [indexs]['amount']
                                                          .toString());
                                                  if (checkboxValuesList[index]
                                                          [indexs] &&
                                                      DonationList.getDonationList[
                                                                          index]
                                                                      [
                                                                      'subDonations']
                                                                  [indexs][
                                                              'dropdown_name'] !=
                                                          null) {
                                                    print(
                                                        "Enter in the if loop-------->");

                                                    _showDropdownDialog(
                                                        context,
                                                        DonationList.getDonationList[
                                                                        index][
                                                                    'subDonations']
                                                                [indexs]
                                                            ['dropdown_name']);
                                                  }
                                                } else {
                                                  print(
                                                      "Enter in the else loop-------->");
                                                  totalamount -= int.parse(
                                                      DonationList
                                                          .getDonationList[
                                                              index]
                                                              ['subDonations']
                                                              [indexs]['amount']
                                                          .toString());
                                                  mahapujasevTotal -= int.parse(
                                                      DonationList
                                                          .getDonationList[
                                                              index]
                                                              ['subDonations']
                                                              [indexs]['amount']
                                                          .toString());
                                                  dropdown = false;
                                                  setState(() {});
                                                }
                                              });
                                              // if (value! &&
                                              //     DonationList.getDonationList[
                                              //                         index]
                                              //                     ['subDonations']
                                              //                 [indexs]
                                              //             ['dropdown_name'] !=
                                              //         null) {
                                              //   // Show dropdown only when checkbox is checked and dropdown_name is not null

                                              // }
                                            },
                                          ),
                                          title: Text(
                                            "${DonationList.getDonationList[index]['subDonations'][indexs]['sub_type'].toString()}" +
                                                " -" +
                                                "${DonationList.getDonationList[index]['subDonations'][indexs]['amount'].toString()}",
                                          ),
                                        ),
                                      ],
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

  void _showDropdownDialog(BuildContext context, List<dynamic>? dropdownItems) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dropdown Label"), // You can set a custom title here
          content: DropdownButton<dynamic>(
            value: dropdownValue, // Set the value of the selected dropdown item
            onChanged: (dynamic? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: dropdownItems
                    ?.map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem<dynamic>(
                    value: value,
                    child: Text(value),
                  );
                }).toList() ??
                [], // Convert the dropdownItems list to DropdownMenuItem widgets
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}