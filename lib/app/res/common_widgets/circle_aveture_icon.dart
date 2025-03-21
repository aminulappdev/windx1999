
import 'package:flutter/material.dart';

class CircleAvetareIconWidget extends StatelessWidget {
  final Color bgColor;
  final Color iconColor;
  final double radius;
  final IconData iconData;
  final VoidCallback ontap;

  const CircleAvetareIconWidget({
    super.key,
    required this.bgColor,
    this.radius = 20,
    required this.iconData,
    required this.ontap,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: CircleAvatar(
          radius: radius,
          backgroundColor: bgColor,
          child: Icon(
            iconData,
            color: iconColor,
          )),
    );
  }
}