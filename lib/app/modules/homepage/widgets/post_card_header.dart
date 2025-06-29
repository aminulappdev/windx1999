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
    required this.isShowWishlist,
  });

  final bool isShowWishlist;
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
        Container(
          // color: Colors.blueGrey,
          child: SizedBox(
            width: 160.w,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundImage: NetworkImage(profilePath),
                ),
                widthBox5,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        name,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    widthBox12,
                    Text(
                      activeStatus,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: addFriendOnTap,
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: 30.h,
                )),
            widthBox5,
            isShowWishlist == true
                ? Container(
                    height: 35.h,
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
                  )
                : Container(),
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
