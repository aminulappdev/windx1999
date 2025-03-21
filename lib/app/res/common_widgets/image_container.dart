
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.borderColor,  this.child,
  });

  final String? imagePath;
  final double height;
  final double width;
  final double borderRadius;
  final Color borderColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(imagePath!), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(color: borderColor)),
    );
  }
}