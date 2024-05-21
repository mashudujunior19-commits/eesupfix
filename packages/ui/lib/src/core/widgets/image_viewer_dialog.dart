import 'package:flutter/material.dart';

class ImageViewerDialog extends StatelessWidget {
  const ImageViewerDialog({super.key, required this.image});
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: image,
    );
  }
}
