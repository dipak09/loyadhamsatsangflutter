// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/books_controller.dart';

class NetTradeSearchBar extends StatefulWidget {
  const NetTradeSearchBar({super.key});

  @override
  State<NetTradeSearchBar> createState() => _NetTradeSearchBarState();
}

class _NetTradeSearchBarState extends State<NetTradeSearchBar> {
  var Books = Get.put(BooksController());
  @override
  void initState() {
    super.initState();
    Books.searchBook('');
  }

  @override
  void dispose() {
    super.dispose();
    Books.searchController.clear();
    Books.searchController.dispose();
    Books.searchBook('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.apptheme),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
          controller: Books.searchController,
          onChanged: (value) => Books.searchBook(value),
          decoration: InputDecoration(
              hintText: "Search Books",
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none)),
    );
  }
}
