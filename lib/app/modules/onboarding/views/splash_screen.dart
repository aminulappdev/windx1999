import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/onboarding/views/onboarding_view.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   @override
     void initState() {
    _movetoNewScreen();
    super.initState();
  }

  Future<void> _movetoNewScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.to(OnboardingView());
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      body:  Center(
        child: SvgPicture.asset(AssetsPath.mainLogo,height: 294.h,width: 223.w,fit: BoxFit.fill,)
      ),
    );
  }
}
