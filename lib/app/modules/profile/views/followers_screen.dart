import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/controllers/add_chat_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/follow_request_controller.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/all_followers_controller.dart';
import 'package:windx1999/app/modules/profile/views/others_profile/others_profile_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class FollowersScreen extends StatefulWidget {
  final String userId;
  final bool isMyPage;
  const FollowersScreen(
      {super.key, required this.userId, required this.isMyPage});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  final AllFollowersController allFollowersController =
      Get.put(AllFollowersController());
  AllPostController allPostController = Get.put(AllPostController());
  final FollowRequestController followRequestController =
      FollowRequestController();
  AddChatController addChatController = Get.put(AddChatController());

  @override
  void initState() {
    super.initState();
    allFollowersController.getAllFollowers(widget.userId);
  }

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
              GetBuilder<AllFollowersController>(builder: (controller) {
                if (controller.inProgress) {
                  return SizedBox(
                      height: 700,
                      child: const Center(child: CircularProgressIndicator()));
                } else if (controller.allFollowersData!.isEmpty) {
                  return SizedBox(
                      height: 700,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'No followers available',
                        style: TextStyle(color: Colors.white),
                      )));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.allFollowersData?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(OthersProfileScreen(
                                      userId: controller
                                              .allFollowersData![index]
                                              .follower!
                                              .id ??
                                          ''));
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20.r,
                                      backgroundImage: NetworkImage(controller
                                              .allFollowersData![index]
                                              .follower
                                              ?.photoUrl ??
                                          ''),
                                    ),
                                    widthBox8,
                                    Text(
                                      controller.allFollowersData![index]
                                              .follower!.name ??
                                          '',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              widget.isMyPage
                                  ? CustomRectangleButton(
                                      bgColor: Colors.lightBlue,
                                      height: 32,
                                      width: 90,
                                      radiusSize: 8,
                                      text: 'Follow back',
                                      ontap: () {
                                        followRequest(controller
                                            .allFollowersData![index]
                                            .follower!
                                            .id!);
                                      },
                                      textSize: 12,
                                      borderColor: Colors.lightBlue,
                                      textColor: Colors.white,
                                    )
                                  : Opacity(
                                      opacity: 0.5,
                                      child: CustomRectangleButton(
                                        bgColor: Colors.lightBlue,
                                        height: 32,
                                        width: 90,
                                        radiusSize: 8,
                                        text: 'Follow back',
                                        ontap: () {},
                                        textSize: 12,
                                        borderColor: Colors.lightBlue,
                                        textColor: Colors.white,
                                      ),
                                    )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> followRequest(String friendId) async {
    final bool isSuccess =
        await followRequestController.followRequest(friendId);
    if (isSuccess) {
      allPostController.updateFollowStatus(friendId, true);
      addChatFriend(
          userId: StorageUtil.getData(StorageUtil.userId) ?? '',
          friendId: friendId);
      if (mounted) {
        showSnackBarMessage(context, 'Follow successfully completed');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            followRequestController.errorMessage ?? 'Failed to follow', true);
      }
    }
  }

  Future<void> addChatFriend(
      {required String userId, required String friendId}) async {
    final bool isSuccess = await addChatController.addChat(userId, friendId);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Added new chat');
        print(
            'Chat create hoye geche .............................................');
        print('FriendId id :  $friendId');
        print(
            'Chat create hoye geche .............................................');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, addChatController.errorMessage ?? 'Ekhanei problem', true);
      }
    }
  }
}
