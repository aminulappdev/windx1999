import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class IconWithReact extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback ontap;

  const IconWithReact({
    super.key,
    required this.icon,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: ontap,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30.h,
            )),
        heightBox5,
        Text(
          text,
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        )
      ],
    );
  }
}
