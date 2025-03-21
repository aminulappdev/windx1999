import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityDetailsWidget extends StatelessWidget {
  final String quantity;
  final String title;
  final double quantitySize;
  final double titleSize;
  final VoidCallback ontap;
  const QuantityDetailsWidget({
    super.key,
    required this.quantity,
    required this.title,
    required this.quantitySize,
    required this.titleSize,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Text(
            quantity,
            style: TextStyle(
                fontSize: quantitySize.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
