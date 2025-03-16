import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/onboarding/views/splash_screen.dart';
import 'package:windx1999/app/res/app_colors/app_colors.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "windx1999",
          home: SplashScreen(),
          theme: ThemeData(
              
              inputDecorationTheme: TextFormFieldDesign.inputDecorationTheme(),
              fontFamily: 'OpenSans',
              appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
              scaffoldBackgroundColor: Colors.transparent,
              elevatedButtonTheme: ElevatedTheme.elevatedButtonThemeData()),
              
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.gradiantColors,
                ),
              ),
              child: child,
            );
          },
        );
      },
    ),
  );
}

class ElevatedTheme {
  static ElevatedButtonThemeData elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
            fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        backgroundColor: AppColors.elevatedButtonColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
      ).copyWith(
        minimumSize: WidgetStateProperty.all(
            Size(375.w, 48.h)), // Wrap Size with MaterialStateProperty.all
      ),
    );
  }
}

class TextFormFieldDesign {
  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      hintStyle: const TextStyle(fontWeight: FontWeight.w300),
      fillColor: Colors.white,
      filled: true,
      border: inputBorder(),
      enabledBorder: inputBorder(),
      focusedBorder: inputBorder(),
      errorBorder: inputBorder(),
    );
  }
}

OutlineInputBorder inputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(16),
  );
}
