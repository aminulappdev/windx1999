import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/widgets/product_listTile.dart';
import 'package:windx1999/app/modules/wishlist/controller/all_others_wishlist_controller.dart';
import 'package:windx1999/app/res/common_widgets/rectangle_button_with_icon.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class OthersProfileProduct extends StatefulWidget {
  final String userId;
  const OthersProfileProduct({super.key, required this.userId});

  @override
  State<OthersProfileProduct> createState() => _OthersProfileProductState();
}

class _OthersProfileProductState extends State<OthersProfileProduct> {
  final AllOthersWishlistController allOthersWishlistController =
      Get.put(AllOthersWishlistController());

  @override
  void initState() {
    allOthersWishlistController.getAllWishlistByUser(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GetBuilder<AllOthersWishlistController>(builder: (controller) {
            if (controller.inProgress) {
              return SizedBox(
                  height: 220,
                  child: const Center(child: CircularProgressIndicator()));
            }
            if (controller.allWishlistData!.isEmpty) {
              return SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    'No wishlist available',
                    style: TextStyle(color: Colors.white),
                  )));
            }
            return Padding(
              padding: EdgeInsets.all(8.0.h),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.allWishlistData?.length,
                itemBuilder: (context, index) {
                  var wishlist = controller.allWishlistData?[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ProductListTile(
                      imagePath: wishlist!.content.isNotEmpty
                          ? wishlist.content[0]
                          : 'https://fastly.picsum.photos/id/376/200/300.jpg?hmac=gH_OWo7cSHKwU34tPONXdcjJuObIx0_5IswQHBjTXxg',
                      title: wishlist.title ?? 'no title',
                      subtitle: wishlist.description ?? 'no description',
                      category: 'Wishlist',
                      trailingIcon: RectangleButtonWithIcon(
                        height: 30,
                        width: 70,
                        bgColor: Color(0xff6CC7FE),
                        borderRadius: 8,
                        title: controller.allWishlistData?[index].price
                                .toString() ??
                            'no price',
                        titleColor: Colors.white,
                        titleSize: 12,
                        iconData: Icons.token_rounded,
                        iconColor: Colors.white,
                        iconSize: 16,
                       
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
