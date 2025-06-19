
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class BuyTokenScreen extends StatelessWidget {
  final String token;
  final String price;
  final VoidCallback ontap;
  const BuyTokenScreen({
    super.key,
    required this.token,
    required this.price, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.all(8.0.h),
      child: InkWell(
        onTap: ontap,
        child: Container( 
          height: 60.h,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color.fromARGB(186, 108, 198, 254), Color(0xff9C57FF)],
            ),
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.token_rounded,
                      size: 30.h,
                      color: Colors.white,
                    ),
                    widthBox5,
                    Text(
                      '$token Token',
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 30.h,
                  color: Colors.white,
                ),
                Text(
                  price,
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
