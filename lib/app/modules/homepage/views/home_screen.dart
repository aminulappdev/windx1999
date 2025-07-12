import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/controllers/add_chat_controller.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/dis_react_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/follow_request_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/hide_post_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/react_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/save_post_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/unFollow_request_controller.dart';
import 'package:windx1999/app/modules/homepage/views/comment_screen.dart';
import 'package:windx1999/app/modules/homepage/views/botton_sheet_screen.dart';
import 'package:windx1999/app/modules/homepage/views/notification_screen.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_shimmer.dart';
import 'package:windx1999/app/modules/wishlist/views/show_wishlist_screen.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/token/views/token_bar.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/circle_icon_transparent.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
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

  @override
  void initState() {
    allPostController.getAllPost();
    profileController.getMyProfile();
    super.initState();
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 40.h, width: 196.w, child: CustomSearchBar()),
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
                                  child: CircularProgressIndicator()));
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
                                    'e',
                                style: TextStyle(
                                  color: controller.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
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
                  ],
                ),
                heightBox12,
                Expanded(
                  child: GetBuilder<AllPostController>(
                      builder: (allPostController) {
                    if (allPostController.inProgress) {
                      return Center(child: CircularProgressIndicator());
                    } 
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allPostController.allPostData?.length ?? 0,
                      itemBuilder: (context, index) {
                         final post = allPostController.allPostData![index];
                        // print(post.isHide);
                        // if (allPostController.allPostData?[index].isHide ==
                        //     false) {
                        return post.isHide == false
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: PostCard(
                                  reactOntap: () {
                                    post.isLiked == true
                                        ? disReactPost(post.contentMeta!.id!)
                                        : reactPost(post.contentMeta!.id!);
                                  },
                                  iSVisibleWishlist:
                                      post.contentType == 'wishlist',
                                  bgColor: Color(0xffAF7CF8),
                                  name: post.author?.name ?? 'name',
                                  profilePath: post.author?.photoUrl ??
                                      'https://fastly.picsum.photos/id/1/200/300.jpg',
                                  activeStatus: '20m ago',
                                  addFriendOnTap: () {},
                                  wishListOnTap: () {
                                    Get.to(ShowWishlistScreen(
                                        wishlistId: post.id!));
                                  },
                                  moreVertOntap: () {
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
                                                  'icon': Icons.bookmark,
                                                  'name': 'Save post',
                                                  'ontap': () {
                                                    savePost(
                                                        post.author?.id ?? '',
                                                        post.contentType ?? '',
                                                        post.id ?? '');
                                                  }
                                                },
                                                {
                                                  'icon': Icons.visibility_off,
                                                  'name': 'Hide post',
                                                  'ontap': () {
                                                    hidePost(post.id ?? '',
                                                        post.contentType ?? '');
                                                  }
                                                },

                                                /// ✅ Updated: Follow/Unfollow Button Action
                                                {
                                                  'icon':
                                                      post.isFollowing == true
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
                                                  'ontap': () {}
                                                },
                                                {
                                                  'icon': Icons
                                                      .smart_display_outlined,
                                                  'name': 'Report profile',
                                                  'ontap': () {}
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
                                  react:
                                      post.contentMeta?.like.toString() ?? '0',
                                  share:
                                      post.contentMeta?.share.toString() ?? '0',
                                  // shareOntap: () {
                                  //   showModalBottomSheet(
                                  //     scrollControlDisabledMaxHeightRatio: 0.6,
                                  //     context: context,
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.vertical(
                                  //           top: Radius.circular(20)),
                                  //     ),
                                  //     backgroundColor: Color(0xffA96CFF),
                                  //     builder: (context) {
                                  //       return Column(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [ShareScreen()],
                                  //       );
                                  //     },
                                  //   );
                                  // },
                                  isSaved:
                                      post.isWatchLater == true ? true : false,
                                  imagePath: post.content.isNotEmpty
                                      ? post.content[0]
                                      : null,
                                  bookmarkOntap: () {
                                    savePost(post.author?.id ?? '',
                                        post.contentType ?? '', post.id ?? '');
                                  },
                                  commentOnTap: () {
                                    Get.to(CommentScreen());
                                  },
                                ),
                              )
                            : Container();
                        // }
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> followRequest(String frindId) async {
    final bool isSuccess = await followRequestController.followRequest(frindId);
    if (isSuccess) {
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

  Future<void> hidePost(String postId, String modelType) async {
    final bool isSuccess = await hidePostController.hidePost(postId, modelType);
    if (isSuccess) {
      allPostController.getAllPost();
      if (mounted) {
        showSnackBarMessage(context, 'Hide successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, hidePostController.errorMessage ?? 'failed', true);
      }
    }
  }

  Future<void> savePost(
      String userId, String modelType, String contentId) async {
    final bool isSuccess =
        await savePostController.savePostF(userId, modelType, contentId);
    if (isSuccess) {
      allPostController.getAllPost();
      if (mounted) {
        showSnackBarMessage(context, 'Hide successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, savePostController.errorMessage ?? 'failed', true);
      }
    }
  }

  Future<void> reactPost(String postId) async {
    final bool isSuccess = await reactPostController.reactPost(postId);
    if (isSuccess) {
      allPostController.getAllPost();
      if (mounted) {
        showSnackBarMessage(context, 'React successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, savePostController.errorMessage ?? 'failed', true);
      }
    }
  }

  Future<void> disReactPost(String postId) async {
    final bool isSuccess = await disReactPostController.disReactPost(postId);
    if (isSuccess) {
      allPostController.getAllPost();
      if (mounted) {
        showSnackBarMessage(context, 'Dis React successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, savePostController.errorMessage ?? 'failed', true);
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
            'Chat create hoye geche .............................................');
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

    // Navigator.pushNamed(context, MainButtonNavbarScreen.routeName);
  }

  @override
  void dispose() {
    allPostController.getAllPost();
    profileController.getMyProfile();
    super.dispose();
  }
}
