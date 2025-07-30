import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/controllers/add_chat_controller.dart';
import 'package:windx1999/app/modules/common/controllers/save_my_post_controller.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/dis_react_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/follow_request_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/hide_post_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/react_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/save_post_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/unFollow_request_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/un_saved_post_controller.dart';
import 'package:windx1999/app/modules/homepage/views/botton_sheet_screen.dart';
import 'package:windx1999/app/modules/homepage/views/comment_screen.dart';
import 'package:windx1999/app/modules/homepage/widgets/image_container.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_header.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/post/controller/post_details_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/profile/views/others_profile/others_profile_screen.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/block_user.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/report_screen.dart';
import 'package:windx1999/app/modules/profile/views/profile_screen.dart';
import 'package:windx1999/app/modules/wishlist/views/show_wishlist_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/date_time_formate_class.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class PostDetailsPage extends StatefulWidget {
  final String contentId;
  const PostDetailsPage({super.key, required this.contentId});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final PostDetailsController postDetailsController =
      Get.put(PostDetailsController());
  ThemeController themeController = Get.find<ThemeController>();
  AllPostController allPostController = Get.put(AllPostController());
  ProfileController profileController = Get.put(ProfileController());
  AddChatController addChatController = Get.put(AddChatController());

  final HidePostController hidePostController = HidePostController();
  final SavePostController savePostController = SavePostController();
  final FollowRequestController followRequestController =
      FollowRequestController();
  final UnFollowRequestController unFollowRequestController =
      UnFollowRequestController();
  final ReactPostController reactPostController = ReactPostController();
  final DisReactPostController disReactPostController =
      DisReactPostController();
  final UnSavedPostController unSavedPostController =
      Get.put(UnSavedPostController());
  final SaveAllPostController saveAllPostController =
      Get.put(SaveAllPostController());

  @override
  void initState() {
    postDetailsController.getPostDetails(widget.contentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PostDetailsController>(builder: (controller) {
        if (controller.inProgress == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final post = controller.postData;
        final dateFormatter = DateFormatter(post?.createdAt ?? DateTime.now());
        return GetBuilder<ThemeController>(builder: (themeContoller) {
          return CustomBackground(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  heightBox30,
                  CustomAppBar(title: 'Post details'),
                  heightBox10,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: themeContoller.isDarkMode
                          ? Color(0xffAFAFAF)
                          : Color(0xffAF7CF8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(post?.author?.id ==
                                      StorageUtil.getData(StorageUtil.userId)
                                  ? ProfileScreen()
                                  : OthersProfileScreen(
                                      userId: post?.author?.id ?? ''));
                            },
                            child: PostCardHeader(
                              isShowWishlist: post?.contentType == 'wishlist',
                              profilePath: post?.author?.photoUrl ??
                                  'https://fastly.picsum.photos/id/1/200/300.jpg',
                              name: post?.author?.name ?? 'Unknown',
                              addFriendOnTap: () {},
                              activeStatus:
                                  dateFormatter.getRelativeTimeFormat(),
                              wishListOnTap: () {
                                Get.to(ShowWishlistScreen(
                                    wishlistId: post?.id ?? ''));
                              },
                             
                            ),
                          ),
                          heightBox8,
                          Text(
                            post?.description ?? '',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.justify,
                          ),
                          heightBox12,
                          // ignore: unnecessary_null_comparison
                          post?.content.isNotEmpty == true
                              // ignore: unnecessary_null_comparison
                              ? post!.content[0] != null
                                  ? MediaContainer(
                                      mediaPath: post.content.isNotEmpty == true
                                          ? post.content[0]
                                          : '',
                                      height: 220.h,
                                      width: MediaQuery.of(context).size.width,
                                      borderColor: Colors.white,
                                      borderRadius: 12.r,
                                    )
                                  : Container()
                              : Container(),
                          heightBox8,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      }),
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

  Future<void> unFollowRequest(String friendId) async {
    final bool isSuccess =
        await unFollowRequestController.unfollowRequest(friendId);
    if (isSuccess) {
      allPostController.updateFollowStatus(friendId, false);
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

  Future<void> hidePost(String postId, String modelType) async {
    final bool isSuccess = await hidePostController.hidePost(postId, modelType);
    if (isSuccess) {
      allPostController.updatePostHide(postId, true);
      if (mounted) {
        // showSnackBarMessage(context, 'Post hidden successfully');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            hidePostController.errorMessage ?? 'Failed to hide post', true);
      }
    }
  }

  Future<void> savePost(
      String userId, String modelType, String contentId) async {
    final bool isSuccess =
        await savePostController.savePostF(userId, modelType, contentId);
    if (isSuccess) {
      saveAllPostController.getMySavePost();
      allPostController.updatePostSave(contentId, true);
      if (mounted) {
        showSnackBarMessage(context, 'Post saved successfully');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            savePostController.errorMessage ?? 'Failed to save post', true);
      }
    }
  }

  Future<void> unSavePost(String postId) async {
    final bool isSuccess =
        await unSavedPostController.unSavePost(postId: postId);

    if (isSuccess) {
      saveAllPostController.getMySavePost();
      allPostController.updatePostUnSave(postId, false);
      showSnackBarMessage(context, 'unsaved successfully done');
    } else {
      Get.snackbar(
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        'Failed',
        'Failed to delete account',
      );
    }
  }

  Future<void> reactPost(String postId) async {
    final bool isSuccess = await reactPostController.reactPost(postId);
    if (isSuccess) {
      int index = allPostController.postList
              .indexWhere((post) => post.contentMeta?.id == postId) ??
          -1;
      if (index != -1) {
        int currentLikes =
            allPostController.postList![index].contentMeta?.like ?? 0;
        allPostController.updatePostLike(postId, true, currentLikes + 1);
      }
      if (mounted) {
        // showSnackBarMessage(context, 'Like successfully completed');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            reactPostController.errorMessage ?? 'Failed to like', true);
      }
    }
  }

  Future<void> disReactPost(String postId) async {
    final bool isSuccess = await disReactPostController.disReactPost(postId);
    if (isSuccess) {
      int index = allPostController.postList
          .indexWhere((post) => post.contentMeta?.id == postId);
      if (index != -1) {
        int currentLikes =
            allPostController.postList![index].contentMeta?.like ?? 0;
        allPostController.updatePostLike(
            postId, false, currentLikes > 0 ? currentLikes - 1 : 0);
      }
      if (mounted) {
        // showSnackBarMessage(context, 'Dislike successfully completed');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            disReactPostController.errorMessage ?? 'Failed to dislike', true);
      }
    }
  }

  Future<void> addChatFriend(
      {required String userId, required String friendId}) async {
    final bool isSuccess = await addChatController.addChat(userId, friendId);
    if (isSuccess) {
      if (mounted) {
        // showSnackBarMessage(context, 'New chat added successfully');
        print(
            'Chat created successfully .............................................');
        print('FriendId: $friendId');
        print(
            'Chat created successfully .............................................');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            addChatController.errorMessage ?? 'Failed to add chat', true);
      }
    }
  }
}

