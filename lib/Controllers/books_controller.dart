// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Models/Books.dart';
//import 'package:loyadhamsatsang/Models/Branches.dart';

class BooksController extends GetxController {
  Dio dio = Dio();
  TextEditingController searchController = TextEditingController();
  List<Books> booksList = [];
  List<Books> fullbooksList = [];
  final searchQuery = ''.obs;
  RxString selectedLang = 'All'.obs;
  RxBool isLoading = false.obs;
  final List<String> languages = [
    'All',
    'English',
    'Hindi',
    'Gujarati',
  ];
  void selectLang(String item) {
    selectedLang.value = item;
    getBooks();
  }

  @override
  void onInit() {
    super.onInit();
    getBooks();
  }

  // SearchName(String searchtxt) {
  //   booksList = [];
  //   if (searchtxt.isEmpty)
  //     booksList = List.from(fullbooksList);
  //   else
  //     booksList = fullbooksList
  //         .where((residence) =>
  //             residence.bookName!.toString().contains(searchtxt.toString()))
  //         .toList();

  //     }

  Future<void> getBooks({String? search}) async {
    try {
      isLoading(true);
      update();
      print(selectedLang);
      print(search);
      String apiUrl =
          'https://loyadham.in/api/webservice/book?language=${selectedLang}&search=${search}';

      final response = await dio.get(
        apiUrl,
      );

      final data = response.data;
      booksList = [];
      print(data);
      data.forEach((el) {
        Books books = Books.fromJson(el);
        booksList.add(books);
      });

      isLoading(false);
      update();
    } catch (error) {
      isLoading(false);
      update();
      print('Error: $error');
    }
  }
}
