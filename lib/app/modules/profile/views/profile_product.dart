import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/widgets/product_listTile.dart';
import 'package:windx1999/app/modules/wishlist/controller/all_wishlist_controller.dart';
import 'package:windx1999/app/modules/wishlist/views/add_wish_list_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/rectangle_button_with_icon.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ProfileProduct extends StatefulWidget {
  const ProfileProduct({super.key});

  @override
  State<ProfileProduct> createState() => _ProfileProductState();
}

class _ProfileProductState extends State<ProfileProduct> {
  final AllWishlistController allWishlistController =
      Get.put(AllWishlistController());

   @override
  void initState() {
    allWishlistController.getAllWishlist();
    super.initState();
  }   
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(CreateWishlistScreen());
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
          child: GetBuilder<AllWishlistController>(builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.all(8.0.h),
              child: ListView.builder(
                itemCount: controller.allWishlistData?.length,
                itemBuilder: (context, index) {
                  var wishlist = controller.allWishlistData?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ProductListTile(
                      imagePath: AssetsPath.blackGirl,
                      title: wishlist?.title ?? 'no title',
                      subtitle: wishlist?.description ?? 'no description',
                      category: 'Wishlist',
                      trailingIcon: RectangleButtonWithIcon(
                        height: 30,
                        width: 70,
                        bgColor: Color(0xff6CC7FE),
                        borderRadius: 8,
                        title: controller.allWishlistData?[index].price.toString() ?? 'no price',
                        titleColor: Colors.white,
                        titleSize: 12,
                        iconData: Icons.token_rounded,
                        iconColor: Colors.white,
                        iconSize: 16,
                        space: heightBox4,
                        ontap: () {},
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
