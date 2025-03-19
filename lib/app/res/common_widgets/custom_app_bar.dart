import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showButton;
  final Color color;
  final Color textColor;
  final VoidCallback? ontap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showButton = false,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.ontap,
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
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        Text(
          title,
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        showButton
            ? InkWell(
                onTap: ontap,
                child: Container(
                  height: 32,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: color),
                  child: Center(
                    child: Text(
                      'Post',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: textColor),
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
