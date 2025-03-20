import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/homepage/views/comment_screen.dart';
import 'package:windx1999/app/modules/homepage/views/botton_sheet_screen.dart';
import 'package:windx1999/app/modules/homepage/views/not_found_screen.dart';
import 'package:windx1999/app/modules/homepage/views/notification_screen.dart';
import 'package:windx1999/app/modules/homepage/views/share_screen.dart';
import 'package:windx1999/app/modules/homepage/views/show_wishlist_screen.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card.dart';
import 'package:windx1999/app/modules/token/views/token_bar.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/circle_icon_transparent.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> postCardKebabIconDetailsList = [
    {'icon': Icons.bookmark, 'name': 'Save post', 'ontap': () {}},
    {'icon': Icons.copy, 'name': 'Copy link', 'ontap': () {}},
    {'icon': Icons.visibility_off, 'name': 'Hide post', 'ontap': () {}},
    {'icon': Icons.person_remove, 'name': 'unfollow', 'ontap': () {}},
    {'icon': Icons.person_off, 'name': 'Block', 'ontap': () {}},
    {
      'icon': Icons.smart_display_outlined,
      'name': 'Report profile',
      'ontap': () {}
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24.0.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 40.h, width: 196.w, child: CustomSearchBar()),
                    Container(
                      height: 40.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(116, 255, 255, 255)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(TokenBar());
                            },
                            child: Icon(
                              Icons.layers,
                              size: 28.h,
                            ),
                          ),
                          Text('25.2k')
                        ],
                      ),
                    ),
                    CircleIconTransparent(
                      icon: Icons.notifications,
                      fillColor: Color.fromARGB(116, 255, 255, 255),
                      iconColor: Colors.white,
                      iconSize: 30.h,
                      ontap: () {
                        Get.to(NotificationScreen());
                      },
                      radius: 40.r,
                    ),
                  ],
                ),
                heightBox12,
                PostCard(
                  name: 'Aminul Islam',
                  profilePath: AssetsPath.blackGirl,
                  activeStatus: '20m ago',
                  addFriendOnTap: () {},
                  wishListOnTap: () {
                    Get.to(ShowWishlistScreen());
                  },
                  moreVertOntap: () {
                    showModalBottomSheet(
                      scrollControlDisabledMaxHeightRatio: 0.6,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      backgroundColor: Color(0xffA96CFF),
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ButtonSheetDetailsScreen(
                              buttonSheetDetailsList:
                                  postCardKebabIconDetailsList,
                            )
                          ],
                        );
                      },
                    );
                  },
                  text:
                      '"Capturing moments that speak louder thanwo, this image brings to life the beauty inthe everyday.',
                  comment: '25.2k',
                  react: '25.9k',
                  share: '1.5k',
                  shareOntap: () {
                    showModalBottomSheet(
                      scrollControlDisabledMaxHeightRatio: 0.6,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      backgroundColor: Color(0xffA96CFF),
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [ShareScreen()],
                        );
                      },
                    );
                  },
                  bookmarkOntap: () {},
                  commentOnTap: () {
                    Get.to(CommentScreen());
                  },
                ),
                heightBox12,
                PostCard(
                  name: 'Aminul',
                  profilePath: AssetsPath.blackGirl,
                  activeStatus: '20m ago',
                  addFriendOnTap: () {
                    Get.to(NotFoundSearchScreen());
                  },
                  wishListOnTap: () {},
                  moreVertOntap: () {},
                  text:
                      '"Capturing moments that speak louder thanwo, this image brings to life the beauty inthe everyday.',
                  comment: '25.2k',
                  react: '25.9k',
                  share: '1.5k',
                  shareOntap: () {},
                  bookmarkOntap: () {},
                  commentOnTap: () {},
                  imagePath: AssetsPath.blackGirl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
