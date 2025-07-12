
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ProductListTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String category;
  final Widget trailingIcon;
  const ProductListTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            ImageContainer(
                imagePath: imagePath,
                height: 62,
                width: 60,
                borderRadius: 8,
                borderColor: Colors.transparent),
            widthBox8,
            SizedBox(
              width: 235.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  heightBox4,
                  SizedBox(
                    width: 230.w,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      subtitle,
                      style: TextStyle(
                         
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  heightBox4,
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 3.r,
                        backgroundColor: Colors.blue,
                      ),
                      widthBox8,
                      Text(
                        category,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      
         trailingIcon
      ],
    );
  }
}