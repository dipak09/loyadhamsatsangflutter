import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerFromApi extends StatefulWidget {
  final String pdfUrl;

  PdfViewerFromApi(this.pdfUrl);

  @override
  _PdfViewerFromApiState createState() => _PdfViewerFromApiState();
}

class _PdfViewerFromApiState extends State<PdfViewerFromApi> {
  late PdfViewerController _pdfViewerController;
  List<int> _bookmarkedPages = [];

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _pdfViewerController.addListener(_handlePdfViewerController);
  }

  // Method to handle changes in the PdfViewerController
  void _handlePdfViewerController() {
    final currentPage = _pdfViewerController.pageNumber;
    setState(() {
      // Check if the current page is bookmarked
      if (_bookmarkedPages.contains(currentPage)) {
        // If bookmarked, remove it
        _bookmarkedPages.remove(currentPage);
      } else {
        // If not bookmarked, add it
        _bookmarkedPages.add(currentPage);
      }
    });
  }

  void toggleBookmark() {
    final currentPage = _pdfViewerController.pageNumber;
    setState(() {
      // Check if the current page is bookmarked
      if (_bookmarkedPages.contains(currentPage)) {
        // If bookmarked, remove it
        _bookmarkedPages.remove(currentPage);
      } else {
        // If not bookmarked, add it
        _bookmarkedPages.add(currentPage);
      }
    });
  }

  // Method to open the search view
  void openSearchView(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Search'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Enter search query',
            ),
            onChanged: (value) {
              // Implement logic to handle search query
              // You may update the search results dynamically as the user types
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement logic to perform search based on entered query
                // You can use _pdfViewerController to interact with the PDF viewer
                // For example: _pdfViewerController.searchText('query');
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed:
                toggleBookmark, // Toggle bookmark status when IconButton is pressed
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              openSearchView(
                  context); // Open search view when IconButton is pressed
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl,
        controller: _pdfViewerController,
      ),
    );
  }
}
