// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:windx1999/app/modules/reels/controller/all_reels_controller.dart';
import 'package:windx1999/app/modules/reels/widgets/icon_with_react.dart';
import 'package:windx1999/app/modules/reels/widgets/reels_details.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final AllReelsController allReelsController = Get.put(AllReelsController());

  final Map<int, VideoPlayerController> _videoControllers = {};
  final Map<int, Future<void>> _initializeFutures = {};

  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    allReelsController.getAllReels();
  }

  @override
  void dispose() {
    _videoControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
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

                    return Stack(
                      children: [
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
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.close,
                                    color: Colors.white, size: 26.h),
                              ),
                              widthBox5,
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

                        // Right side icons
                        Positioned(
                          bottom: 60.h,
                          right: 20.w,
                          child: Column(
                            children: [
                              IconWithReact(
                                icon: Icons.favorite_outline,
                                text: reel.contentMeta?.like?.toString() ?? '0',
                                ontap: () {},
                              ),
                              heightBox16,
                              IconWithReact(
                                icon: Icons.comment_outlined,
                                text: reel.contentMeta?.comment?.toString() ??
                                    '0',
                                ontap: () {},
                              ),
                              heightBox16,
                              IconWithReact(
                                icon: Icons.share,
                                text:
                                    reel.contentMeta?.share?.toString() ?? '0',
                                ontap: () {},
                              ),
                              heightBox16,
                              IconWithReact(
                                icon: Icons.bookmark,
                                text: '12.6k',
                                ontap: () {},
                              ),
                            ],
                          ),
                        ),

                        // Bottom left details
                        Positioned(
                          bottom: 30.h,
                          left: 10.h,
                          child: ReelsDetails(
                            imagePath: controller
                                    .allReelsData![index].author?.photoUrl ??
                                'https://fastly.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY',
                            name:
                                controller.allReelsData![index].author?.name ??
                                    '', // Can be from reel.author?.name
                            address: '',
                            addFriendOnTap: () {},
                            wishListOnTap: () {},
                            caption: 'No caption',
                            musicName: 'Original Audio',
                          ),
                        ),

                        // Play/pause button
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
                              backgroundColor: Colors.white.withOpacity(0.50),
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
                        Positioned(
                          bottom: 325.h,
                          left: 160.w,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isMuted = !isMuted;
                                videoController.setVolume(isMuted ? 0.0 : 1.0);
                              });
                            },
                            child: CircleAvatar(
                              radius: 28.r,
                              backgroundColor: Colors.white.withOpacity(0.50),
                              child: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        )
                      ],
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
}
