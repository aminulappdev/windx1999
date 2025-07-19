import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/common/views/navigation_bar_screen.dart';
import 'package:windx1999/app/modules/profile/controllers/user_preference_controller.dart';
import 'package:windx1999/app/modules/profile/widgets/feature_row.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({super.key});

  @override
  State<UserPreferencesScreen> createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  ThemeController themeController = Get.find<ThemeController>();
  UserPreferenceController userPreferenceController =
      Get.put(UserPreferenceController());
  bool publicAds = false; // Local state for Profile Public
  bool personalizedAds = false; // Local state for Personalized Ads

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightBox20,
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
                      isToggled: themeController.isDarkMode,
                      onToggle: (value) {
                        themeController.themeMode(value);
                        themeController.update();
                        print('Dark mode: $value');
                      },
                    ),
                    heightBox12,
                    FeatureRow(
                      title: 'Profile Public',
                      isToggled: publicAds,
                      onToggle: (value) {
                        setState(() {
                          publicAds = value;
                        });
                        print('Profile Public: $value');
                      },
                    ),
                    heightBox12,
                    FeatureRow(
                      title: 'Personalized Ads',
                      isToggled: personalizedAds,
                      onToggle: (value) {
                        setState(() {
                          personalizedAds = value;
                        });
                        print('Personalized Ads: $value');
                      },
                    ),
                  ],
                ),
                heightBox24,
                ElevatedButton(
                  onPressed: () {
                    onTapToNextButton();
                  },
                  child: Text('Save Preferences'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    final bool isSuccess = await userPreferenceController.updateProfile(
      publicAds,
      personalizedAds,
    );

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Profile updated successfully');
        Get.to(() => BottomNavBarScreen());
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, userPreferenceController.errorMessage!, true);
      }
    }
  }
}
