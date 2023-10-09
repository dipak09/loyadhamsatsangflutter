import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_images.dart';

class ImageViewer extends StatefulWidget {
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _imagePaths = [
    AppImages.slider1,
    AppImages.slider3,
    AppImages.slider2,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updatePage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (_currentPage < _imagePaths.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _imagePaths.length,
            onPageChanged: _updatePage,
            itemBuilder: (context, index) {
              return Image.asset(
                _imagePaths[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _previousPage,
              disabledColor: Colors.grey,
            ),
            Text('Image ${_currentPage + 1} of ${_imagePaths.length}'),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: _nextPage,
              disabledColor: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}
