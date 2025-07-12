import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_footer.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_header.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PostCard extends StatelessWidget {
  final bool isSaved;
  final bool iSVisibleWishlist;
  final String profilePath;
  final String name;
  final String activeStatus;
  final VoidCallback addFriendOnTap;
  final VoidCallback wishListOnTap;
  final VoidCallback moreVertOntap;
  final String text;
  final String? imagePath;
  final String react;
  final String comment;
  final VoidCallback commentOnTap;
  final String share;
  final VoidCallback reactOntap;
  final VoidCallback bookmarkOntap;
  final Color bgColor;

  const PostCard({
    super.key,
    required this.profilePath,
    required this.name,
    required this.activeStatus,
    required this.addFriendOnTap,
    required this.wishListOnTap,
    required this.moreVertOntap,
    required this.text,
    this.imagePath,
    required this.react,
    required this.comment,
    required this.commentOnTap,
    required this.share, 
    required this.reactOntap,
    required this.bookmarkOntap, required this.bgColor, required this.iSVisibleWishlist, required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:  bgColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostCardHeader(
                isShowWishlist: iSVisibleWishlist,
                profilePath: profilePath,
                name: name,
                addFriendOnTap: addFriendOnTap,
                activeStatus: activeStatus,
                wishListOnTap: wishListOnTap,
                moreVertOntap: moreVertOntap),
            heightBox8,
            Text(
              text,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            heightBox12,
            // ignore: unnecessary_null_comparison
            imagePath != null
                ? ImageContainer(
                    imagePath: imagePath,
                    height: 250.h,
                    width: MediaQuery.of(context).size.width,
                    borderColor: Colors.white,
                    borderRadius: 12.r,
                  )
                : Container(),
            heightBox8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PostCardFoterFeature(
                  icon: react == '0' ? Icons.favorite_border : Icons.favorite,
                  ontap: reactOntap,
                  quantity: react,
                ),
                PostCardFoterFeature(
                  icon: Icons.sms,
                  ontap: commentOnTap,
                  quantity: comment,
                ),
                // PostCardFoterFeature(
                //   icon: Icons.share,
                //   ontap: shareOntap,
                //   quantity: share,
                // ),
                GestureDetector(
                  onTap: bookmarkOntap,
                  child: Icon(
                   isSaved ? Icons.bookmark :  Icons.bookmark_border,
                    color: Colors.white,
                    size: 28.h,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
