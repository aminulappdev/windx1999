import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/final_report_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final List<Map<String, dynamic>> reportReasons = [
    {'label': 'Offensive Content', 'isSelected': false},
    {'label': 'False Information', 'isSelected': false},
    {'label': 'Unwanted content.', 'isSelected': false},
    {'label': 'Harassment', 'isSelected': false},
    {'label': 'Fake Profile', 'isSelected': false},
    {'label': 'Something else', 'isSelected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBackground(
          child: Padding(
            padding:  EdgeInsets.all(16.0.h),
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
                heightBox12,
          
              Expanded(
                  child: ListView.builder(
                    itemCount: reportReasons.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors
                                  .white, // Change color of unchecked checkbox
                            ),
                            child: CheckboxListTile(
                              value: reportReasons[index]['isSelected'],
                              onChanged: (value) {
                                setState(() {
                                  reportReasons[index]['isSelected'] = value!;
                                });
                              },
                              title: Text(
                                reportReasons[index]['label'],
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              activeColor: Colors
                                  .blue, 
                              checkColor: Colors
                                  .white, 
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 2), 
                            ),
                          ),
                          heightBox12,
                          StraightLiner()
                        ],
                      );
                    },
                  ),
                ),
          
                ElevatedButton(
                    onPressed: () {
                      Get.to(FinalReportScreen());
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    )),
                heightBox100,
                heightBox50
              ],
            ),
          ),
        ),
      
    );
  }
}
