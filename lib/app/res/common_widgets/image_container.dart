
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.borderColor,
  });

  final String? imagePath;
  final double height;
  final double width;
  final double borderRadius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(imagePath!), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor)),
    );
  }
}