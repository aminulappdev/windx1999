import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/authentication/views/changed_password.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class YourAccount extends StatefulWidget {
  const YourAccount({super.key});

  @override
  State<YourAccount> createState() => _YourAccountState();
}

class _YourAccountState extends State<YourAccount> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Your Account',style: TextStyle(color: Colors.white,fontSize: 16),)),
          heightBox20,
          StraightLiner(),
          heightBox50,
          InkWell(
            onTap: () {
              Get.to(ChangedPasswordScreen());
            },
            child: Text('Changed password',style: TextStyle(color: Colors.white,fontSize: 14),)),
          heightBox20,
          StraightLiner(),
          heightBox20,
          Text('Two factor authentication',style: TextStyle(color: Colors.white,fontSize: 14),),
          heightBox20,
          StraightLiner(),
          heightBox100
        ],
      ),
    );
  }
}