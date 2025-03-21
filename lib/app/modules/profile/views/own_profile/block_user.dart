import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/modules/profile/widgets/block_condition_row.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBackground(
          child: Padding(
            padding: EdgeInsets.all(20.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                heightBox50,
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 40.r,
                    backgroundImage: AssetImage(AssetsPath.blackGirl),
                  ),
                ),
                heightBox14,
                Text(
                  'Block Muskan?',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                heightBox20,
                Text(
                  'This will also block any other accounts they may have or create in the future.',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                heightBox20,
                BlockConditionRow(
                  iconData: Icons.person_remove,
                  title:
                      'This will also block any other accounts they may have or create in the future.',
                ),
                heightBox14,
                BlockConditionRow(
                  iconData: Icons.notifications_off,
                  title:
                      'This will also block any other accounts they may have or create in the future.',
                ),
                heightBox20,
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Block',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      
    );
  }
}
