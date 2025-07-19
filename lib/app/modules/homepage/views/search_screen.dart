import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/controllers/add_chat_controller.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/all_users_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/follow_request_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/unFollow_request_controller.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/app/modules/profile/views/profile_screen.dart';
import 'package:windx1999/app/modules/profile/views/others_profile/others_profile_screen.dart';
import 'package:windx1999/get_storage.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AllUsersController allUsersController = Get.put(AllUsersController());
  final TextEditingController searchCtrl = TextEditingController();
  final ThemeController themeController = Get.find<ThemeController>();
  final FollowRequestController followRequestController =
      Get.put(FollowRequestController());
  final UnFollowRequestController unFollowRequestController =
      Get.put(UnFollowRequestController());
  final AddChatController addChatController = Get.put(AddChatController());
  String search = '';

  @override
  void initState() {
    super.initState();
    allUsersController.getAllUsers();
    // Listen to changes in the search field
    searchCtrl.addListener(() {
      setState(() {
        search = searchCtrl.text;
      });
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  // Follow request function
  Future<void> followRequest(String friendId) async {
    final bool isSuccess =
        await followRequestController.followRequest(friendId);
    if (isSuccess) {
      allUsersController.getAllUsers();
      addChatFriend(
        userId: StorageUtil.getData(StorageUtil.userId),
        friendId: friendId,
      );
      if (mounted) {
        showSnackBarMessage(context, 'Follow successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          followRequestController.errorMessage ?? 'Failed to follow',
          true,
        );
      }
    }
  }

  // Unfollow request function
  Future<void> unFollowRequest(String friendId) async {
    final bool isSuccess =
        await unFollowRequestController.unfollowRequest(friendId);
    if (isSuccess) {
      allUsersController.getAllUsers();
      if (mounted) {
        showSnackBarMessage(context, 'Unfollow successfully done');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          unFollowRequestController.errorMessage ?? 'Failed to unfollow',
          true,
        );
      }
    }
  }

  // Add chat friend function
  Future<void> addChatFriend(
      {required String userId, required String friendId}) async {
    final bool isSuccess = await addChatController.addChat(userId, friendId);
    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Added new chat');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          addChatController.errorMessage ?? 'Failed to add chat',
          true,
        ); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomBackground(
          child: Padding(
            padding: EdgeInsets.all(20.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar with theme support
                GetBuilder<ThemeController>(builder: (controller) {
                  return TextFormField(
                    controller: searchCtrl,
                    style: TextStyle(
                        color: controller.isDarkMode == true
                            ? Colors.white
                            : Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: controller.isDarkMode == true
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 0, 0, 0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: controller.isDarkMode == true
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Color.fromARGB(255, 0, 0, 0)),
                      fillColor: Color.fromARGB(116, 255, 255, 255),
                      filled: true,
                      border: inputBorder(),
                      enabledBorder: inputBorder(),
                      focusedBorder: inputBorder(),
                      errorBorder: inputBorder(),
                    ),
                  );
                }),
                heightBox20,
                Text(
                  'All users',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightBox12,
                GetBuilder<AllUsersController>(
                  builder: (controller) {
                    if (controller.inProgress) {
                      return Center(
                        child: SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      );
                    }

                    // Filter users based on search query
                    final filteredUsers =
                        controller.allUsersData?.where((user) {
                              final name = user.name?.toLowerCase() ?? '';
                              return search.isEmpty ||
                                  name.contains(search.toLowerCase());
                            }).toList() ??
                            [];

                    if (filteredUsers.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageContainer(
                                imagePath: AssetsPath.search,
                                height: 80.h,
                                width: 95.w,
                                borderRadius: 10.r,
                                borderColor: Colors.transparent,
                              ),
                              Text(
                                'No results for "${search.isEmpty ? 'Shimul' : search}"',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(
                                  'We couldn’t find any matching results. Please refine your search or check back later.',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = filteredUsers[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: GestureDetector(
                              onTap: () {
                                // Navigate to profile
                                Get.to(user.id ==
                                        StorageUtil.getData(StorageUtil.userId)
                                    ? ProfileScreen()
                                    : OthersProfileScreen(
                                        userId: user.id ?? ''));
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage(AssetsPath.blackGirl),
                                radius: 24.r,
                              ),
                            ),
                            title: GestureDetector(
                              onTap: () {
                                // Navigate to profile
                                Get.to(
                                    OthersProfileScreen(userId: user.id ?? ''));
                              },
                              child: Text(
                                user.name ?? 'Unknown',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              user.status ?? 'No status',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14.sp,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 110.w,
                              child: CustomRectangleButton(
                                bgColor: const Color(0xff6CC7FE),
                                height: 36.h,
                                width: 80.w,
                                radiusSize: 12.r,
                                textColor: Colors.white,
                                textSize: 12.sp,
                                text: user.isFollowing == true
                                    ? 'Unfollow'
                                    : 'Follow',
                                ontap: () {
                                  if (user.isFollowing == true) {
                                    unFollowRequest(user.id ?? '');
                                  } else {
                                    followRequest(user.id ?? '');
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
