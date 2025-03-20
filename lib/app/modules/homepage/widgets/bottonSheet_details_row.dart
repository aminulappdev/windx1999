import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ButtonSheetDetailsRow extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback ontap;
  const ButtonSheetDetailsRow({
    super.key,
    required this.icon,
    required this.name,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontap,
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: Colors.white,
              ),
              widthBox14,
              Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        heightBox4,
        StraightLiner()
      ],
    );
  }
}