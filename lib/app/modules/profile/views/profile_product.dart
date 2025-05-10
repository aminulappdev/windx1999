import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/widgets/product_listTile.dart';
import 'package:windx1999/app/modules/wishlist/views/wish_list.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/rectangle_button_with_icon.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ProfileProduct extends StatelessWidget {
  const ProfileProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(WishlistScreen());
          },
          child: Container(
            height: 40.h,
            width: 300.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // ignore: deprecated_member_use
                color: Color(0xffFFFFFF).withOpacity(0.50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add), Text('Add more wishlist')],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return ProductListTile(
                  imagePath: AssetsPath.blackGirl,
                  title: 'I Phone 14 pro max',
                  subtitle: '"Capturing moments that speak.',
                  category: 'Wishlist',
                  trailingIcon: RectangleButtonWithIcon(
                    height: 30,
                    width: 70,
                    bgColor: Color(0xff6CC7FE),
                    borderRadius: 8,
                    title: '5.5k',
                    titleColor: Colors.white,
                    titleSize: 12,
                    iconData: Icons.token_rounded,
                    iconColor: Colors.white,
                    iconSize: 16,
                    space: heightBox4,
                    ontap: () {},
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
