import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ContentSreen extends StatelessWidget {
  const ContentSreen(
      {super.key, required this.appBarTitle, required this.data});
  final String appBarTitle;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox24,
                CustomAppBar(
                  title: appBarTitle,
                ),
                heightBox8,
                Text(
                  appBarTitle,
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                heightBox4,
                Html(data: data, style: {
                  "body": Style(
                      fontSize: FontSize(14.sp),
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
