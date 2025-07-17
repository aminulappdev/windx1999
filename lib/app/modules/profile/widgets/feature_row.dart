import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
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
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => Container(
          height: 48.h,
          width: 330.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: themeController.isDarkMode ? Colors.grey[800] : Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.notoSansMyanmar(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: themeController.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                ToggleButton(
                  isToggled: title == 'Dark mode' ? themeController.isDarkMode : false,
                  onToggle: onToggle,
                ),
              ],
            ),
          ),
        ));
  }
}