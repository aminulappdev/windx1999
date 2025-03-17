import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:windx1999/app/modules/authentication/views/auth_screen.dart';
import 'package:windx1999/app/modules/common/views/navigation_bar_screen.dart';
import 'package:windx1999/app/modules/onboarding/views/page_view.dart';
import 'package:windx1999/app/res/app_colors/app_colors.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/white_elevated_button.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingPageView(
                  showBackButton: false,
                  imageWidth: 202,
                  imageHeight: 308,
                  onBoardingRow: false,
                  title: "Let’s Connect with Everyone in the World",
                  subtitle:
                      "we can share ideas, build relationships, and work together to create a more inclusive and understanding world.",
                  pageController: _pageController,
                  imagePath: AssetsPath.onBoarding01,
                ),
                OnboardingPageView(
                  showBackButton: false,
                  imageWidth: 202,
                  imageHeight: 308,
                  onBoardingRow: false,
                  title: "Everything You Can Do in the App",
                  subtitle:
                      "we can share ideas, build relationships, and work together to create a more inclusive and understanding world.",
                  pageController: _pageController,
                  imagePath: AssetsPath.onBoarding02,
                ),
                OnboardingPageView(
                  showBackButton: false,
                  imageWidth: 202,
                  imageHeight: 308,
                  onBoardingRow: false,
                  title: "Find Your friends and play together on social media",
                  subtitle:
                      "we can share ideas, build relationships, and work together to create a more inclusive and understanding world.",
                  pageController: _pageController,
                  imagePath: AssetsPath.onBoarding03,
                ),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 12.0.h,
                    dotWidth: 12.0.w,
                    spacing: 10.0,
                    dotColor: Colors.white,
                    activeDotColor: AppColors.elevatedButtonColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Get.to(AuthScreen());
                    }
                  },
                  child: Text(
                    'Next',
                  ),
                ),
                heightBox12,
                WhiteElevatedButton(
                  name: 'Skip',
                  ontap: () {
                    Get.to(BottomNavBarScreen());
                  },
                ),
                heightBox50
              ],
            ),
          )
        ],
      ),
    );
  }
}
