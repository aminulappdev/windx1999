import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:windx1999/app/modules/reels/widgets/icon_with_react.dart';
import 'package:windx1999/app/modules/reels/widgets/reels_details.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  late VideoPlayerController _controller;
  bool isMuted = false; // Variable to track sound state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: CustomBackground(
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  _controller.value.isInitialized
                      ? SizedBox(
                          height: height,
                          width: width,
                          child: VideoPlayer(_controller),
                        )
                      : SizedBox(
                          height: height,
                          width: width,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                  // Close Button & Title
                  Positioned(
                    top: 20.h,
                    left: 20.w,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 26.h,
                          ),
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

                  // Action Buttons (Right Side)
                  Positioned(
                    bottom: 60.h,
                    right: 20.w,
                    child: Column(
                      children: [
                        IconWithReact(
                          icon: Icons.favorite_outline,
                          text: '12.6k',
                          ontap: () {},
                        ),
                        heightBox16,
                        IconWithReact(
                          icon: Icons.comment_outlined,
                          text: '12.6k',
                          ontap: () {},
                        ),
                        heightBox16,
                        IconWithReact(
                          icon: Icons.share,
                          text: '12.6k',
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

                  // Details (Left Bottom)
                  Positioned(
                    bottom: 30.h,
                    left: 10.h,
                    child: ReelsDetails(
                      imagePath: AssetsPath.blackGirl,
                      name: 'Md Saiful',
                      address: 'Barishal',
                      addFriendOnTap: () {},
                      wishListOnTap: () {},
                      caption:
                          '"Capturing moments that speak louder than words..."',
                      musicName: 'Wake Up Call, Original audio',
                    ),
                  ),

                  // Play Button
                  Positioned(
                    bottom: 400.h,
                    left: 160.w,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: CircleAvatar(
                        radius: 28.r,
                        backgroundColor: Colors.white.withOpacity(0.50),
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 30.h,
                        ),
                      ),
                    ),
                  ),

                  // Volume Button (Sound On/Off)
                  Positioned(
                    bottom: 325.h,
                    left: 160.w,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isMuted = !isMuted;
                          _controller.setVolume(isMuted ? 0.0 : 1.0); 
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
          ),
        ),
      ),
    );
  }
}
