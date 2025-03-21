import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/others_profile_screen.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class CustomChatAppBar extends StatefulWidget {
  
  final String name;
  final String activeStatus;
  final String imagePath;
  final bool isActive;
  final VoidCallback actionOntap;
  const CustomChatAppBar({
    super.key,
    required this.name, required this.activeStatus, required this.imagePath, required this.isActive, required this.actionOntap,
  });

  @override
  State<CustomChatAppBar> createState() => _CustomChatAppBarState();
}

class _CustomChatAppBarState extends State<CustomChatAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            widthBox4,
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            widthBox8,
            InkWell(
              onTap: () {
                Get.to(OthersProfileScreen());
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(widget.imagePath),
                    radius: 24.r,
                   
                  ),
                  widthBox5,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.activeStatus,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          widthBox8,
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: widget.isActive ? Colors.green : Colors.red,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        InkWell(
          onTap: widget.actionOntap,
          child: Icon(
            Icons.error_outline,
            size: 30.h,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
