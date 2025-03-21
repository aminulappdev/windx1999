import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Import GetX package for navigation
import 'package:windx1999/app/modules/chat/views/chat_screen.dart';
import 'package:windx1999/app/modules/homepage/views/botton_sheet_screen.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/block_user.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/report_screen.dart';
import 'package:windx1999/app/modules/profile/views/followers_screen.dart';
import 'package:windx1999/app/modules/profile/views/following_screen.dart';
import 'package:windx1999/app/modules/profile/views/post_gallery.dart';
import 'package:windx1999/app/modules/profile/views/profile_product.dart';
import 'package:windx1999/app/modules/profile/widgets/profile_bar_icon.dart';
import 'package:windx1999/app/modules/profile/widgets/quantity_details_widget.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/circle_aveture_icon.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/rectangle_button_with_icon.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class OthersProfileScreen extends StatefulWidget {
  const OthersProfileScreen({super.key});

  @override
  State<OthersProfileScreen> createState() => _OthersProfileScreenState();
}

class _OthersProfileScreenState extends State<OthersProfileScreen> {
  bool showProductList = true;

  List<Map<String, dynamic>> othersProfileBottomBarList = [
    {
      'icon': Icons.person_add,
      'name': 'Follow',
      'ontap': () {
        Get.to(ReportScreen());
      },
    },
    {
      'icon': Icons.person_remove,
      'name': 'Block User',
      'ontap': () {
        Get.to(BlockUserScreen());
      },
    },
    {
      'icon': Icons.sms_outlined,
      'name': 'Report Profile',
      'ontap': () {
        Get.to(ReportScreen());
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: CustomBackground(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 200.h,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetsPath.blackGirl),
                              fit: BoxFit.fill)),
                      child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 30.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvetareIconWidget(
                              iconData: Icons.arrow_back,
                              bgColor: Color.fromARGB(133, 255, 255, 255),
                              iconColor: Colors.white,
                              ontap: () {
                                Get.back();
                              },
                            ),
                            CircleAvetareIconWidget(
                              iconData: Icons.more_vert,
                              bgColor: Color.fromARGB(133, 255, 255, 255),
                              iconColor: Colors.white,
                              ontap: () {
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
                                              othersProfileBottomBarList,
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -40.h,
                      left: 150.h,
                      child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            image: DecorationImage(
                                image: AssetImage(AssetsPath.blackGirl),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
                heightBox8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    QuantityDetailsWidget(
                      quantity: '17.4k',
                      title: 'Followers',
                      titleSize: 14,
                      quantitySize: 16,
                      ontap: () {
                        Get.to(FollowersScreen());
                      },
                    ),
                    QuantityDetailsWidget(
                      quantity: '17.5k',
                      title: 'Following',
                      titleSize: 14,
                      quantitySize: 16,
                      ontap: () {
                        Get.to(FollowingScreen());
                      },
                    ),
                  ],
                ),
                heightBox8,
                StraightLiner(),
                heightBox16,
                Text(
                  'Md Aminul Islam',
                  style: TextStyle(
                      fontSize: 18.h,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                heightBox8,
                SizedBox(
                  width: 300.w,
                  child: Text(
                    'Im Nammi Fatema. I have 2+ years of experience specializing in UI/UX design ',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                heightBox12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RectangleButtonWithIcon(
                      height: 38,
                      width: 170,
                      iconData: Icons.person_add,
                      iconSize: 24,
                      iconColor: Colors.white,
                      title: 'Follow',
                      titleSize: 14,
                      titleColor: Colors.white,
                      space: widthBox8,
                      ontap: () {},
                      borderRadius: 10,
                    ),
                    RectangleButtonWithIcon(
                      height: 38,
                      width: 170,
                      iconData: Icons.sms,
                      iconSize: 24,
                      iconColor: Colors.white,
                      title: 'Message',
                      titleSize: 14,
                      titleColor: Colors.white,
                      space: widthBox8,
                      ontap: () {
                        Get.to(ChatScreen());
                      },
                      borderRadius: 10,
                    ),
                  ],
                ),
                heightBox12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileBarIcon(
                      showProductList: showProductList,
                      ontap: () {
                        setState(() {
                          showProductList = true;
                        });
                      },
                      iconData: Icons.task_outlined,
                      isSelected: showProductList,
                    ),
                    ProfileBarIcon(
                      showProductList: showProductList,
                      ontap: () {
                        setState(() {
                          showProductList = false;
                        });
                      },
                      iconData: Icons.photo,
                      isSelected: !showProductList,
                    ),
                  ],
                ),
                heightBox12,
                Expanded(child: showProductList ? ProfileProduct() : PostGallery())
              ],
            ),
          ),
        
      ),
    );
  }
}
