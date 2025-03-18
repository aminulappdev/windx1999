
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PostCardFoterFeature extends StatelessWidget {
  final IconData icon;
  final String quantity;
  final VoidCallback ontap;
  const PostCardFoterFeature({
    super.key,
    required this.icon,
    required this.quantity,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 28.h,
          ),
          widthBox4,
          Text(
            quantity,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          )
        ],
      ),
    );
  }
}