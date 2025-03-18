
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ShareOption extends StatelessWidget {
  final Color bgColor;
  final IconData? icon;
  final String? imagePath;
  final String title;
  final VoidCallback ontap;
  
  const ShareOption({
    super.key,
    this.imagePath,
    required this.title,
    required this.ontap,
    this.icon,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: bgColor,
            radius: 20.r,
            backgroundImage: imagePath != null ? AssetImage(imagePath!) : null,
            child: imagePath == null ? Icon(icon ?? Icons.error, color: Colors.black) : null,
          ),
          heightBox5,
          Text(
            title,
            style: TextStyle(fontSize: 12.h,fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}