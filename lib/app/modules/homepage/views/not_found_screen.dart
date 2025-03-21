import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class NotFoundSearchScreen extends StatefulWidget {
  const NotFoundSearchScreen({super.key});

  @override
  State<NotFoundSearchScreen> createState() => _NotFoundSearchScreenState();
}

class _NotFoundSearchScreenState extends State<NotFoundSearchScreen> {
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
              CustomSearchBar(),
              heightBox50,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent search history',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text( 
                      'Clear all',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
              heightBox100,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageContainer(
                      imagePath: AssetsPath.search,
                      height: 80.h,
                      width: 95.w,
                      borderRadius: 10.r,
                      borderColor: Colors.transparent),
                  Text(
                    'No results for”Shimul”',
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'We couldn’t find any matching results. Please refine your search orcheck back later.”',
                      style: TextStyle(fontSize: 16.h, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
