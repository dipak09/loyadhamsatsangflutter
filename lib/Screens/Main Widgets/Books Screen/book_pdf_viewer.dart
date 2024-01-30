// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key? key, required this.url, this.title})
      : super(key: key);

  final String? url, title;
  

  @override

  Widget build(BuildContext context) {
   // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
    return Scaffold(
      appBar: CustomAppBar(title: title),
      // body: SfPdfViewer.network(
      //   url!,
      //   key: _pdfViewerKey,
      // ),
      // PDF(
      //   enableSwipe: true,
      //   //swipeHorizontal: true,
      //   autoSpacing: false, pageFling: false,
      // ).fromUrl(
      //   url!,
      //   placeholder: (double progress) => Center(child: Text('$progress %')),
      //   errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      // ),
    );
  }
}
