import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/post/views/friend_except_screen.dart';


class PrivacyOption extends StatelessWidget {
  final String value;
  final String description;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final bool hasArrow;
  final IconData icon;

  const PrivacyOption({
    super.key,
    required this.value,
    required this.description,
    required this.groupValue,
    required this.onChanged,
    this.hasArrow = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              onChanged(value);
            },
            child: Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: groupValue == value ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: groupValue == value
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : null,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                icon,
                size: 30.h,
                color: Colors.white,
              ),
              title: Text(
                value,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                description,
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
              trailing: hasArrow
                  ? InkWell(
                      onTap: () {                     
                        Get.to(FriendExceptScreen());
                      },
                      child: Icon(Icons.arrow_forward_ios,
                          size: 16.sp, color: Colors.white),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
