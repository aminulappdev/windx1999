
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PostCardHeader extends StatelessWidget {
  const PostCardHeader({
    super.key,
    required this.profilePath,
    required this.name,
    required this.addFriendOnTap,
    required this.activeStatus,
    required this.wishListOnTap,
    required this.moreVertOntap,
  });

  final String profilePath;
  final String name;
  final VoidCallback addFriendOnTap;
  final String activeStatus;
  final VoidCallback wishListOnTap;
  final VoidCallback moreVertOntap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 195.w,
          child: Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundImage: AssetImage(profilePath),
              ),
              widthBox5,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100.w,
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
                            Icons.person_add,
                            color: Colors.white,
                            size: 30.h,
                          ))
                    ],
                  ),
                  Text(
                    activeStatus,
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
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff6CC7FE)),
              child: GestureDetector(
                onTap: wishListOnTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.task_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      'Wishlist',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: moreVertOntap,
              child: Icon(
                Icons.more_vert,
                size: 30.h,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
