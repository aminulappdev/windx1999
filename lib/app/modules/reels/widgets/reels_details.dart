
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ReelsDetails extends StatelessWidget {
  final String imagePath;
  final String name;
  final String address;
  final VoidCallback addFriendOnTap;
  final VoidCallback wishListOnTap;
  final String caption;
  final String musicName;

  const ReelsDetails({
    super.key,
    required this.imagePath,
    required this.name,
    required this.address,
    required this.addFriendOnTap,
    required this.wishListOnTap,
    required this.caption,
    required this.musicName,
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
                    backgroundImage: AssetImage(imagePath),
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
                          GestureDetector(
                              onTap: addFriendOnTap,
                              child: Icon(
                                Icons.person_add_alt_1_outlined,
                                color: Colors.white,
                                size: 30.h,
                              ))
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
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: wishListOnTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_outlined,
                          color: Color(0xff6CC7FE),
                        ),
                        Text(
                          'Wishlist',
                          style: TextStyle(color: Color(0xff6CC7FE)),
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