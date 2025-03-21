import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/authentication/views/log_in_screen.dart';
import 'package:windx1999/app/modules/authentication/views/sign_up_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/white_elevated_button.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBackground(
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  heightBox100,
                  Text(
                    'Welcome to Zheto',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  heightBox12,
                  SizedBox(
                    // width: 320.w,
                    child: Text(
                      'Explore the world at your fingertips with our immersive table book app, where every page turn brings a new experience',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  heightBox40,
                  SvgPicture.asset(
                    AssetsPath.mainLogo,
                    height: 236.h,
                    width: 179.w,
                    fit: BoxFit.fill,
                  ),
                  heightBox50,
                  ElevatedButton(
                      onPressed: () {
                        Get.to(LogInScreen());
                      },
                      child: Text('Log in')),
                  heightBox12,
                  WhiteElevatedButton(
                    name: 'Create an Account',
                    ontap: () {
                      Get.to(SignUpScreen());
                    },
                  ),
                  heightBox12,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            'By signing up you confirm that you have read & agree to the our ',
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy ',
                            style: TextStyle(
                                fontSize: 10.sp, color: Color(0xff6CC7FE)),
                          ),
                          TextSpan(
                            text: 'and ',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          TextSpan(
                            text: 'Terms & conditions',
                            style: TextStyle(
                                fontSize: 10.sp, color: Color(0xff6CC7FE)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
