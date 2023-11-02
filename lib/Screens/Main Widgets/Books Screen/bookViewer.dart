import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfViewerFromApi extends StatefulWidget {
  final String pdfUrl;

  PdfViewerFromApi(this.pdfUrl);

  @override
  _PdfViewerFromApiState createState() => _PdfViewerFromApiState();
}

class _PdfViewerFromApiState extends State<PdfViewerFromApi> {
  PDFDocument? _pdfDocument;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  void loadPdf() async {
    final document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {
      _pdfDocument = document;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: _pdfDocument == null
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(document: _pdfDocument!),
    );
  }
}
