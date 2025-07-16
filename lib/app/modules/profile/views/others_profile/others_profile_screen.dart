import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Import GetX package for navigation
import 'package:windx1999/app/modules/chat/controllers/add_chat_controller.dart';
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
import 'package:windx1999/app/modules/profile/views/own_profile/post_gallery.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/profile_product.dart';
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

  // Moved inside the state class

  @override
  void initState() {
    othersProfileController.getOthersProfile(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: CustomBackground(
          child: GetBuilder<OthesrProfileController>(builder: (controller) {
            if (controller.inProgress) {
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
                              image: NetworkImage(controller
                                      .otherProfileData?.banner ??
                                  'https://fastly.picsum.photos/id/17/200/300.jpg?hmac=a_Eowf7JMfHVEQi6MENyokjh5hhzVOqoXH6pUXxYKtU'),
                              fit: BoxFit.fill)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 30.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvetareIconWidget(
                              iconData: Icons.arrow_back,
                              bgColor: Color.fromARGB(133, 255, 255, 255),
                              iconColor: Colors.white,
                              ontap: () {
                                Get.back();
                              },
                            ),
                            CircleAvetareIconWidget(
                              iconData: Icons.more_vert,
                              bgColor: Color.fromARGB(133, 255, 255, 255),
                              iconColor: Colors.white,
                              ontap: () {
                                showModalBottomSheet(
                                  scrollControlDisabledMaxHeightRatio: 0.6,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  backgroundColor: Color(0xffA96CFF),
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
                                                  userId: controller
                                                          .otherProfileData
                                                          ?.id ??
                                                      '',
                                                  userName: controller
                                                          .otherProfileData!
                                                          .name ??
                                                      '',
                                                  userImage: controller
                                                          .otherProfileData!
                                                          .photoUrl ??
                                                      'https://fastly.picsum.photos/id/17/200/300.jpg?hmac=a_Eowf7JMfHVEQi6MENyokjh5hhzVOqoXH6pUXxYKtU',
                                                ));
                                              },
                                            },
                                            {
                                              'icon': Icons.sms_outlined,
                                              'name': 'Report Profile',
                                              'ontap': () {
                                                Get.to(ReportScreen(
                                                  reportId: controller
                                                          .otherProfileData
                                                          ?.id ??
                                                      '',
                                                ));
                                              },
                                            },
                                          ],
                                        )
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
                                image: NetworkImage(controller
                                        .otherProfileData?.photoUrl ??
                                    'https://fastly.picsum.photos/id/17/200/300.jpg?hmac=a_Eowf7JMfHVEQi6MENyokjh5hhzVOqoXH6pUXxYKtU'),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
                heightBox8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    QuantityDetailsWidget(
                      quantity:
                          controller.otherProfileData?.followers.toString() ??
                              '0',
                      title: 'Followers',
                      titleSize: 14,
                      quantitySize: 16,
                      ontap: () {
                        Get.to(FollowersScreen());
                      },
                    ),
                    QuantityDetailsWidget(
                      quantity:
                          controller.otherProfileData?.following.toString() ??
                              '0',
                      title: 'Following',
                      titleSize: 14,
                      quantitySize: 16,
                      ontap: () {
                        Get.to(FollowingScreen());
                      },
                    ),
                  ],
                ),
                heightBox8,
                StraightLiner(),
                heightBox16,
                Text(
                  controller.otherProfileData?.name ?? '',
                  style: TextStyle(
                      fontSize: 18.h,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                heightBox8,
                SizedBox(
                  width: 300.w,
                  child: Text(
                    controller.otherProfileData?.bio ?? '',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
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
                      iconData: controller.otherProfileData?.isFollowing == true
                          ? Icons.person_remove
                          : Icons.person_add,
                      iconSize: 24,
                      iconColor: Colors.white,
                      title: controller.otherProfileData?.isFollowing == true
                          ? 'Following'
                          : 'Follow',
                      titleSize: 14,
                      titleColor: Colors.white,
                      space: widthBox8,
                      ontap: () {
                        controller.otherProfileData?.isFollowing == true
                            ? unFollowRequest(
                                controller.otherProfileData?.id ?? '')
                            : followRequest(
                                controller.otherProfileData?.id ?? '');
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
                      ontap: () {
                        Get.to(ChatScreen(
                          chatId: '',
                          receiverId: '',
                          receiverName: '',
                          receiverImage: '',
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
                Expanded(
                    child: showProductList
                        ? OthersProfileProduct(
                            userId: controller.otherProfileData?.id ?? '')
                        : OthersPostGallery(
                            userId: controller.otherProfileData?.id ?? ''))
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<void> followRequest(String frindId) async {
    final bool isSuccess = await followRequestController.followRequest(frindId);
    if (isSuccess) {
      setState(() {
        othersProfileController.getOthersProfile(widget.userId);
      });
      allPostController.getAllPost();

      // allPostController.updateFollowStatus(frindId, true); // ✅ UI updated
      addChatTherapist(
          userId: StorageUtil.getData(StorageUtil.userId), friendId: frindId);
      if (mounted) {
        showSnackBarMessage(context, 'Follow successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, followRequestController.errorMessage ?? 'failed', true);
      }
    }
  }

  Future<void> unFollowRequest(String frindId) async {
    final bool isSuccess =
        await unFollowRequestController.unfollowRequest(frindId);
    if (isSuccess) {
      setState(() {
        othersProfileController.getOthersProfile(widget.userId);
      });
      allPostController.getAllPost();
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

  Future<void> addChatTherapist(
      {required String userId, required String friendId}) async {
    final bool isSuccess = await addChatController.addChat(userId, friendId);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Added new chat');
        print(
            'Chat create hoye geche .............................................');
        print('FriendId id :  $friendId');
        print(
            'Chat create hoye gec профe .............................................');
      } else {
        if (mounted) {
          showSnackBarMessage(context, addChatController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        // print('Error show ----------------------------------');
        showSnackBarMessage(
            context, addChatController.errorMessage ?? 'Ekhanei problem', true);
      }
    }
  }
}
