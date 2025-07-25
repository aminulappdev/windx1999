import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/homepage/controller/unFollow_request_controller.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/all_following_controller.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class FollowingScreen extends StatefulWidget {
  final bool isMyPage;
  final String userId;
  const FollowingScreen(
      {super.key, required this.userId, required this.isMyPage});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  AllPostController allPostController = Get.put(AllPostController());
  final UnFollowRequestController unFollowRequestController =
      UnFollowRequestController();

  final AllFollowingController allFollowingController =
      Get.put(AllFollowingController());

  @override
  void initState() {
    super.initState();
    allFollowingController.getAllFollowing(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
              CustomAppBar(title: 'Following'),
              heightBox12,
              GetBuilder<AllFollowingController>(builder: (controller) {
                if (allFollowingController.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount:
                        allFollowingController.allFollowersData?.length ?? 0,
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
                                  backgroundImage: NetworkImage(controller
                                          .allFollowersData![index]
                                          .following
                                          ?.photoUrl ??
                                      'https://fastly.picsum.photos/id/51/200/300.jpg?hmac=w7933XDRbSqrql6BuyEfFBOeVsO60iU5N_OS5FbO6wQ'),
                                ),
                                widthBox8,
                                Text(
                                  controller.allFollowersData![index].following
                                          ?.name ??
                                      '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            widget.isMyPage
                                ? CustomRectangleButton(
                                    bgColor: Colors.white,
                                    height: 32,
                                    width: 82,
                                    radiusSize: 8,
                                    text: 'Unfollow',
                                    ontap: () {
                                      unFollowRequest(controller
                                              .allFollowersData![index]
                                              .following
                                              ?.id ??
                                          '');
                                    },
                                    textSize: 14,
                                    borderColor: Colors.white,
                                  )
                                : Opacity(
                                  opacity: 0.50,
                                  child: CustomRectangleButton(
                                      bgColor: Colors.white,
                                      height: 32,
                                      width: 82,
                                      radiusSize: 8,
                                      text: 'Unfollow',
                                      ontap: () {},
                                      textSize: 14,
                                      borderColor: Colors.white,
                                    ),
                                )
                          ],
                        ),
                      );
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> unFollowRequest(String frindId) async {
    final bool isSuccess =
        await unFollowRequestController.unfollowRequest(frindId);
    if (isSuccess) {
      allFollowingController.getAllFollowing(widget.userId);
      if (mounted) {
        showSnackBarMessage(context, 'Unfollow successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, unFollowRequestController.errorMessage ?? 'failed', true);
      }
    }
  }
}
