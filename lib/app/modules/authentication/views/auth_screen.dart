import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightBox100,
              SizedBox(
                width: 300.w,
                child: Text(
                  'Welcome to Zheto',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              heightBox12,
              SizedBox(
                width: 320.w,
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
                height: 236,
                width: 179,
                fit: BoxFit.fill,
              ),
              heightBox12,
              // ElevatedButton(onPressed: () {}, child: Text('Log in')),
              // heightBox8,
              // WhiteElevatedButton(
              //   name: 'Create an account',
              //   ontap: () {},
              // )
            ],
          ),
        ),
      ),
    );
  }
}
