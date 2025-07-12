import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ReelsDetails extends StatelessWidget {
  final String imagePath;
  final String name;
  final String address;
  final VoidCallback addFriendOnTap;
  final VoidCallback followOnTap;
  final String caption;
  final String follow;
  final String musicName;

  const ReelsDetails({
    super.key,
    required this.imagePath,
    required this.name,
    required this.address,
    required this.addFriendOnTap,
    required this.followOnTap,
    required this.caption,
    required this.musicName, required this.follow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 190.w,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundImage: NetworkImage(imagePath),
                  ),
                  widthBox5,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          widthBox12,
                        ],
                      ),
                      Text(
                        address,
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  height: 30.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: followOnTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          follow,
                          style: TextStyle(
                              color: Color.fromARGB(255, 248, 248, 248)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        heightBox8,
        SizedBox(
          width: 300.w,
          child: Text(
            caption,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ),
        heightBox8,
        Row(
          children: [
            Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            widthBox4,
            SizedBox(
              width: 300.w,
              child: Text(
                musicName,
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
