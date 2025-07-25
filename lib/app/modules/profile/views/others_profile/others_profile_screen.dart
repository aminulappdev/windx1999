import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/controllers/add_chat_controller.dart';
import 'package:windx1999/app/modules/chat/controllers/all_friend_controller.dart';
import 'package:windx1999/app/modules/chat/views/chat_screen.dart';
import 'package:windx1999/app/modules/homepage/controller/follow_request_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/unFollow_request_controller.dart';
import 'package:windx1999/app/modules/homepage/views/botton_sheet_screen.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/others_profile_controller.dart';
import 'package:windx1999/app/modules/profile/views/others_profile/others_post_gallery.dart';
import 'package:windx1999/app/modules/profile/views/others_profile/others_profile_product.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/block_user.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/report_screen.dart';
import 'package:windx1999/app/modules/profile/views/followers_screen.dart';
import 'package:windx1999/app/modules/profile/views/following_screen.dart';
import 'package:windx1999/app/modules/profile/widgets/profile_bar_icon.dart';
import 'package:windx1999/app/modules/profile/widgets/quantity_details_widget.dart';
import 'package:windx1999/app/res/common_widgets/circle_aveture_icon.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/rectangle_button_with_icon.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class OthersProfileScreen extends StatefulWidget {
  final String userId;
  const OthersProfileScreen({super.key, required this.userId});

  @override
  State<OthersProfileScreen> createState() => _OthersProfileScreenState();
}

class _OthersProfileScreenState extends State<OthersProfileScreen> {
  bool showProductList = true;

  AddChatController addChatController = Get.put(AddChatController());
  AllPostController allPostController = Get.put(AllPostController());
  final OthesrProfileController othersProfileController =
      Get.put(OthesrProfileController());
  final FollowRequestController followRequestController =
      FollowRequestController();
  final UnFollowRequestController unFollowRequestController =
      UnFollowRequestController();
  final FriendController allFriendsChatnCtrl = Get.put(FriendController());

  String? chatId;
  String? receiverId;
  String? receiverName;
  String? receiverImage;

  @override
  void initState() {
    super.initState();
    othersProfileController.getOthersProfile(widget.userId);
    // Fetch friends and update chat details
    allFriendsChatnCtrl.getAllFriends().then((_) {
      setState(() {
        _updateChatDetails();
      });
    });
  }

  void _updateChatDetails() {
    for (var element in allFriendsChatnCtrl.friendList) {
      if (element.chat?.participants[0].id == widget.userId) {
        receiverId = element.chat?.participants[0].id.toString();
        chatId = element.chat?.id.toString();
        receiverName = element.chat?.participants[0].name;
        receiverImage = element.chat?.participants[0].photoUrl;
        print('Chat ID: $chatId');
        print('Receiver ID: $receiverId');
        return;
      }
    }
    // If no chat is found, reset values
    chatId = null;
    receiverId = widget.userId;
    receiverName = othersProfileController.otherProfileData?.name ?? '';
    receiverImage = othersProfileController.otherProfileData?.photoUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomBackground(
        child: Obx(() {
          if (allFriendsChatnCtrl.inProgress.value ||
              othersProfileController.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200.h,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          othersProfileController.otherProfileData?.banner ??
                              'https://fastly.picsum.photos/id/17/200/300.jpg?hmac=a_Eowf7JMfHVEQi6MENyokjh5hhzVOqoXH6pUXxYKtU',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 40.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvetareIconWidget(
                            iconData: Icons.arrow_back,
                            bgColor: const Color.fromARGB(133, 255, 255, 255),
                            iconColor: Colors.white,
                            ontap: () {
                              Get.back();
                            },
                          ),
                          CircleAvetareIconWidget(
                            iconData: Icons.more_vert,
                            bgColor: const Color.fromARGB(133, 255, 255, 255),
                            iconColor: Colors.white,
                            ontap: () {
                              showModalBottomSheet(
                                scrollControlDisabledMaxHeightRatio: 0.6,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                backgroundColor: const Color(0xffA96CFF),
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ButtonSheetDetailsScreen(
                                        buttonSheetDetailsList: [
                                          {
                                            'icon': Icons.person_remove,
                                            'name': 'Block User',
                                            'ontap': () {
                                              Get.to(BlockUserScreen(
                                                userId: othersProfileController
                                                        .otherProfileData?.id ??
                                                    '',
                                                userName:
                                                    othersProfileController
                                                            .otherProfileData
                                                            ?.name ??
                                                        '',
                                                userImage: othersProfileController
                                                        .otherProfileData
                                                        ?.photoUrl ??
                                                    'https://fastly.picsum.photos/id/17/200/300.jpg?hmac=a_Eowf7JMfHVEQi6MENyokjh5hhzVOqoXH6pUXxYKtU',
                                              ));
                                            },
                                          },
                                          {
                                            'icon': Icons.sms_outlined,
                                            'name': 'Report Profile',
                                            'ontap': () {
                                              Get.to(ReportScreen(
                                                reportType: 'User',
                                                reportId:
                                                    othersProfileController
                                                            .otherProfileData
                                                            ?.id ??
                                                        '',
                                              ));
                                            },
                                          },
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40.h,
                    left: 150.h,
                    child: Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        image: DecorationImage(
                          image: NetworkImage(
                            othersProfileController
                                    .otherProfileData?.photoUrl ??
                                'https://fastly.picsum.photos/id/17/200/300.jpg?hmac=a_Eowf7JMfHVEQi6MENyokjh5hhzVOqoXH6pUXxYKtU',
                          ),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              heightBox8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QuantityDetailsWidget(
                    quantity: othersProfileController
                            .otherProfileData?.followers
                            .toString() ??
                        '0',
                    title: 'Followers',
                    titleSize: 14,
                    quantitySize: 16,
                    ontap: () {
                      Get.to(FollowersScreen(
                        isMyPage: false,
                        userId: othersProfileController.otherProfileData!.id!,
                      ));
                    },
                  ),
                  QuantityDetailsWidget(
                    quantity: othersProfileController
                            .otherProfileData?.following
                            .toString() ??
                        '0',
                    title: 'Following',
                    titleSize: 14,
                    quantitySize: 16,
                    ontap: () {
                      Get.to(FollowingScreen(
                        isMyPage: false,
                        userId: othersProfileController.otherProfileData!.id!,
                      ));
                    },
                  ),
                ],
              ),
              heightBox8,
              StraightLiner(),
              heightBox16,
              Text(
                othersProfileController.otherProfileData?.name ?? '',
                style: TextStyle(
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              heightBox8,
              SizedBox(
                width: 300.w,
                child: Text(
                  othersProfileController.otherProfileData?.bio ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RectangleButtonWithIcon(
                    height: 38,
                    width: 170,
                    iconData:
                        othersProfileController.otherProfileData?.isFollowing ==
                                true
                            ? Icons.person_remove
                            : Icons.person_add,
                    iconSize: 24,
                    iconColor: Colors.white,
                    title:
                        othersProfileController.otherProfileData?.isFollowing ==
                                true
                            ? 'Following'
                            : 'Follow',
                    titleSize: 14,
                    titleColor: Colors.white,
                    space: widthBox8,
                    ontap: () {
                      othersProfileController.otherProfileData?.isFollowing ==
                              true
                          ? unFollowRequest(
                              othersProfileController.otherProfileData?.id ??
                                  '')
                          : followRequest(
                              othersProfileController.otherProfileData?.id ??
                                  '');
                    },
                    borderRadius: 10,
                  ),
                  RectangleButtonWithIcon(
                    height: 38,
                    width: 170,
                    iconData: Icons.sms,
                    iconSize: 24,
                    iconColor: Colors.white,
                    title: 'Message',
                    titleSize: 14,
                    titleColor: Colors.white,
                    space: widthBox8,
                    ontap: () async {
                      if (chatId == null) {
                        // No existing chat, create a new one
                        await addChatFriend(
                          userId: StorageUtil.getData(StorageUtil.userId),
                          friendId: widget.userId,
                        );
                        // Refresh friend list after creating a new chat
                        await allFriendsChatnCtrl.getAllFriends();
                        setState(() {
                          _updateChatDetails();
                        });
                      }
                      Get.to(ChatScreen(
                        chatId: chatId ?? '',
                        receiverId: receiverId ?? widget.userId,
                        receiverName: receiverName ??
                            othersProfileController.otherProfileData?.name ??
                            '',
                        receiverImage: receiverImage ??
                            othersProfileController
                                .otherProfileData?.photoUrl ??
                            '',
                      ));
                    },
                    borderRadius: 10,
                  ),
                ],
              ),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileBarIcon(
                    showProductList: showProductList,
                    ontap: () {
                      setState(() {
                        showProductList = true;
                      });
                    },
                    iconData: Icons.task_outlined,
                    isSelected: showProductList,
                  ),
                  ProfileBarIcon(
                    showProductList: showProductList,
                    ontap: () {
                      setState(() {
                        showProductList = false;
                      });
                    },
                    iconData: Icons.photo,
                    isSelected: !showProductList,
                  ),
                ],
              ),
              heightBox12,
              othersProfileController.otherProfileData?.profilePublic == true
                  ? SizedBox(
                      height: 100.h,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          widthBox8,
                          const Text(
                            'This account is private',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: showProductList
                          ? OthersProfileProduct(
                              userId: othersProfileController
                                      .otherProfileData?.id ??
                                  '')
                          : OthersPostGallery(
                              userId: othersProfileController
                                      .otherProfileData?.id ??
                                  ''),
                    ),
            ],
          );
        }),
      ),
    );
  }

  Future<void> followRequest(String friendId) async {
    final bool isSuccess =
        await followRequestController.followRequest(friendId);
    if (isSuccess) {
      // Re-fetch the profile to get the updated follow status
      await othersProfileController.getOthersProfile(friendId);

      // Alternative: Update follow status locally (uncomment to use instead of re-fetching)
      // othersProfileController.updateFollowStatus(true);

      await addChatFriend(
          userId: StorageUtil.getData(StorageUtil.userId) ?? '',
          friendId: friendId);
      print('Follow successfully completed');
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

  Future<void> unFollowRequest(String friendId) async {
    final bool isSuccess =
        await unFollowRequestController.unfollowRequest(friendId);
    if (isSuccess) {
      // Re-fetch the profile to get the updated follow status
      await othersProfileController.getOthersProfile(friendId);

      // Alternative: Update follow status locally (uncomment to use instead of re-fetching)
      // othersProfileController.updateFollowStatus(false);

      print('Unfollow successfully completed');
      if (mounted) {
        showSnackBarMessage(context, 'Unfollow successfully completed');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            unFollowRequestController.errorMessage ?? 'Failed to unfollow',
            true);
      }
    }
  }

  Future<void> addChatFriend(
      {required String userId, required String friendId}) async {
    final bool isSuccess = await addChatController.addChat(userId, friendId);
    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Added new chat');
      }
    }
  }
}
