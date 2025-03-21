import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomBackground(
        child: Padding(
          padding:  EdgeInsets.all(20.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             heightBox20,
                  CustomAppBar(title: 'Notification'),
              heightBox50,
              Text(
                'Today',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
              heightBox12,
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(AssetsPath.blackGirl),
                      ),
                      title: Text(
                        'Aminul islam',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Aminul islam messeage',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: CustomRectangleButton(
                          bgColor: Color(0xff6CC7FE),
                          height: 36.h,
                          width: 97.w,
                          radiusSize: 12,
                          textColor: Colors.white,
                          textSize: 12.sp,
                          text: 'Follow back',
                          ontap: () {}),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
