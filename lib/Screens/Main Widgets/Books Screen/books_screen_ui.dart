// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/books_controller.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/Screens/Main%20Widgets/Books%20Screen/book_pdf_viewer.dart';
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
    super.dispose();
    Books.searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Books"),
        body: Column(children: [
          titleselection(),
          search(),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Obx(() => Books.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : Books.booksList.isNotEmpty && Books.booksList != null
                          ? GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(4.0),
                              scrollDirection: Axis.vertical,
                              itemCount: Books.booksList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 0.8),
                              itemBuilder: (BuildContext context, int index) {
                                var data = Books.booksList[index];

                                return GestureDetector(
                                    onTap: () {
                                      Get.to(() => PDFViewerFromUrl(
                                          url: data.uploadPdf!,
                                          title: data.bookName));
                                    },
                                    child: Container(
                                        width: screenWidth(context) * 0.32,
                                        height: screenHeight(context) * 0.2,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    data.uploadFile!),
                                                fit: BoxFit.fill))));
                              })
                          : Center(child: CustomText("No Book Found")))))
        ]));
  }

  Widget titleselection() {
    return Obx(() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomText("Language :"),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.apptheme),
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButton<String>(
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.apptheme),
                  style: GoogleFonts.poppins(
                      color: AppColors.apptheme, fontWeight: FontWeight.w600),
                  underline: SizedBox.shrink(),
                  isExpanded: true,
                  value: Books.selectedLang.value,
                  items: Books.languages
                      .map((item) => DropdownMenuItem<String>(
                          value: item, child: Text(item)))
                      .toList(),
                  onChanged: (item) {
                    Books.selectLang(item!);
                  }))
        ])));
  }

  Widget search() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.apptheme),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
          controller: Books.searchController,
          onChanged: (value) => Books.getBooks(search: value),
          decoration: InputDecoration(
              hintText: "Search Books",
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none)),
    );
  }
}
