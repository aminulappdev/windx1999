import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Liner extends StatelessWidget {
  const Liner({
    super.key,
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
            '  Or continue with  ',
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
