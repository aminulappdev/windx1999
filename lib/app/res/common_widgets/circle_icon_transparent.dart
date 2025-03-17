
import 'package:flutter/material.dart';

class CircleIconTransparent extends StatelessWidget {
  final double radius;
  final Color fillColor;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final VoidCallback ontap;
  const CircleIconTransparent({
    super.key,
    required this.radius,
    required this.fillColor,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: fillColor)),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
