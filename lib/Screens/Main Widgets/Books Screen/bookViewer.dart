import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerFromApi extends StatefulWidget {
  final String pdfUrl;

  PdfViewerFromApi(this.pdfUrl);

  @override
  _PdfViewerFromApiState createState() => _PdfViewerFromApiState();
}

class _PdfViewerFromApiState extends State<PdfViewerFromApi> {
  late PdfViewerController _pdfViewerController;
  var _pdfDocument;
  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    print(widget.pdfUrl.toString());

//    loadPdf();
  }

  // void loadPdf() async {
  //   final document = await PDFDocument.fromURL(widget.pdfUrl);
  //   setState(() {
  //     _pdfDocument = document;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
    // ignore: no_leading_underscores_for_local_identifiers
    OverlayEntry? _overlayEntry;
    // ignore: no_leading_underscores_for_local_identifiers
    void _showContextMenu(
        BuildContext context, PdfTextSelectionChangedDetails details) {
      final OverlayState overlayState = Overlay.of(context);
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: details.globalSelectedRegion!.center.dy - 55,
          left: details.globalSelectedRegion!.bottomLeft.dx,
          child: ElevatedButton(
            onPressed: () {
              if (details.selectedText != null) {
                Clipboard.setData(ClipboardData(text: details.selectedText!));
                // ignore: avoid_print
                print('Text copied to clipboard: ${details.selectedText}');
                _pdfViewerController.clearSelection();
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              )),
            ),
            child: const Text('Copy', style: TextStyle(fontSize: 17)),
          ),
        ),
      );
      overlayState.insert(_overlayEntry!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final List<PdfTextLine>? selectedTextLines =
                  _pdfViewerKey.currentState?.getSelectedTextLines();

              if (selectedTextLines != null && selectedTextLines.isNotEmpty) {
                // Creates a highlight annotation with the selected text lines.
                final HighlightAnnotation highlightAnnotation =
                    HighlightAnnotation(
                  textBoundsCollection: selectedTextLines,
                );
                // Adds the highlight annotation to the PDF document.
                _pdfViewerController.addAnnotation(highlightAnnotation);
              }
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl,
        scrollDirection: PdfScrollDirection.horizontal,
        // pageLayoutMode: PdfPageLayoutMode.single,
        // interactionMode: PdfInteractionMode.selection,
        onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
          if (details.selectedText == null && _overlayEntry != null) {
            _overlayEntry!.remove();
            _overlayEntry = null;
          } else if (details.selectedText != null && _overlayEntry == null) {
            _showContextMenu(context, details);
          }
        },
        controller: _pdfViewerController,
        key: _pdfViewerKey,
      ),
    );
  }
}
