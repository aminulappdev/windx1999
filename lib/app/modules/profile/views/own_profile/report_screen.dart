import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/final_report_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ReportScreen extends StatefulWidget {
  final String reportType;
  final String reportId;

  const ReportScreen({
    super.key,
    required this.reportId,
    required this.reportType,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final List<Map<String, dynamic>> reportReasons = [];

  // Variable to store the selected reason
  String? selectedReason;

  @override
  void initState() {
    super.initState();
    // Initialize reasons once
    if (widget.reportType == "User") {
      reportReasons.addAll([
        {'label': 'Offensive Content', 'isSelected': false},
        {'label': 'False Information', 'isSelected': false},
        {'label': 'Unwanted content.', 'isSelected': false},
        {'label': 'Harassment', 'isSelected': false},
        {'label': 'Fake Profile', 'isSelected': false},
        {'label': 'Something else', 'isSelected': false},
      ]);
    } else {
      reportReasons.addAll([
        {'label': 'Nudity or Sexual Content', 'isSelected': false},
        {'label': 'Hate Speech or Symbols', 'isSelected': false},
        {'label': 'Harassment or Bullying', 'isSelected': false},
        {'label': 'Violence or Threatening Behavior', 'isSelected': false},
        {'label': 'False Information or Scam', 'isSelected': false},
        {'label': 'Spam or Irrelevant Content', 'isSelected': false},
      ]);
    }
  }

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
                  color: Colors.white,
                ),
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
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: CheckboxListTile(
                            value: reportReasons[index]['isSelected'],
                            onChanged: (value) {
                              setState(() {
                                // Deselect all
                                for (var reason in reportReasons) {
                                  reason['isSelected'] = false;
                                }
                                // Select current
                                reportReasons[index]['isSelected'] = value!;
                                selectedReason = value
                                    ? reportReasons[index]['label']
                                    : null;
                              });
                            },
                            title: Text(
                              reportReasons[index]['label'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                        heightBox12,
                        const StraightLiner(),
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedReason != null) {
                    Get.to(
                      FinalReportScreen(
                        reportType: widget.reportType,
                        reason: selectedReason!,
                        reportId: widget.reportId,
                      ),
                    );
                  } else {
                    showSnackBarMessage(
                      context,
                      'Please select a reason before confirming.',
                      true,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              heightBox100,
              heightBox50,
            ],
          ),
        ),
      ),
    );
  }
}
