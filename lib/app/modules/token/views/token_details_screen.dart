
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class TokekDetailsScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final String coin;
  final String time;

  const TokekDetailsScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.coin,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 84.h,
      width: width,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 17.r,
                      backgroundImage: AssetImage(AssetsPath.blackGirl),
                    ),
                    widthBox5,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                        heightBox8,
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 18.h,
                              color: Colors.white,
                            ),
                            widthBox5,
                            Text(
                              date,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.token_rounded,
                          color: Colors.white,
                        ),
                        widthBox8,
                        Text(
                          coin,
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        )
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.white,
                          size: 18.h,
                        ),
                        widthBox8,
                        Text(
                          time,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            heightBox20,
            StraightLiner()
          ],
        ),
      ),
    );
  }
}