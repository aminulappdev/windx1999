import 'package:flutter/material.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PostCard extends StatelessWidget {
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
  final VoidCallback shareOntap;
  final VoidCallback bookmarkOntap;

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
    required this.shareOntap,
    required this.bookmarkOntap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffAF7CF8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 195,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage(profilePath),
                      ),
                      widthBox5,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 16,
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
                                    size: 30,
                                  ))
                            ],
                          ),
                          Text(
                            activeStatus,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff6CC7FE)),
                      child: GestureDetector(
                        onTap: wishListOnTap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.note,
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
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
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
                    height: 190,
                    width: MediaQuery.of(context).size.width,
                    borderColor: Colors.white,
                    borderRadius: 12,
                  )
                : Container(),
            heightBox8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.heart_broken,
                      color: Colors.white,
                      size: 28,
                    ),
                    widthBox4,
                    Text(
                      react,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: commentOnTap,
                  child: Row(
                    children: [
                      Icon(
                        Icons.sms_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                      widthBox4,
                      Text(
                        comment,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: shareOntap,
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 28,
                      ),
                      widthBox4,
                      Text(
                        '25.5k',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: bookmarkOntap,
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 28,
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

