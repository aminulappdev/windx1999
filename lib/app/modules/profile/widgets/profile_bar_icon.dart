
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ProfileBarIcon extends StatelessWidget {
  const ProfileBarIcon({
    super.key,
    required this.showProductList,
    required this.ontap,
    required this.iconData,
    required this.isSelected,
  });

  final bool showProductList;
  final bool isSelected;
  final IconData iconData;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Icon(
            iconData,
            color:
                isSelected ? Colors.white : Color.fromARGB(119, 255, 255, 255),
            size: 30.h,
          ),
        ),
        heightBox10,
        Container(
          height: 1.h,
          width: MediaQuery.of(context).size.width / 2,
          color: isSelected ? Colors.white : Color.fromARGB(119, 255, 255, 255),
        ),
      ],
    );
  }
}
