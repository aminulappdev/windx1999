import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/profile/views/set_up/edit_profile_screen.dart';
import 'package:windx1999/app/modules/profile/views/followers_screen.dart';
import 'package:windx1999/app/modules/profile/views/following_screen.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/post_gallery.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/profile_product.dart';
import 'package:windx1999/app/modules/profile/widgets/profile_bar_icon.dart';
import 'package:windx1999/app/modules/profile/widgets/quantity_details_widget.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/modules/profile/views/drawer/my_drawer.dart';
import 'package:windx1999/app/res/common_widgets/circle_aveture_icon.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ProfileController profileController = Get.put(ProfileController());

  bool showProductList = true;

  @override
  void initState() {
    super.initState();
    // Schedule getMyProfile to run after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getMyProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
        body: GetBuilder<ProfileController>(builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomBackground(
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
                          image: controller.profileData?.banner != null
                              ? NetworkImage(controller.profileData!.banner!)
                              : const AssetImage(AssetsPath.blackGirl),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvetareIconWidget(
                              iconData: Icons.arrow_back,
                              bgColor: const Color.fromARGB(133, 255, 255, 255),
                              iconColor: Colors.white,
                              ontap: () {
                                Get.back();
                              },
                            ),
                            CircleAvetareIconWidget(
                              iconData: Icons.settings,
                              bgColor: const Color.fromARGB(133, 255, 255, 255),
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
                            image: controller.profileData?.photoUrl != null
                                ? NetworkImage(
                                    controller.profileData!.photoUrl!)
                                : const AssetImage(AssetsPath.blackGirl),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                heightBox8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    QuantityDetailsWidget(
                      quantity:
                          controller.profileData?.followers.toString() ?? '0',
                      title: 'Followers',
                      titleSize: 14,
                      quantitySize: 16,
                      ontap: () {
                        Get.to(() => FollowersScreen(
                              userId: StorageUtil.getData(StorageUtil.userId),
                            ));
                      },
                    ),
                    QuantityDetailsWidget(
                      quantity:
                          controller.profileData?.following.toString() ?? '0',
                      title: 'Following',
                      titleSize: 14,
                      quantitySize: 16,
                      ontap: () {
                        Get.to(() => FollowingScreen(
                              userId: StorageUtil.getData(StorageUtil.userId),
                            ));
                      },
                    ),
                  ],
                ),
                heightBox8,
                const StraightLiner(),
                heightBox16,
                Text(
                  controller.profileData?.name ?? 'No name',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                heightBox8,
                SizedBox(
                  width: 300.w,
                  child: Text(
                    controller.profileData?.bio ?? 'No bio available',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                heightBox12,
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const EditProfileScreen());
                  },
                  child: const Text(
                    'Edit profile',
                    style: TextStyle(color: Colors.white),
                  ),
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
                Expanded(
                  child: showProductList
                      ? const ProfileProduct()
                      : const PostGallery(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
