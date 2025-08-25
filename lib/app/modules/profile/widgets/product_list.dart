import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:windx1999/photo_view.dart';

class ProductListTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String category;
  final Widget trailingIcon;
  final Widget? moreVertIcon;

  const ProductListTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.trailingIcon,
    this.moreVertIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Get.to(() => FullScreenImageViewer(imageUrl: imagePath));
        },
        child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.cover,
                ))),
      ),
      title: Text(title, style: TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          trailingIcon,
          if (moreVertIcon != null) moreVertIcon!,
        ],
      ),
    );
  }
}
