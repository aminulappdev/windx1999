import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/modules/homepage/widgets/bottonSheet_details_row.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen({super.key});

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
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
                  CustomAppBar(title: 'Aminul'),
                 heightBox14,
                 ButtonSheetDetailsRow(
                    icon: Icons.delete,
                    name: 'Delete',
                    ontap: () {},
                  ),
                  heightBox20,
                 
                  ButtonSheetDetailsRow(
                    icon: Icons.sms,
                    name: 'Report profile',
                    ontap: () {},
                  ),
                  heightBox20,
                
                  ButtonSheetDetailsRow(
                    icon: Icons.person_off,
                    name: 'Block',
                    ontap: () {},
                  ),
                 
              ],
            ),
          ),
        ),
      
    );
  }
}