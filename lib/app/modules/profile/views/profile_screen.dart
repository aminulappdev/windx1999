import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/profile/views/set_up/edit_profile_screen.dart';
import 'package:windx1999/app/modules/profile/views/followers_screen.dart';
import 'package:windx1999/app/modules/profile/views/following_screen.dart';
import 'package:windx1999/app/modules/profile/views/post_gallery.dart';
import 'package:windx1999/app/modules/profile/views/profile_product.dart';
import 'package:windx1999/app/modules/profile/widgets/profile_bar_icon.dart';
import 'package:windx1999/app/modules/profile/widgets/quantity_details_widget.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/modules/profile/views/drawer/my_drawer.dart';
import 'package:windx1999/app/res/common_widgets/circle_aveture_icon.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showProductList = true;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
    child: Scaffold(
     key: _scaffoldKey,
      drawer: MyDrawer(),
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
                    padding: EdgeInsets.all(12.0.h),
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
                          iconData: Icons.settings,
                          bgColor: Color.fromARGB(133, 255, 255, 255),
                          iconColor: Colors.white,
                          ontap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40.h,
                  left: (width / 2) - (80.w / 2), 
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
                  quantity: '17.5k',
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
                  fontSize: 18.sp,
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
            ElevatedButton(
                onPressed: () {
                  Get.to(EditProfileScreen());
                },
                child: Text(
                  'Edit profile',
                  style: TextStyle(color: Colors.white),
                )),
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
    ));
  }
}
