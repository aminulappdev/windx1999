import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/post/controller/comment_controller.dart';
import 'package:windx1999/app/modules/post/controller/send_comment_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String postType;
  const CommentScreen(
      {super.key, required this.postId, required this.postType});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  AllPostController allPostController = Get.put(AllPostController());
  ProfileController profileController = Get.put(ProfileController());
  ThemeController themeController = Get.find<ThemeController>();
  final CommentController commentController = Get.put(CommentController());
  final SendCommentController sendCommentController =
      Get.put(SendCommentController());
  final TextEditingController commentCtrl = TextEditingController();
  FocusNode replyFocusNode = FocusNode(); // FocusNode for the reply TextField
  int? selectedCommentIndex; // Tracks which comment is being replied to
  String? replyRef; // Stores the ID of the comment being replied to

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getMyProfile();
      commentController.getAllComment(widget.postId);
      print('PostId: ${widget.postId}');
      print('PostType: ${widget.postType}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.h),
            child: Column(
              children: [
                heightBox30,
                const CustomAppBar(title: 'Comments'),
                Expanded(
                  child: GetBuilder<CommentController>(builder: (cController) {
                    print("Comment Data: ${cController.commentData?.length}"); // Debug
                    if (cController.inProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (cController.commentData == null ||
                        cController.commentData!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No comments yet.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: cController.commentData?.length,
                      itemBuilder: (context, index) {
                        final comment = cController.commentData![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundImage: NetworkImage(comment
                                            .user?.photoUrl ??
                                        'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU'),
                                  ),
                                  widthBox8,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment.user?.name ?? '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.sp),
                                        ),
                                        Text(comment.comment ?? '',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        if (comment.reply.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(top: 5.h),
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: comment.reply.length,
                                              itemBuilder:
                                                  (context, replyIndex) {
                                                final reply =
                                                    comment.reply[replyIndex];
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                255, 255, 255),
                                                        child: CircleAvatar(
                                                          radius: 14,
                                                          backgroundImage:
                                                              NetworkImage(reply
                                                                      .user
                                                                      ?.photoUrl ??
                                                                  'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU'),
                                                        ),
                                                      ),
                                                      widthBox10,
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            reply.user?.name ??
                                                                '',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                              reply.comment ?? '',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedCommentIndex = index;
                                              replyRef = comment.id;
                                              commentCtrl.text = '';
                                              FocusScope.of(context)
                                                  .requestFocus(replyFocusNode); // Trigger keyboard
                                            });
                                          },
                                          child: Text(
                                            'Reply',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 228, 226, 226),
                                                fontSize: 14.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GetBuilder<ThemeController>(builder: (controller) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: controller.isDarkMode == true
                            ? Color(0xff333333)
                            : Color(0xffFFFFFF).withOpacity(0.32),
                      ),
                      height: 82.h,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GetBuilder<ProfileController>(builder: (pController) {
                              return CircleAvatar(
                                radius: 18.r,
                                backgroundImage: NetworkImage(pController
                                        .profileData?.photoUrl ??
                                    'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU'),
                              );
                            }),
                            SizedBox(
                              width: 250.w,
                              child: TextFormField(
                                controller: commentCtrl,
                                focusNode: replyFocusNode, // Attach FocusNode
                                style: TextStyle(
                                    color: controller.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: controller.isDarkMode == true
                                          ? Colors.white
                                          : Colors.black),
                                  fillColor: Colors.transparent,
                                  hintText: selectedCommentIndex == null
                                      ? 'Write a comment'
                                      : 'Write a reply',
                                  contentPadding: EdgeInsets.all(10.h),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (commentCtrl.text.isNotEmpty) {
                                  if (selectedCommentIndex == null) {
                                    // Send a comment
                                    sendComment(
                                      contentId: widget.postId,
                                      modelType: widget.postType == 'feed'
                                          ? 'Feed'
                                          : widget.postType == 'Feed'
                                              ? 'Feed'
                                              : widget.postType == 'Reels'
                                                  ? 'Reels'
                                                  : 'Wishlist',
                                      comment: commentCtrl.text,
                                      isReply: false,
                                      userId: StorageUtil.getData(
                                          StorageUtil.userId),
                                    );
                                  } else {
                                    // Send a reply
                                    sendReply(
                                      contentId: widget.postId,
                                      modelType: widget.postType == 'feed'
                                          ? 'Feed'
                                          : widget.postType == 'Feed'
                                              ? 'Feed'
                                              : widget.postType == 'Reels'
                                                  ? 'Reels'
                                                  : 'Wishlist',
                                      comment: commentCtrl.text,
                                      isReply: true,
                                      userId: StorageUtil.getData(
                                          StorageUtil.userId),
                                      replyRef: replyRef ?? '',
                                    );
                                  }
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: controller.isDarkMode == true
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                heightBox10,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendComment({
    required String userId,
    required String modelType,
    required String contentId,
    required String comment,
    required bool isReply,
    String? repReference,
  }) async {
    final bool isSuccess = await sendCommentController.sendComment(
        userId, modelType, contentId, comment, isReply, repReference);
    if (isSuccess) {
      allPostController.updatePostHide(contentId, true);
      commentController.getAllComment(contentId);
      if (mounted) {
        // showSnackBarMessage(context, 'Comment successfully posted');
        commentCtrl.clear();
        setState(() {
          selectedCommentIndex = null; // Reset reply state
          replyRef = null;
        });
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, sendCommentController.errorMessage ?? 'Failed', true);
      }
    }
  }

  Future<void> sendReply({
    required String userId,
    required String modelType,
    required String contentId,
    required String comment,
    required bool isReply,
    required String replyRef,
    String? repReference,
  }) async {
    if (replyRef.isEmpty) {
      if (mounted) {
        showSnackBarMessage(context, 'Reply reference is invalid!', true);
      }
      return;
    }
    final bool isSuccess = await sendCommentController.sendComment(
        userId, modelType, contentId, comment, isReply, replyRef);
    if (isSuccess) {
      commentController.getAllComment(contentId);
      if (mounted) {
        allPostController.updatePostHide(contentId, true);
        // showSnackBarMessage(context, 'Reply successfully posted');
        commentCtrl.clear();
        setState(() {
          selectedCommentIndex = null; // Reset reply state
          replyRef;
        });
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, sendCommentController.errorMessage ?? 'Failed', true);
      }
    }
  }
}
