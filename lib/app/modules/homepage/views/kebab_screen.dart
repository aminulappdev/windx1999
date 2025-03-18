import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/modules/homepage/widgets/kebab_details_row.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class KebabScreen extends StatefulWidget {
  const KebabScreen({super.key});

  @override
  State<KebabScreen> createState() => _KebabScreenState();
}

class _KebabScreenState extends State<KebabScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Padding(
            padding:
                 EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w, bottom: 20.h),
            child: Column(
              children: [
                heightBox20,
                KebabDetailsRow(
                  icon: Icons.bookmark,
                  name: 'Save post',
                  ontap: () {},
                ),
                heightBox20,
               
                KebabDetailsRow(
                  icon: Icons.copy,
                  name: 'Copy link',
                  ontap: () {},
                ),
                heightBox20,
              
                KebabDetailsRow(
                  icon: Icons.visibility_off,
                  name: 'Hide post',
                  ontap: () {},
                ),
                heightBox20,
                KebabDetailsRow(
                  icon: Icons.person_remove,
                  name: 'Unfollow',
                  ontap: () {},
                ),
                heightBox20,
               
                KebabDetailsRow(
                  icon: Icons.person_off,
                  name: 'Block',
                  ontap: () {},
                ),
                heightBox20,
              
                KebabDetailsRow(
                  icon: Icons.smart_display_outlined,
                  name: 'Report profile',
                  ontap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

