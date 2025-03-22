import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatelessWidget {
  
  CustomSearchBar({
    super.key,
    
  });

  ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (controller) {
      return TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: controller.isDarkMode == true
                ? Color.fromARGB(255, 255, 255, 255)
                : Color.fromARGB(255, 0, 0, 0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
          hintText: 'Search',
          hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: controller.isDarkMode == true
                  ? Color.fromARGB(255, 255, 255, 255)
                  : Color.fromARGB(255, 0, 0, 0)),
          fillColor: Color.fromARGB(116, 255, 255, 255),
          filled: true,
          border: inputBorder(),
          enabledBorder: inputBorder(),
          focusedBorder: inputBorder(),
          errorBorder: inputBorder(),
        ),
      );
    });
  }
}

OutlineInputBorder inputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(50),
  );
}
