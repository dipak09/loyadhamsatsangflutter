import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageWithShimmer extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  CachedImageWithShimmer(
      {required this.imageUrl,
      this.width = 200,
      this.height = 200,
      this.fit = BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Shimmer.fromColors(
        highlightColor: Colors.grey[300]!,
        baseColor: Colors.grey[200]!,
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
