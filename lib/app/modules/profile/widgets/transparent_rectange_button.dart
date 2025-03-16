
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class TransparentRectangleButton extends StatelessWidget {
  final VoidCallback ontap;
  const TransparentRectangleButton({
    super.key, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 48.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Color(0xff9C57FF)),
            color: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            widthBox4,
            Text(
              'Add more wishlist',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}