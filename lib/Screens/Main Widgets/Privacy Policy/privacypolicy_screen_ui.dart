import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Controllers/privacypolicy_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PrivacyPolicyScreenUI extends StatefulWidget {
  const PrivacyPolicyScreenUI({super.key});

  @override
  State<PrivacyPolicyScreenUI> createState() => _PrivacyPolicyScreenUIState();
}

class _PrivacyPolicyScreenUIState extends State<PrivacyPolicyScreenUI> {
  var PrivacyPolicy = Get.put(PrivacyPolicyController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: PrivacyPolicy.isLoading.value,
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Privacy Policy",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomText(
                    PrivacyPolicy.description.toString(),
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
