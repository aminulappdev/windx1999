
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ContinueElevatedButton extends StatelessWidget {
  final VoidCallback ontap;
  final String logoPath;
  const ContinueElevatedButton({
    super.key,
    required this.logoPath, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
  
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 48.h,
        width: 48.w,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10.r,
              child: Image.asset(
                logoPath,
                fit: BoxFit.fill,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
