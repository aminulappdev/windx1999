import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBackground(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               heightBox20,
                  CustomAppBar(title: 'Followers'),
                heightBox12,
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage:
                                      AssetImage(AssetsPath.blackGirl),
                                ),
                                widthBox8,
                                Text(
                                  'Md Aminul',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            CustomRectangleButton(
                              bgColor: Colors.lightBlue,
                              height: 32,
                              width: 90,
                              radiusSize: 8,
                              text: 'Follow back',
                              ontap: () {},
                              textSize: 12,
                              borderColor: Colors.lightBlue,
                              textColor: Colors.white,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      
    );
  }
}
