import 'package:flutter/material.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class FinalReportScreen extends StatefulWidget {
  const FinalReportScreen({super.key});

  @override
  State<FinalReportScreen> createState() => _FinalReportScreenState();
}

class _FinalReportScreenState extends State<FinalReportScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: ''),
              heightBox12,
              Text(
                'What is the reason for reporting this profile?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              heightBox30,
              Text(
                'Thanks for taking the time to let us know whats going on. Reports like yours are an important part of keeping the Zheto community safe and secure. ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              heightBox30,
              Text(
                'Thanks for taking the time to let us know whats going on. Reports like yours are an important part of keeping the Zheto community safe and secure. ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              heightBox30,
              ElevatedButton(
                  onPressed: () {},
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
}
