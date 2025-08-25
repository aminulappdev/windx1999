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
import 'package:windx1999/app/modules/homepage/widgets/image_container.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_footer.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_header.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/post/controller/post_details_controller.dart';
import 'package:windx1999/app/modules/post/model/post_details_model.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/profile/views/others_profile/others_profile_screen.dart';
import 'package:windx1999/app/modules/profile/views/profile_screen.dart';
import 'package:windx1999/app/modules/wishlist/views/show_wishlist_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/date_time_formate_class.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class PostDetailsPage extends StatefulWidget {
  final String contentType;
  final String contentId;
  const PostDetailsPage(
      {super.key, required this.contentId, required this.contentType});

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
          return const Center(
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
                          ? const Color(0xffAFAFAF)
                          : const Color(0xffAF7CF8),
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
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.justify,
                          ),
                          heightBox12,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PostCardFoterFeature(
                                icon: post?.isLiked == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                ontap: () {
                                  post?.isLiked == true
                                      ? disReactPost(
                                          post?.contentMeta!.id ?? '')
                                      : reactPost(post?.contentMeta!.id ?? '');
                                },
                                quantity:
                                    post?.contentMeta?.like.toString() ?? '0',
                              ),
                              PostCardFoterFeature(
                                icon: Icons.sms,
                                ontap: () {
                                  Get.to(CommentScreen(
                                      postId: widget.contentId,
                                      postType: widget.contentType));
                                },
                                quantity:
                                    post?.contentMeta?.comment.toString() ??
                                        '0',
                              ),
                            ],
                          ),
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

  // Future<void> savePost(String userId, String modelType, String contentId) async {
  //   final bool isSuccess =
  //       await savePostController.savePostF(userId, modelType, contentId);
  //   if (isSuccess) {
  //     saveAllPostController.getMySavePost();
  //     allPostController.updatePostSave(contentId, true);
  //     if (postDetailsController.postDetailsModel != null &&
  //         postDetailsController.postData?.contentMeta?.id == contentId) {
  //       // Create a new PostDetailsData object to avoid modifying `late` fields
  //       postDetailsController.postDetailsModel = PostDetailsModel(
  //         success: postDetailsController.postDetailsModel!.success,
  //         message: postDetailsController.postDetailsModel!.message,
  //         data: PostDetailsData(
  //           id: postDetailsController.postData!.id,
  //           author: postDetailsController.postData!.author,
  //           description: postDetailsController.postData!.description,
  //           content: postDetailsController.postData!.content,
  //           audience: postDetailsController.postData!.audience,
  //           hideBy: postDetailsController.postData!.hideBy,
  //           contentMeta: postDetailsController.postData!.contentMeta,
  //           isDeleted: postDetailsController.postData!.isDeleted,
  //           createdAt: postDetailsController.postData!.createdAt,
  //           updatedAt: postDetailsController.postData!.updatedAt,
  //           v: postDetailsController.postData!.v,
  //           isLiked: postDetailsController.postData!.isLiked,
  //           isFollowing: postDetailsController.postData!.isFollowing,
  //           isVisible: postDetailsController.postData!.isVisible,
  //           isHide: postDetailsController.postData!.isHide,
  //           isWatchLater: true,
  //         ),
  //       );
  //       postDetailsController.update(); // Trigger UI update
  //     }
  //     if (mounted) {
  //       showSnackBarMessage(context, 'Post saved successfully');
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(context,
  //           savePostController.errorMessage ?? 'Failed to save post', true);
  //     }
  //   }
  // }

  // Future<void> unSavePost(String postId) async {
  //   final bool isSuccess =
  //       await unSavedPostController.unSavePost(postId: postId);

  //   if (isSuccess) {
  //     saveAllPostController.getMySavePost();
  //     allPostController.updatePostUnSave(postId, false);
  //     if (postDetailsController.postDetailsModel != null &&
  //         postDetailsController.postData?.contentMeta?.id == postId) {
  //       // Create a new PostDetailsData object to avoid modifying `late` fields
  //       postDetailsController.postDetailsModel = PostDetailsModel(
  //         success: postDetailsController.postDetailsModel!.success,
  //         message: postDetailsController.postDetailsModel!.message,
  //         data: PostDetailsData(
  //           id: postDetailsController.postData!.id,
  //           author: postDetailsController.postData!.author,
  //           description: postDetailsController.postData!.description,
  //           content: postDetailsController.postData!.content,
  //           audience: postDetailsController.postData!.audience,
  //           hideBy: postDetailsController.postData!.hideBy,
  //           contentMeta: postDetailsController.postData!.contentMeta,
  //           isDeleted: postDetailsController.postData!.isDeleted,
  //           createdAt: postDetailsController.postData!.createdAt,
  //           updatedAt: postDetailsController.postData!.updatedAt,
  //           v: postDetailsController.postData!.v,
  //           isLiked: postDetailsController.postData!.isLiked,
  //           isFollowing: postDetailsController.postData!.isFollowing,
  //           isVisible: postDetailsController.postData!.isVisible,
  //           isHide: postDetailsController.postData!.isHide,
  //           isWatchLater: false,
  //         ),
  //       );
  //       postDetailsController.update(); // Trigger UI update
  //     }
  //     if (mounted) {
  //       showSnackBarMessage(context, 'Unsaved successfully done');
  //     }
  //   } else {
  //     Get.snackbar(
  //       backgroundColor: Colors.red,
  //       snackPosition: SnackPosition.TOP,
  //       'Failed',
  //       'Failed to unsave post',
  //     );
  //   }
  // }

  Future<void> reactPost(String postId) async {
    final bool isSuccess = await reactPostController.reactPost(postId);
    if (isSuccess) {
      // Update AllPostController
      int index = allPostController.postList
          .indexWhere((post) => post.contentMeta?.id == postId);
      if (index != -1) {
        int currentLikes =
            allPostController.postList[index].contentMeta?.like ?? 0;
        allPostController.updatePostLike(postId, true, currentLikes + 1);
      }

      // Update PostDetailsController's postDetailsModel
      if (postDetailsController.postDetailsModel != null &&
          postDetailsController.postData?.contentMeta?.id == postId) {
        // Create a new PostDetailsData object to avoid modifying `late` fields
        postDetailsController.postDetailsModel = PostDetailsModel(
          success: postDetailsController.postDetailsModel!.success,
          message: postDetailsController.postDetailsModel!.message,
          data: PostDetailsData(
            id: postDetailsController.postData!.id,
            author: postDetailsController.postData!.author,
            description: postDetailsController.postData!.description,
            content: postDetailsController.postData!.content,
            audience: postDetailsController.postData!.audience,
            hideBy: postDetailsController.postData!.hideBy,
            contentMeta: ContentMeta(
              id: postDetailsController.postData!.contentMeta?.id,
              like:
                  (postDetailsController.postData!.contentMeta?.like ?? 0) + 1,
              likeBy: postDetailsController.postData!.contentMeta?.likeBy ?? [],
              comment: postDetailsController.postData!.contentMeta?.comment,
              share: postDetailsController.postData!.contentMeta?.share,
            ),
            isDeleted: postDetailsController.postData!.isDeleted,
            createdAt: postDetailsController.postData!.createdAt,
            updatedAt: postDetailsController.postData!.updatedAt,
            v: postDetailsController.postData!.v,
            isLiked: true,
            isFollowing: postDetailsController.postData!.isFollowing,
            isVisible: postDetailsController.postData!.isVisible,
            isHide: postDetailsController.postData!.isHide,
            isWatchLater: postDetailsController.postData!.isWatchLater,
          ),
        );
        postDetailsController.update(); // Trigger UI update
      }

      if (mounted) {
        showSnackBarMessage(context, 'Like successfully completed');
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
      // Update AllPostController
      int index = allPostController.postList
          .indexWhere((post) => post.contentMeta?.id == postId);
      if (index != -1) {
        int currentLikes =
            allPostController.postList[index].contentMeta?.like ?? 0;
        allPostController.updatePostLike(
            postId, false, currentLikes > 0 ? currentLikes - 1 : 0);
      }

      // Update PostDetailsController's postDetailsModel
      if (postDetailsController.postDetailsModel != null &&
          postDetailsController.postData?.contentMeta?.id == postId) {
        // Create a new PostDetailsData object to avoid modifying `late` fields
        postDetailsController.postDetailsModel = PostDetailsModel(
          success: postDetailsController.postDetailsModel!.success,
          message: postDetailsController.postDetailsModel!.message,
          data: PostDetailsData(
            id: postDetailsController.postData!.id,
            author: postDetailsController.postData!.author,
            description: postDetailsController.postData!.description,
            content: postDetailsController.postData!.content,
            audience: postDetailsController.postData!.audience,
            hideBy: postDetailsController.postData!.hideBy,
            contentMeta: ContentMeta(
              id: postDetailsController.postData!.contentMeta?.id,
              like: (postDetailsController.postData!.contentMeta?.like ?? 0) > 0
                  ? postDetailsController.postData!.contentMeta!.like! - 1
                  : 0,
              likeBy: postDetailsController.postData!.contentMeta?.likeBy ?? [],
              comment: postDetailsController.postData!.contentMeta?.comment,
              share: postDetailsController.postData!.contentMeta?.share,
            ),
            isDeleted: postDetailsController.postData!.isDeleted,
            createdAt: postDetailsController.postData!.createdAt,
            updatedAt: postDetailsController.postData!.updatedAt,
            v: postDetailsController.postData!.v,
            isLiked: false,
            isFollowing: postDetailsController.postData!.isFollowing,
            isVisible: postDetailsController.postData!.isVisible,
            isHide: postDetailsController.postData!.isHide,
            isWatchLater: postDetailsController.postData!.isWatchLater,
          ),
        );
        postDetailsController.update(); // Trigger UI update
      }

      if (mounted) {
        showSnackBarMessage(context, 'Dislike successfully completed');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            disReactPostController.errorMessage ?? 'Failed to dislike', true);
      }
    }
  }
}
