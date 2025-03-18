import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StraightLiner extends StatelessWidget {
  const StraightLiner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.8.h,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
    );
  }
}