import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/homepage/views/comment_screen.dart';
import 'package:windx1999/app/modules/homepage/views/botton_sheet_screen.dart';
import 'package:windx1999/app/modules/homepage/views/notification_screen.dart';
import 'package:windx1999/app/modules/homepage/views/share_screen.dart';
import 'package:windx1999/app/modules/homepage/views/show_wishlist_screen.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/token/views/token_bar.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/circle_icon_transparent.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeController themeController = Get.find<ThemeController>();
  AllPostController allPostController = Get.put(AllPostController());
  ProfileController profileController = Get.put(ProfileController());

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
  void initState() {
    allPostController.getAllPost();
    profileController.getMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (controller) {
      return Scaffold(
        body: CustomBackground(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.h, vertical: 20),
            child: Column(
              children: [
                heightBox20,
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
                      child:
                          GetBuilder<ProfileController>(builder: (pController) {
                        if (pController.inProgress) {
                          return Center(child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()));
                        }
                        return InkWell(
                          onTap: () {
                            Get.to(TokenBar());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.token_rounded,
                                size: 26.h,
                                color: controller.isDarkMode == true
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
                              ),
                              Text(
                                pController.profileData?.tokenAmount
                                        .toString() ??
                                    'e',
                                style: TextStyle(
                                  color: controller.isDarkMode == true
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(255, 0, 0, 0),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
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
                Expanded(
                    child: GetBuilder<AllPostController>(builder: (controller) {
                  if (controller.inProgress) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.allPostData?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: PostCard(
                          iSVisibleWishlist:
                              controller.allPostData![index].contentType ==
                                      'wishlist'
                                  ? true
                                  : false,
                          bgColor: Color(0xffAF7CF8),
                          name: controller.allPostData![index].author?.name ??
                              'name',
                          profilePath: controller
                                  .allPostData![index].author?.photoUrl ??
                              'https://fastly.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY',
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
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
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
                              controller.allPostData![index].description ?? '',
                          comment: controller
                                  .allPostData![index].contentMeta?.comment
                                  .toString() ??
                              '0',
                          react: controller
                                  .allPostData![index].contentMeta?.like
                                  .toString() ??
                              '0',
                          share: controller
                                  .allPostData![index].contentMeta?.share
                                  .toString() ??
                              '0',
                          shareOntap: () {
                            showModalBottomSheet(
                              scrollControlDisabledMaxHeightRatio: 0.6,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
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
                          imagePath: AssetsPath.blackGirl,
                          bookmarkOntap: () {},
                          commentOnTap: () {
                            Get.to(CommentScreen());
                          },
                        ),
                      );
                    },
                  );
                }))
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    allPostController.getAllPost();
    profileController.getMyProfile();
    super.dispose();
  }
}
