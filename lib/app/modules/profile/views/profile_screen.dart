import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/profile/views/edit_profile_screen.dart';
import 'package:windx1999/app/modules/profile/views/followers_screen.dart';
import 'package:windx1999/app/modules/profile/views/following_screen.dart';
import 'package:windx1999/app/modules/profile/views/post_gallery.dart';
import 'package:windx1999/app/modules/profile/views/profile_product.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/modules/profile/widgets/my_drawer.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showProductList = false;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: Column(
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
                  left: 150.w,
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
                  ))
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
                iconData: Icons.note,
              ),
              ProfileBarIcon(
                showProductList: showProductList,
                ontap: () {
                  setState(() {
                    showProductList = false;
                  });
                },
                iconData: Icons.photo,
              ),
            ],
          ),
          heightBox12,
          Expanded(child: showProductList ? ProfileProduct() : PostGallery())
        ],
      ),
    ));
  }
}

class ProfileBarIcon extends StatelessWidget {
  const ProfileBarIcon({
    super.key,
    required this.showProductList,
    required this.ontap,
    required this.iconData,
  });

  final bool showProductList;
  final IconData iconData;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: ontap,
            child: Icon(
              iconData,
              color: showProductList
                  ? Colors.white
                  : Color.fromARGB(119, 255, 255, 255),
              size: 30,
            )),
        heightBox10,
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width / 2,
          color: showProductList
              ? Colors.white
              : Color.fromARGB(119, 255, 255, 255),
        )
      ],
    );
  }
}

class QuantityDetailsWidget extends StatelessWidget {
  final String quantity;
  final String title;
  final double quantitySize;
  final double titleSize;
  final VoidCallback ontap;
  const QuantityDetailsWidget({
    super.key,
    required this.quantity,
    required this.title,
    required this.quantitySize,
    required this.titleSize,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Text(
            quantity,
            style: TextStyle(
                fontSize: quantitySize.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CircleAvetareIconWidget extends StatelessWidget {
  final Color bgColor;
  final Color iconColor;
  final double radius;
  final IconData iconData;
  final VoidCallback ontap;

  const CircleAvetareIconWidget({
    super.key,
    required this.bgColor,
    this.radius = 20,
    required this.iconData,
    required this.ontap,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: CircleAvatar(
          radius: radius,
          backgroundColor: bgColor,
          child: Icon(
            iconData,
            color: iconColor,
          )),
    );
  }
}
