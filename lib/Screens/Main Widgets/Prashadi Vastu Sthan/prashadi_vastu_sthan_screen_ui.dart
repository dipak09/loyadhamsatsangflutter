import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/prashadi_vastu_sthan_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Prashadi%20Vastu%20Sthan/prashadi_sthan_screen.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Prashadi%20Vastu%20Sthan/prashadi_vastu_screen.dart';

class PrashadiVastuSthanScreenUI extends StatefulWidget {
  const PrashadiVastuSthanScreenUI({super.key});

  @override
  State<PrashadiVastuSthanScreenUI> createState() =>
      _PrashadiVastuSthanScreenUIState();
}

class _PrashadiVastuSthanScreenUIState extends State<PrashadiVastuSthanScreenUI>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  var Prashadi = Get.put(PrashadiVastuSthanController());
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
          title: "Loyadham Prashadi",
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
                  tabs: [Tab(text: 'Vastu'), Tab(text: 'Sthan')])),
          Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [PrashadiVastuScreen(), PrashadiSthanScreen()]))
        ]));
  }
}
