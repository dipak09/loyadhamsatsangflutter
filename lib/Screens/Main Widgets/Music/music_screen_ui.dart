// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/kirtan&katha_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Music/kirtan&katha_screen_ui.dart';
import 'package:loyadhamsatsang/globals.dart';

class MusicScreenUI extends StatefulWidget {
  const MusicScreenUI({super.key});

  @override
  State<MusicScreenUI> createState() => _MusicScreenUIState();
}

class _MusicScreenUIState extends State<MusicScreenUI>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  var Prashadi = Get.put(KirtanKathaController());
  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: CustomAppBar(
          isBack: false,
          title: "Music",
        ),
        body: Column(children: [
          Theme(
              data: theme.copyWith(
                  colorScheme: theme.colorScheme
                      .copyWith(surfaceVariant: Colors.transparent)),
              child: TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  labelPadding: EdgeInsets.symmetric(horizontal: 2),
                  automaticIndicatorColorAdjustment: true,
                  indicatorColor: AppColors.apptheme,
                  labelColor: AppColors.apptheme,
                  unselectedLabelColor: Colors.black,
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700, fontSize: 14),
                  onTap: Prashadi.get,
                  unselectedLabelStyle: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w700),
                  tabs: [
                    //  Tab(text: '    All    '),
                    Tab(text: 'Kirtan'),
                    Tab(text: 'Katha')
                  ])),
          Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                //  KirtanKathaScreenUI(type: "All"),
                KirtanKathaScreenUI(type: "kirtan"),
                KirtanKathaScreenUI(type: "katha")
              ]))
        ]));
  
  }

  Widget cards({String? title, Function? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: screenWidth(context),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: AppColors.apptheme,
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                topEnd: Radius.circular(5),
                bottomStart: Radius.circular(5),
                bottomEnd: Radius.circular(20))),
        child: CustomText(
          title!,
          color: Colors.white,
        ),
      ),
    );
  }
}
