import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package for navigation
import 'package:windx1999/app/modules/homepage/views/botton_sheet_screen.dart';
import 'package:windx1999/app/modules/others_profile/views/block_user.dart';
import 'package:windx1999/app/modules/others_profile/views/report_screen.dart';
import 'package:windx1999/app/modules/profile/views/edit_profile_screen.dart';
import 'package:windx1999/app/modules/profile/views/followers_screen.dart';
import 'package:windx1999/app/modules/profile/views/following_screen.dart';
import 'package:windx1999/app/modules/profile/views/post_gallery.dart';
import 'package:windx1999/app/modules/profile/views/profile_product.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class OthersProfileScreen extends StatefulWidget {
  const OthersProfileScreen({super.key});

  @override
  State<OthersProfileScreen> createState() => _OthersProfileScreenState();
}

class _OthersProfileScreenState extends State<OthersProfileScreen> {
  bool showProductList = false;

  List<Map<String, dynamic>> othersProfileBottomList = [
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetsPath.blackGirl),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(133, 255, 255, 255),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
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
                                          othersProfileBottomList,
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(133, 255, 255, 255),
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: 150,
                  child: Container(
                    height: 80,
                    width: 80,
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
                InkWell(
                  onTap: () {
                    Get.to(FollowersScreen());
                  },
                  child: Column(
                    children: [
                      Text(
                        '17.5k',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(FollowingScreen());
                  },
                  child: Column(
                    children: [
                      Text(
                        '1.5k',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        'Following',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            heightBox8,
            StraightLiner(),
            heightBox16,
            Text(
              'Md Aminul Islam',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            heightBox8,
            SizedBox(
              width: 300,
              child: Text(
                'Im Nammi Fatema. I have 2+ years of experience specializing in UI/UX design ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            heightBox12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 170,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(EditProfileScreen());
                      },
                      child: Text(
                        'Edit profile',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  width: 170,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(EditProfileScreen());
                      },
                      child: Text(
                        'Edit profile',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
            heightBox12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            showProductList = true;
                          });
                        },
                        child: Icon(
                          Icons.note,
                          color: showProductList
                              ? Colors.white
                              : Color.fromARGB(119, 255, 255, 255),
                          size: 30,
                        )),
                    heightBox10,
                    Container(
                      height: 1,
                      width: width / 2,
                      color: showProductList
                          ? Colors.white
                          : Color.fromARGB(119, 255, 255, 255),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            showProductList = false;
                          });
                        },
                        child: Icon(Icons.photo,
                            size: 30,
                            color: showProductList
                                ? Color.fromARGB(119, 255, 255, 255)
                                : Colors.white)),
                    heightBox10,
                    Container(
                      height: 1,
                      width: width / 2,
                      color: showProductList
                          ? Color.fromARGB(119, 255, 255, 255)
                          : Colors.white,
                    )
                  ],
                )
              ],
            ),
            heightBox12,
            Expanded(child: showProductList ? ProfileProduct() : PostGallery())
          ],
        ),
      ),
    );
  }
}
