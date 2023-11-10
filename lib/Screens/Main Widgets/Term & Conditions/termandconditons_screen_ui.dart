import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/termandconditions_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TermAndConditonsScreenUI extends StatefulWidget {
  const TermAndConditonsScreenUI({super.key});

  @override
  State<TermAndConditonsScreenUI> createState() =>
      _TermAndConditonsScreenUIState();
}

class _TermAndConditonsScreenUIState extends State<TermAndConditonsScreenUI> {
  var TermAndConditons = Get.put(TermAndConditonsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: TermAndConditons.isLoading.value,
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Term & Conditions",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomText(
                    TermAndConditons.description.toString(),
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
