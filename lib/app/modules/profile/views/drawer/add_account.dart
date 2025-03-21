import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Your Account',
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          )),
          heightBox20,
          StraightLiner(),
          heightBox20,
          CustomRectangleButton(
            bgColor: Colors.blue,
            height: 48,
            width: 319,
            radiusSize: 50,
            text: 'Log In an others account',
            ontap: () {},
            textColor: Colors.white,
            borderColor: Colors.transparent,
          ),
          heightBox16,
          CustomRectangleButton(
            bgColor: Colors.white,
            height: 48,
            width: 319,
            radiusSize: 50,
            text: 'Create new account',
            ontap: () {},
            textColor: Colors.blue,
          ),
          heightBox40
        ],
      ),
    );
  }
}
