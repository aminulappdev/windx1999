
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class BlockConditionRow extends StatelessWidget {
  final IconData iconData;
  final String title;
  const BlockConditionRow({
    super.key,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.white,
        ),
        widthBox8,
        SizedBox(
          width: 300.h,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}