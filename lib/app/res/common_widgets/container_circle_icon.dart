
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerCircleIcon extends StatelessWidget {
  final IconData iconData;
  final Color bgColor;
  final Color iconColor;
  final double containerSize;
  final double iconSize;
  final Color borderColor;
  final VoidCallback ontap;

  const ContainerCircleIcon({
    super.key,
    required this.bgColor,
    required this.iconColor,
    required this.containerSize,
    this.iconSize = 22,
    required this.borderColor,
    required this.ontap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: containerSize.h,
        width: containerSize.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
            color: bgColor),
        child: Center(
          child: Icon(
            size: iconSize.h,
            iconData,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}