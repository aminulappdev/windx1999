import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/homepage/views/comment_screen.dart';
import 'package:windx1999/app/modules/homepage/views/kebab_screen.dart';
import 'package:windx1999/app/modules/homepage/views/not_found_screen.dart';
import 'package:windx1999/app/modules/homepage/views/notification_screen.dart';
import 'package:windx1999/app/modules/homepage/views/search_screen.dart';
import 'package:windx1999/app/modules/homepage/views/share_screen.dart';
import 'package:windx1999/app/modules/homepage/views/show_wishlist_screen.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 40, width: 196, child: CustomSearchBar()),
                    Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(116, 255, 255, 255)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.token,
                            size: 28,
                          ),
                          Text('25.2k')
                        ],
                      ),
                    ),
                    CircleIconTransparent(
                      icon: Icons.notifications,
                      fillColor: Color.fromARGB(116, 255, 255, 255),
                      iconColor: Colors.white,
                      iconSize: 30,
                      ontap: () {
                        Get.to(NotificationScreen());
                      },
                      radius: 40,
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
                          children: [KebabScreen()],
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
