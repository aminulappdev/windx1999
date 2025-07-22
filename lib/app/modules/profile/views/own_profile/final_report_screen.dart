import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/views/navigation_bar_screen.dart';
import 'package:windx1999/app/modules/homepage/controller/report_controller.dart';
import 'package:windx1999/app/modules/post/controller/all_post_controller.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class FinalReportScreen extends StatefulWidget {
  final String reportId;
  final String reason;
  final String reportType;
  const FinalReportScreen(
      {super.key,
      required this.reportId,
      required this.reason,
      required this.reportType});

  @override
  State<FinalReportScreen> createState() => _FinalReportScreenState();
}

class _FinalReportScreenState extends State<FinalReportScreen> {
  final ReportUserController reportUserController = ReportUserController();
  AllPostController allPostController = Get.put(AllPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
              CustomAppBar(title: ''),
              heightBox12,
              Text(
                'What is the reason for reporting this profile?',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              heightBox30,
              Text(
                'Thanks for taking the time to let us know whats going on. Reports like yours are an important part of keeping the Zheto community safe and secure. ',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              heightBox30,
              Text(
                'Thanks for taking the time to let us know whats going on. Reports like yours are an important part of keeping the Zheto community safe and secure. ',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              heightBox30,
              ElevatedButton(
                  onPressed: reportUser,
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> reportUser() async {
    final bool isSuccess = await reportUserController.reportkUser(
        widget.reportType,
        widget.reportId,
        StorageUtil.getData(StorageUtil.userId),
        widget.reason);
    if (isSuccess) {
      allPostController.getAllPost();
      if (mounted) {
        showSnackBarMessage(context, 'Report successfully done');
        Get.to(BottomNavBarScreen());
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, reportUserController.errorMessage ?? 'failed', true);
      }
    }
  }
}
