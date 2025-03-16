
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhiteElevatedButton extends StatelessWidget {

  final String name;
  final VoidCallback ontap;
  const WhiteElevatedButton({
    super.key, required this.name, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 48.h,
        width: 350.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Color(0xff9DD9FE))),
        child: Center(child: Text(name,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600),)),
      ),
    );
  }
}