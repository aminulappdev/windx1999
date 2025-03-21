
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/common_widgets/toogle_button.dart';

class FeatureRow extends StatelessWidget {
  const FeatureRow({
    super.key,
    required this.title,
    required this.onToggle,
  });

  final String title;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 330.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
             title, 
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            ToggleButton(
              isToggled: false,
              onToggle: onToggle,
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:windx1999/app/res/common_widgets/toogle_button.dart';

// class FeatureRow extends StatelessWidget {
//   const FeatureRow({
//     super.key,
//     required this.title,
//     required this.onToggle,
//     this.isToggled = false, // টগল স্ট্যাটাস পাস করা হলো
//   });

//   final String title;
//   final ValueChanged<bool> onToggle;
//   final bool isToggled; // নতুন প্যারামিটার যুক্ত করা হলো

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48.h,
//       width: 330.w,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12), color: Colors.white),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
//             ),
//             ToggleButton(
//               isToggled: isToggled, // টগল স্ট্যাটাস সেট করা হলো
//               onToggle: onToggle,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

