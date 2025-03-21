
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultCheker extends StatelessWidget {
  const DefaultCheker({
    super.key,
    required this.isChecked,
    required this.ontap,
  });

  final bool isChecked;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: ontap,
                child: Container(
                  decoration: BoxDecoration(
                    color: isChecked ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: isChecked ? Colors.blue : Colors.white,
                      width: 1.w,
                    ),
                  ),
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    isChecked ? Icons.check : null,
                    color: Colors.white,
                    size: 8.h,
                  ),
                ),
              ),
              SizedBox(width: 16.h),
              Text(
                'Set as default audience',
                style: TextStyle(
                  fontSize: 12.h,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
