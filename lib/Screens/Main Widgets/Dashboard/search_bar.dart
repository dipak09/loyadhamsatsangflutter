import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/search_controller.dart';
import 'package:loyadhamsatsang/Models/search.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';
import 'package:shimmer/shimmer.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  var SearchData = Get.put(SearchControllerList());
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SearchData.book!.clear();
    SearchData.youtubeUs!.clear();
    SearchData.youtubeIn!.clear();
    SearchData.kathaAudio!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.apptheme,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Container(
              width: double.infinity,
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextFormField(
                  controller: controller,
                  onFieldSubmitted: (value) {
                    print(value);
                    SearchData.getSearchData(value);
                    setState(() {});
                  },
                  onChanged: (value) {
                    //setState(() {});
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.clear();
                          },
                          icon: Icon(Icons.clear)),
                      hintText: "Search....",
                      contentPadding: EdgeInsets.only(top: 4.0),
                      border: InputBorder.none),
                ),
              )),
        ),
        body: Obx(() => SearchData.isLoading.value == true
            ? _loader()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchData.book!.length == 0
                        ? SizedBox()
                        : const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 10.0),
                            child: CustomText(
                              'Books',
                              fontSize: 18.0,
                            ),
                          ),
                    SearchData.book!.length == 0
                        ? SizedBox()
                        : SizedBox(
                            height: 300.0,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: SearchData.book!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: booklistviewLayOut(
                                        SearchData.book![index].coverImage
                                            .toString(),
                                        SearchData.book![index].name
                                            .toString()));
                              },
                            ),
                          ),
                    SearchData.youtubeUs!.length == 0
                        ? SizedBox()
                        : const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 10.0),
                            child: CustomText(
                              'Youtube US',
                              fontSize: 18.0,
                            ),
                          ),
                    SearchData.youtubeUs!.length == 0
                        ? SizedBox()
                        : SizedBox(
                            height: 190.0,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: SearchData.youtubeUs!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: listviewLayOut(
                                    
                                      SearchData.youtubeUs![index].thumbnail
                                          .toString(),
                                      SearchData.youtubeUs![index].title
                                          .toString(),
                                    ));
                              },
                            ),
                          ),
                    SearchData.youtubeIn!.length == 0
                        ? SizedBox()
                        : const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 10.0),
                            child: CustomText(
                              'Youtube IN',
                              fontSize: 18.0,
                            ),
                          ),
                    SearchData.youtubeIn!.length == 0
                        ? SizedBox()
                        : SizedBox(
                            height: 190.0,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: SearchData.youtubeIn!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: listviewLayOut(
                                      SearchData.youtubeIn![index].thumbnail
                                          .toString(),
                                      SearchData.youtubeIn![index].title
                                          .toString(),
                                    ));
                              },
                            ),
                          ),
                    SearchData.kathaAudio!.length == 0
                        ? SizedBox()
                        : const Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 10.0),
                            child: CustomText(
                              'KathaAudio',
                              fontSize: 18.0,
                            ),
                          ),
                    SearchData.kathaAudio!.length == 0
                        ? SizedBox()
                        : SizedBox(
                            height: 250.0,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: SearchData.kathaAudio!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: listviewLayOut(
                                        SearchData.kathaAudio![index].coverImage
                                            .toString(),
                                        SearchData.kathaAudio![index].fileName
                                            .toString()));
                              },
                            ),
                          ),
                    SizedBox(
                      height: 30.0,
                    )
                  ],
                ),
              )));
  }

  Widget listviewLayOut(String image, String title) {
    return SizedBox(
      height: 180.0,
      width: 200.0,
      //color: Colors.red,
      child: Column(
        children: [
          SizedBox(
              child: Image.network(
            image,
            scale: 1.5,
            fit: BoxFit.cover,
          )),
          CustomText(
            title,
            fontSize: 10.0,
          )
        ],
      ),
    );
  }

  Widget booklistviewLayOut(String image, String title,  ) {
    return GestureDetector(
      
      child: SizedBox(
        height: 180.0,
        width: 200.0,
        //color: Colors.red,
        child: Column(
          children: [
            SizedBox(
                child: Image.network(
              image,
              scale: 2.5,
              fit: BoxFit.cover,
            )),
            CustomText(
              title,
              fontSize: 10.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _loader() {
    return SizedBox(
        height: screenHeight(context) * 0.2,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                  height: 125,
                  width: 250,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Shimmer.fromColors(
                          highlightColor: Colors.grey[300]!,
                          baseColor: Colors.grey[200]!,
                          child: Container(
                              width: 200, height: 200, color: Colors.white))));
            }));
  }
}
