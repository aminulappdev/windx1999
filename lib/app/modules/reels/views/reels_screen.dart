import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: CustomBackground(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    height: height - 95.h,
                    width: width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetsPath.reels),
                            fit: BoxFit.fill)),
                  ),

                  /// 📌 Back Button
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
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),

                  /// 📌 Camera Switch & Flash Buttons
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
                          '"Capturing moments that speak louder than words...',
                      musicName: 'Wake Up Call, Original audio',
                    ),
                  ),
                  Positioned(
                      bottom: 400.h,
                      left: 160.w,
                      child: InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 28.r,
                          backgroundColor: Colors.white.withOpacity(0.50),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30.h,
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: 325.h,
                    left: 160.w,
                    child: InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 28.r,
                        backgroundColor: Colors.white.withOpacity(0.50),
                        child: Icon(
                          Icons.volume_up,
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
