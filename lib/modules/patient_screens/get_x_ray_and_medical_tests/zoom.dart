// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoomScreen extends StatelessWidget {
  final String imageUrl;

  const ImageZoomScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
      ),
    );
  }
}