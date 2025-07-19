import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get_storage/get_storage.dart';

import 'package:windx1999/app/modules/onboarding/views/splash_screen.dart';
import 'package:windx1999/app/res/app_binder/controller_binder.dart';
import 'package:windx1999/app/res/app_colors/app_colors.dart';
import 'package:windx1999/app/services/socket/socket_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final SocketService socketService = Get.put(SocketService());
  await socketService.init();
  runApp(
    DevicePreview(
      enabled: false, 
      builder: (context) => ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            initialBinding: ControllerBinder(),
            debugShowCheckedModeBanner: false,
            title: "windx1999",
            home: SplashScreen(),
            theme: ThemeData(
              inputDecorationTheme: TextFormFieldDesign.inputDecorationTheme(),
              fontFamily: 'OpenSans',
              appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
              elevatedButtonTheme: ElevatedTheme.elevatedButtonThemeData(),
            ),
          );
        },
      ),
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
            Size(375.w, 48.h)), // Responsive button size
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