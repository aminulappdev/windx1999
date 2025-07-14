import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:windx1999/app/modules/common/views/navigation_bar_screen.dart';
import 'package:windx1999/app/modules/homepage/controller/block_user_controller.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/profile/widgets/block_condition_row.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class BlockUserScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userImage;
  const BlockUserScreen(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userImage});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {
  final BlockUserController blockUserController = BlockUserController();
  AllPostController allPostController = Get.put(AllPostController());

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
                  backgroundImage: NetworkImage(widget.userImage),
                ),
              ),
              heightBox14,
              Text(
                'Block ${widget.userName}?',
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
                onPressed: blockUser,
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

  Future<void> blockUser() async {
    final bool isSuccess = await blockUserController.blockUser(widget.userId);
    if (isSuccess) {
      allPostController.getAllPost();
      if (mounted) {
        showSnackBarMessage(context, 'Block successfully done');
        Get.to(BottomNavBarScreen());
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, blockUserController.errorMessage ?? 'failed', true);
      }
    }
  }
}
