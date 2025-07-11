import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/views/chat_list_screen.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/homepage/views/home_screen.dart';
import 'package:windx1999/app/modules/post/views/post_screen.dart';
import 'package:windx1999/app/modules/profile/views/profile_screen.dart';
import 'package:windx1999/app/modules/reels/views/reels_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});
 
  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  ThemeController themeController = Get.find<ThemeController>();
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int selectedPage = 0;
  List<Widget> screen = [
    HomeScreen(),
    ChatListScreen(),
    PostScreen(audienceType: 'public',),
    ReelsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (controller) {
      return Scaffold(
        backgroundColor: controller.isDarkMode == true
            ? Colors.black
            : Color.fromARGB(255, 108, 152, 254),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: selectedPage,
          items: [
            CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined, color: Colors.white, size: 30.h),
              label: selectedPage == 0 ? 'Home' : '',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.chat, color: Colors.white, size: 30.h),
              label: selectedPage == 1 ? 'Search' : '',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.control_point, color: Colors.white, size: 30.h),
              label: selectedPage == 2 ? 'Chat' : '',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.movie_edit, color: Colors.white, size: 30.h),
              label: selectedPage == 3 ? 'Feed' : '',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.perm_identity, color: Colors.white, size: 30.h),
              label: selectedPage == 4 ? 'Personal' : '',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ],
          color: controller.isDarkMode == true
              ? Color(0xff333333)
              : Color(0xff9C57FF),
          buttonBackgroundColor: controller.isDarkMode == true
              ? Color(0xff333333)
              : Color(0xff9C57FF),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: screen[selectedPage],
      );
    });
  }
}
