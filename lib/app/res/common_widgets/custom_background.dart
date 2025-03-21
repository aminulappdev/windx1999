import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/res/app_colors/app_colors.dart';

// ignore: must_be_immutable
class CustomBackground extends StatelessWidget {
  CustomBackground({
    super.key,
    required this.child,
  });

  final Widget child;
  ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GetBuilder<ThemeController>(builder: (controller) {
      return Container(
          height: height,
          width: width,
          decoration: controller.isDarkMode == true
              ? BoxDecoration(
                 color: Colors.black
                )
              : BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppColors.gradiantColors),
                ),
          child: child);
    });
  }
}
