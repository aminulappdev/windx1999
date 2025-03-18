import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/common/views/navigation_bar_screen.dart';
import 'package:windx1999/app/modules/profile/widgets/feature_row.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({super.key});

  @override
  State<UserPreferencesScreen> createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(title: 'User Preferences'),
                heightBox40,
                SvgPicture.asset(
                  AssetsPath.userPrefer,
                  height: 228.h,
                  width: 305.w,
                ),
                heightBox40,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FeatureRow(
                      title: 'Dark mode',
                      onToggle: (value) {},
                    ),
                    heightBox12,
                    FeatureRow(
                      title: 'Profile Public',
                      onToggle: (value) {},
                    ),
                    heightBox12,
                    FeatureRow(
                      title: 'Personalized Ads',
                      onToggle: (value) {},
                    )
                  ],
                ),
                heightBox24,
                ElevatedButton(
                    onPressed: () {
                      Get.to(BottomNavBarScreen());
                    },
                    child: Text('Save Preferences'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
