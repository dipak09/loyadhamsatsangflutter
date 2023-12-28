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
  var pdfUrl = ''.obs;
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

  void searchBook(String item) {
    searchQuery.value = item;
    getBooks();
  }

  // loadPdfFromUrl(String url) {
  //   pdfUrl.value = url;
  // }

  @override
  void onInit() {
    super.onInit();
    getBooks();
  }

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
