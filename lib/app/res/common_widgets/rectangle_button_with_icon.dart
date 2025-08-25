
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RectangleButtonWithIcon extends StatelessWidget {
  final double borderRadius;
  final double height;
  final double width;
  final Color bgColor;
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final String title;
  final double titleSize;
  final Color titleColor;

  final VoidCallback ontap;

  const RectangleButtonWithIcon({
    super.key,
    required this.height,
    required this.width,
    this.bgColor = Colors.blue,
    required this.iconData,
    required this.iconSize,
    required this.iconColor,
    required this.title,
    required this.titleSize,
    required this.titleColor,
  
    this.borderRadius = 12, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius.r), color: bgColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: iconSize.h,
              color: iconColor,
            ),
            
            Text(
              title,
              style: TextStyle(
                  fontSize: titleSize.sp,
                  fontWeight: FontWeight.w400,
                  color: titleColor),
            ),
          ],
        ),
      ),
    );
  }
}