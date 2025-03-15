
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  
  const CustomAppBar({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,)),
          Text(title,style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w600,color: Colors.white),),
          Container()
      ],
    );
  }
}