import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class OnboardingPageView extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final bool onBoardingRow;
  final bool showBackButton;
  final double imageHeight;
  final double imageWidth;
  final PageController pageController; 

  const OnboardingPageView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBoardingRow,
    required this.imageHeight,
    required this.showBackButton,
    required this.pageController, required this.imagePath, required this.imageWidth, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [         
          heightBox100,
          heightBox24,
          SvgPicture.asset(imagePath,height: imageHeight,width: imageWidth,),
          heightBox24,
          SizedBox(
            width: 300.w,
            child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'OpenSans', fontSize: 24.sp,fontWeight: FontWeight.w700,color: Colors.white),
                textAlign: TextAlign.center,
              ),
          ),   
          heightBox12,
             SizedBox(
            width: 320.w,
            child: Text(
                subtitle,
                style: TextStyle(
                    fontFamily: 'OpenSans', fontSize: 16.sp,fontWeight: FontWeight.w400,color: Colors.white),
                textAlign: TextAlign.center,
              ),
          ),  
        ],
      ),
    );
  }
}

