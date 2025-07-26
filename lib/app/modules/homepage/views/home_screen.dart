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
import 'package:windx1999/app/modules/homepage/views/comment_screen.dart';
import 'package:windx1999/app/modules/homepage/views/botton_sheet_screen.dart';
import 'package:windx1999/app/modules/homepage/views/notification_screen.dart';
import 'package:windx1999/app/modules/homepage/views/search_screen.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/block_user.dart';
import 'package:windx1999/app/modules/profile/views/others_profile/others_profile_screen.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/report_screen.dart';
import 'package:windx1999/app/modules/profile/views/profile_screen.dart';
import 'package:windx1999/app/modules/token/views/token_bar.dart';
import 'package:windx1999/app/modules/wishlist/views/show_wishlist_screen.dart';
import 'package:windx1999/app/res/common_widgets/circle_icon_transparent.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/date_time_formate_class.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  // New: Added ScrollController
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allPostController.getAllPost();
      profileController.getMyProfile();
    });
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !allPostController.inProgress) {
      print('Load more data');
      allPostController.getAllPost();
    }
    {
      allPostController.getAllPost();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (controller) {
      return Scaffold(
        body: CustomBackground(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.h, vertical: 20),
            child: Column(
              children: [
                heightBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 40.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(116, 255, 255, 255),
                      ),
                      child:
                          GetBuilder<ProfileController>(builder: (pController) {
                        if (pController.inProgress) {
                          return Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            Get.to(TokenBar());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.token_rounded,
                                size: 26.h,
                                color: controller.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              Text(
                                pController.profileData?.tokenAmount
                                        .toString() ??
                                    '0',
                                style: TextStyle(
                                  color: controller.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    widthBox10,
                    CircleIconTransparent(
                      icon: Icons.notifications,
                      fillColor: Color.fromARGB(116, 255, 255, 255),
                      iconColor: Colors.white,
                      iconSize: 30.h,
                      ontap: () {
                        Get.to(NotificationScreen());
                      },
                      radius: 40.r,
                    ),
                    widthBox10,
                    CircleIconTransparent(
                      icon: Icons.search,
                      fillColor: Color.fromARGB(116, 255, 255, 255),
                      iconColor: Colors.white,
                      iconSize: 30.h,
                      ontap: () {
                        Get.to(SearchScreen());
                      },
                      radius: 40.r,
                    ),
                  ],
                ),
                heightBox12,
                Expanded(
                  child: GetBuilder<AllPostController>(
                    builder: (allPostController) {
                      if (allPostController.inProgress &&
                          allPostController.page == 1) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (allPostController.postList == null ||
                          allPostController.postList!.isEmpty) {
                        return Center(child: Text('No posts available'));
                      }
                      return ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        itemCount: allPostController.postList?.length ?? 0,
                        itemBuilder: (context, index) {
                          final post = allPostController.postList![index];
                          final dateFormatter =
                              DateFormatter(post.createdAt ?? DateTime.now());
                          return post.isHide == false
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: PostCard(
                                    isLiked:
                                        post.isLiked == true ? true : false,
                                    aboutProfileTap: () {
                                      Get.to(post.author?.id ==
                                              StorageUtil.getData(
                                                  StorageUtil.userId)
                                          ? ProfileScreen()
                                          : OthersProfileScreen(
                                              userId: post.author?.id ?? ''));
                                    },
                                    reactOntap: () {
                                      post.isLiked == true
                                          ? disReactPost(post.contentMeta!.id!)
                                          : reactPost(post.contentMeta!.id!);
                                    },
                                    iSVisibleWishlist:
                                        post.contentType == 'wishlist',
                                    bgColor: controller.isDarkMode
                                        ? Color(0xffAFAFAF)
                                        : Color(0xffAF7CF8),
                                    name: post.author?.name ?? 'Unknown',
                                    profilePath: post.author?.photoUrl ??
                                        'https://fastly.picsum.photos/id/1/200/300.jpg',
                                    activeStatus:
                                        dateFormatter.getRelativeTimeFormat(),
                                    addFriendOnTap: () {},
                                    wishListOnTap: () {
                                      Get.to(ShowWishlistScreen(
                                          wishlistId: post.id ?? ''));
                                    },
                                    moreVertOntap: () {
                                      showModalBottomSheet(
                                        scrollControlDisabledMaxHeightRatio:
                                            0.6,
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
                                                    'icon':
                                                        Icons.visibility_off,
                                                    'name': 'Hide post',
                                                    'ontap': () {
                                                      hidePost(
                                                          post.id ?? '',
                                                          post.contentType ??
                                                              '');
                                                    }
                                                  },
                                                  {
                                                    'icon': post.isFollowing ==
                                                            true
                                                        ? Icons.person_remove
                                                        : Icons.person_add,
                                                    'name':
                                                        post.isFollowing == true
                                                            ? 'Unfollow'
                                                            : 'Follow',
                                                    'ontap': () {
                                                      if (post.isFollowing ==
                                                          true) {
                                                        unFollowRequest(
                                                            post.author?.id ??
                                                                '');
                                                      } else {
                                                        followRequest(
                                                            post.author?.id ??
                                                                '');
                                                      }
                                                    }
                                                  },
                                                  {
                                                    'icon': Icons.person_off,
                                                    'name': 'Block',
                                                    'ontap': () {
                                                      Get.to(
                                                          () => BlockUserScreen(
                                                                userId: post
                                                                        .author
                                                                        ?.id ??
                                                                    '',
                                                                userName: post
                                                                        .author
                                                                        ?.name ??
                                                                    '',
                                                                userImage: post
                                                                        .author
                                                                        ?.photoUrl ??
                                                                    '',
                                                              ));
                                                    }
                                                  },
                                                  {
                                                    'icon': Icons
                                                        .smart_display_outlined,
                                                    'name': 'Report Post',
                                                    'ontap': () {
                                                      Get.to(ReportScreen(
                                                          reportType: post
                                                                      .contentType ==
                                                                  'feed'
                                                              ? 'Feed'
                                                              : post.contentType ==
                                                                      'wishlist'
                                                                  ? 'Wishlist'
                                                                  : '',
                                                          reportId:
                                                              post.id ?? ''));
                                                    }
                                                  },
                                                  {
                                                    'icon': Icons.person,
                                                    'name': 'Report profile',
                                                    'ontap': () {
                                                      Get.to(ReportScreen(
                                                          reportType: 'User',
                                                          reportId:
                                                              post.author?.id ??
                                                                  ''));
                                                    }
                                                  },
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    text: post.description ?? '',
                                    comment:
                                        post.contentMeta?.comment.toString() ??
                                            '0',
                                    react: post.contentMeta?.like.toString() ??
                                        '0',
                                    share: post.contentMeta?.share.toString() ??
                                        '0',
                                    isSaved: post.isWatchLater ?? false,
                                    imagePath: post.content.isNotEmpty == true
                                        ? post.content[0]
                                        : null,
                                    bookmarkOntap: () {
                                      post.isWatchLater == true
                                          ? unSavePost(post.id ?? '')
                                          : savePost(
                                              StorageUtil.getData(
                                                      StorageUtil.userId) ??
                                                  '',
                                              post.contentType ?? '',
                                              post.id ?? '');
                                    },
                                    commentOnTap: () {
                                      Get.to(CommentScreen(
                                          postId: post.id ?? '',
                                          postType: post.contentType ?? ''));
                                    },
                                  ),
                                )
                              : Container();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
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
              ?.indexWhere((post) => post.contentMeta?.id == postId) ??
          -1;
      if (index != -1 && allPostController.postList != null) {
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
              ?.indexWhere((post) => post.contentMeta?.id == postId) ??
          -1;
      if (index != -1 && allPostController.postList != null) {
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
