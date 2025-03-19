import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/profile/views/edit_profile_screen.dart';
import 'package:windx1999/app/modules/profile/views/followers_screen.dart';
import 'package:windx1999/app/modules/profile/views/following_screen.dart';
import 'package:windx1999/app/modules/profile/views/post_gallery.dart';
import 'package:windx1999/app/modules/profile/views/profile_product.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/my_drawer.dart';
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
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          print('open drwer');
                           _scaffoldKey.currentState?.openDrawer();
                        },
                        child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(133, 255, 255, 255),
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            )),
                      )
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
                  ))
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
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
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
    ));
  }
}
