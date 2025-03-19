
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRectangleButton extends StatelessWidget {
  const CustomRectangleButton({
    super.key,
    required this.bgColor,
    required this.height,
    required this.width,
    required this.radiusSize,
    required this.text,
    this.borderColor = const Color(0xff6CC7FE),
     this.textSize = 18,
    this.textColor = const Color.fromARGB(255, 0, 0, 0), required this.ontap,
  });
  final Color borderColor;
  final Color bgColor;
  final double height;
  final double width;
  final double radiusSize;
  final String text;
  final Color textColor;
  final VoidCallback ontap;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(radiusSize),
            color: bgColor),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: textSize.sp, fontWeight: FontWeight.w600, color: textColor),
          ),
        ),
      ),
    );
  }
}
