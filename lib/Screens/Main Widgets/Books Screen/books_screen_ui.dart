// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';
import 'package:loyadhamsatsang/Controllers/books_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomScaffold.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class BooksScreenUI extends StatefulWidget {
  const BooksScreenUI({super.key});

  @override
  State<BooksScreenUI> createState() => _BooksScreenUIState();
}

class _BooksScreenUIState extends State<BooksScreenUI> {
  var Books = Get.put(BooksController());

  @override
  void dispose() {
    // Your custom cleanup code.
    super.dispose();
    Books.searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appbar: CustomAppBar(
        titleImage: AppImages.booksTitle,
      ),
      children: Column(children: [
        titleselection(),
        dateSelection(),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Obx(() => Books.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Books.booksList.isNotEmpty && Books.booksList != null
                      ? GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(4.0),
                          scrollDirection: Axis.vertical,
                          itemCount: Books.booksList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.8),
                          itemBuilder: (BuildContext context, int index) {
                            var data = Books.booksList[index];
                            return GestureDetector(
                                onTap: () {},
                                child: Container(
                                    width: screenWidth(context) * 0.32,
                                    height: screenHeight(context) * 0.2,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(data.uploadFile!),
                                          fit: BoxFit.fill),

                                      // borderRadius: BorderRadius.all(
                                      //     Radius.circular(15)
                                      //     )
                                    )));
                          })
                      : Center(child: CustomText("No Book Found")))),
        )
      ]),
    );
  }

  Widget titleselection() {
    return Stack(children: [
      Container(
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(AppImages.dailyDarshanSlider)))),
      Container(
          height: 100,
          padding: EdgeInsets.only(left: 50, right: 40, top: 25, bottom: 24),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Books.languages.length,
              itemBuilder: (context, index) {
                return titleCards(Books.languages[index]);
              }))
    ]);
  }

  Widget titleCards(String title) {
    return Obx(() => GestureDetector(
        onTap: () {
          Books.selectLang(title);
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                color: Books.selectedLang.value == title
                    ? AppColors.apptheme
                    : null,
                border: Border.all(
                    color: Books.selectedLang.value == title
                        ? Colors.transparent
                        : AppColors.apptheme)),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: CustomText(title,
                fontSize: 10,
                color: Books.selectedLang.value == title
                    ? Colors.white
                    : Colors.black))));
  }

  Widget dateSelection() {
    return Stack(children: [
      Container(
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(AppImages.dailyDarshanSlider)))),
      Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
        child: TextFormField(
            controller: Books.searchController,
            onChanged: (value) {
              Books.getBooks(search: value);
            },
            decoration: InputDecoration(
                hintText: "Search Books",
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none)),
      ),
    ]);
  }
}
