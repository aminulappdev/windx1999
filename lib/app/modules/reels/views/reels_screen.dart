// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:windx1999/app/modules/common/controllers/save_my_post_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/dis_react_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/follow_request_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/react_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/save_post_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/unFollow_request_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/un_saved_post_controller.dart';
import 'package:windx1999/app/modules/homepage/views/comment_screen.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/reels/controller/all_reels_controller.dart';
import 'package:windx1999/app/modules/reels/widgets/icon_with_react.dart';
import 'package:windx1999/app/modules/reels/widgets/reels_details.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/date_time_formate_class.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final AllReelsController allReelsController = Get.put(AllReelsController());
  final SavePostController savePostController = SavePostController();
  final ReactPostController reactPostController = ReactPostController();
  final DisReactPostController disReactPostController =
      DisReactPostController();
  final FollowRequestController followRequestController =
      FollowRequestController();
  final UnFollowRequestController unFollowRequestController =
      UnFollowRequestController();
  final UnSavedPostController unSavedPostController =
      Get.put(UnSavedPostController());

  final SaveAllPostController saveAllPostController =
      Get.put(SaveAllPostController());
  final Map<int, VideoPlayerController> _videoControllers = {};
  final Map<int, Future<void>> _initializeFutures = {};

  bool isMuted = false;
  bool showControls = false;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    allReelsController.getAllReels();
  }

  @override
  void dispose() {
    _videoControllers.forEach((_, controller) => controller.dispose());
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void toggleControls() {
    setState(() {
      showControls = true;
    });

    _hideControlsTimer?.cancel();

    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showControls = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: CustomBackground(
          child: GetBuilder<AllReelsController>(builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.allReelsData?.length ?? 0,
              itemBuilder: (context, index) {
                final reel = controller.allReelsData![index];
                final videoUrl = reel.video?.toString() ?? '';

                if (!_videoControllers.containsKey(index)) {
                  final videoController =
                      VideoPlayerController.network(videoUrl);
                  _videoControllers[index] = videoController;
                  _initializeFutures[index] =
                      videoController.initialize().then((_) {
                    videoController.setLooping(true);
                    videoController.play();
                    setState(() {});
                  });
                }

                final videoController = _videoControllers[index]!;
                final initializeFuture = _initializeFutures[index]!;

                return FutureBuilder(
                  future: initializeFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final dateFormatter = DateFormatter(
                        controller.allReelsData![index].createdAt!);
                    return GestureDetector(
                      onTap: toggleControls,
                      child: Stack(
                        children: [
                          // Video
                          SizedBox(
                            height: height,
                            width: width,
                            child: VideoPlayer(videoController),
                          ),

                          // Close & Title
                          Positioned(
                            top: 20.h,
                            left: 20.w,
                            child: Row(
                              children: [
                                Text(
                                  'Reel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.h,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Right-side icons
                          Positioned(
                            bottom: 60.h,
                            right: 20.w,
                            child: Column(
                              children: [
                                IconWithReact(
                                  icon:
                                      controller.allReelsData![index].isLiked ==
                                              false
                                          ? Icons.favorite_outline
                                          : Icons.favorite,
                                  text:
                                      reel.contentMeta?.like?.toString() ?? '0',
                                  ontap: () {
                                    controller.allReelsData![index].isLiked ==
                                            true
                                        ? disReactPost(controller
                                            .allReelsData![index]
                                            .contentMeta!
                                            .id!)
                                        : reactPost(controller
                                            .allReelsData![index]
                                            .contentMeta!
                                            .id!);
                                  },
                                ),
                                heightBox16,
                                IconWithReact(
                                  icon: Icons.comment_outlined,
                                  text: reel.contentMeta?.comment?.toString() ??
                                      '0',
                                  ontap: () {
                                    Get.to(CommentScreen(
                                      postId:
                                          controller.allReelsData?[index].id ??
                                              '',
                                      postType: 'reels',
                                    ));
                                  },
                                ),
                                heightBox16,
                                IconWithReact(
                                  icon: controller.allReelsData?[index]
                                              .isWatchLater ==
                                          true
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline,
                                  text: '',
                                  ontap: () {
                                    print(
                                        'isWatch later ${controller.allReelsData?[index].isWatchLater}\n...................................................................');
                                    // controller.allReelsData?[index]
                                    //             .isWatchLater ==
                                    //         false
                                    //     ? unSavePost(controller
                                    //             .allReelsData![index].id ??
                                    //         '')
                                    //     : savePost(
                                    //         controller.allReelsData![index]
                                    //                 .author?.id ??
                                    //             '',
                                    //         'reels',
                                    //         controller
                                    //                 .allReelsData![index].id ??
                                    //             '');
                                    if (controller.allReelsData?[index]
                                            .isWatchLater ==
                                        true) {
                                      unSavePost(
                                          controller.allReelsData![index].id ??
                                              '');
                                    } else if (controller.allReelsData?[index]
                                            .isWatchLater ==
                                        false) {
                                      savePost(
                                          StorageUtil.getData(
                                                  StorageUtil.userId) ??
                                              '',
                                          'reels',
                                          controller.allReelsData![index].id ??
                                              '');
                                    } else {
                                      print('Problem');
                                    }

                                    // savePost(
                                    //     StorageUtil.getData(
                                    //             StorageUtil.userId) ??
                                    //         '',
                                    //     'reels',
                                    //     controller.allReelsData![index].id ??
                                    //         '');
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Bottom left details
                          Positioned(
                            bottom: 30.h,
                            left: 10.h,
                            child: ReelsDetails(
                              follow: controller
                                          .allReelsData![index].isWatchLater ==
                                      true
                                  ? 'Unfollow'
                                  : 'Follow',
                              imagePath: controller
                                      .allReelsData![index].author?.photoUrl ??
                                  'https://fastly.picsum.photos/id/1/200/300.jpg',
                              name: controller
                                      .allReelsData![index].author?.name ??
                                  '',
                              address: dateFormatter.getDateTimeFormat(),
                              addFriendOnTap: () {},
                              followOnTap: () {
                                if (controller
                                        .allReelsData![index].isWatchLater ==
                                    true) {
                                  unFollowRequest(controller
                                          .allReelsData![index].author?.id ??
                                      '');
                                } else {
                                  followRequest(controller
                                          .allReelsData![index].author?.id ??
                                      '');
                                }
                              },
                              caption:
                                  controller.allReelsData?[index].description ??
                                      '',
                              musicName: '',
                            ),
                          ),

                          // Play/pause button
                          if (showControls)
                            Positioned(
                              bottom: 400.h,
                              left: 160.w,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    videoController.value.isPlaying
                                        ? videoController.pause()
                                        : videoController.play();
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 28.r,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.50),
                                  child: Icon(
                                    videoController.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30.h,
                                  ),
                                ),
                              ),
                            ),

                          // Volume toggle
                          if (showControls)
                            Positioned(
                              bottom: 325.h,
                              left: 160.w,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isMuted = !isMuted;
                                    videoController
                                        .setVolume(isMuted ? 0.0 : 1.0);
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 28.r,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.50),
                                  child: Icon(
                                    isMuted
                                        ? Icons.volume_off
                                        : Icons.volume_up,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Future<void> savePost(
      String userId, String modelType, String contentId) async {
    final bool isSuccess =
        await savePostController.savePostF(userId, modelType, contentId);
    if (isSuccess) {
      allReelsController.getAllReels();
      if (mounted) {
        // showSnackBarMessage(context, 'Hide successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, savePostController.errorMessage ?? 'failed', true);
      }
    }
  }

  Future<void> unSavePost(String postId) async {
    final bool isSuccess =
        await unSavedPostController.unSavePost(postId: postId);

    if (isSuccess) {
      saveAllPostController.getMySavePost();
      allReelsController.getAllReels();
      // showSnackBarMessage(context, 'unsaved successfully done');
    } else {
      Get.snackbar(
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        'Failed',
        'Failed to delete account',
      );
    }
  }

  Future<void> followRequest(String frindId) async {
    final bool isSuccess = await followRequestController.followRequest(frindId);
    if (isSuccess) {
      allReelsController.getAllReels();
      if (mounted) {
        // showSnackBarMessage(context, 'Follow successfully done');
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
      allReelsController.getAllReels();
      if (mounted) {
        // showSnackBarMessage(context, 'Unfollow successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, unFollowRequestController.errorMessage ?? 'failed', true);
      }
    }
  }

  Future<void> reactPost(String postId) async {
    final bool isSuccess = await reactPostController.reactPost(postId);
    if (isSuccess) {
      allReelsController.getAllReels();
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
      allReelsController.getAllReels();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, savePostController.errorMessage ?? 'failed', true);
      }
    }
  }
}
