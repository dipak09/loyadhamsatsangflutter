// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/video_controller.dart';
import 'package:loyadhamsatsang/Models/Video.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/usa_india_ui_screen.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Video/video_screen.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:shimmer/shimmer.dart';

class VideoScreenUI extends StatefulWidget {
  const VideoScreenUI({super.key});

  @override
  State<VideoScreenUI> createState() => _VideoScreenUIState();
}

class _VideoScreenUIState extends State<VideoScreenUI>
    with SingleTickerProviderStateMixin {
  var VideoData = Get.put(VideoController());
  late ScrollController _controller;
  ScrollController vendorRecordController = new ScrollController();

  var moreloading = false;
  Dio dio = Dio();
  TabController? _tabController;

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  // void loadmore() async {
  //   // print("here scroller postion ${_controller.position.extentAfter}");
  //   if (_controller.position.maxScrollExtent == _controller.position.pixels) {
  //     VideoData.home_page.value += 1;
  //     setState(() {});
  //     moreloading = true;

  //     String apiUrl =
  //         'http://loyadham.in/api/webservice/getYoutubeChannellatest?youtube=US';

  //     final response = await dio.get(apiUrl);

  //     final data = response.data;

  //     data.forEach((el) {
  //       Video video = Video.fromJson(el);
  //       VideoData.videoList.add(video);
  //     });

  //     moreloading = false;
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: CustomAppBar(title: "Videos", isBack: false),
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
                  onTap: VideoData.get,
                  unselectedLabelStyle: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w700),
                  tabs: [
                    //  Tab(text: '    All    '),
                    Tab(text: 'USA'),
                    Tab(text: 'IND')
                  ])),
          Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                //  KirtanKathaScreenUI(type: "All"),
                USAIndiaScreen(type: "US"),
                USAIndiaScreen(type: "IN")
              ]))
        ]));
  }
}
