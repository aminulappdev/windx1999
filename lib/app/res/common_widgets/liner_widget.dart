import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Liner extends StatelessWidget {
  final String text;
  const Liner({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
             
              height: 1.5.h,
              color: Color.fromARGB(255, 193, 191, 191),
            ),
          ),
          Text(
            '  $text  ',
            style: TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.w500),
          ),
           Expanded(
            child: Container(
             
              height: 1.5.h,
              color: Color.fromARGB(255, 193, 191, 191),
            ),
          ),
        ],
      ),
    );
  }
}
