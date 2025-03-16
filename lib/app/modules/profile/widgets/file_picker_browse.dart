
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class FilePickerBrowse extends StatelessWidget {
  final String mediaName;
  final IconData icon;
  final VoidCallback ontap;
  const FilePickerBrowse({
    super.key, required this.mediaName, required this.icon, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: 155.w,
          height: 180.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffD1EEFF),
                child:Icon(
                      Icons.photo,
                      color: const Color(0xff9C57FF),
                    ),
              ),
              heightBox4,
              Text(
                mediaName,
                style: TextStyle(
                    fontSize: 14.sp, color: Colors.grey),
              ),
              heightBox4,
              Text(
                'Browse',
                style: TextStyle(
                    fontSize: 16.sp, color: Color(0xff6CC7FE)),
              ),
            ],
          )),
    );
  }
}
