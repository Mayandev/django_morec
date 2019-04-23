import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CoverImageView extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;


  CoverImageView(this.imgUrl, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
          image: CachedNetworkImageProvider(imgUrl),
          fit: BoxFit.cover,
          width: width,
          height: height,
      ),
    );
  }
}